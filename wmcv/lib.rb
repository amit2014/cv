require 'rubygems'
require 'open-uri'
require 'curb'
require 'erubis'

class Hash
  def method_missing(name, *args)
    return self[name.to_s]
  end
end

def read_file(path)
  s = ""
  File.open(path, "r") do |file|
    s = file.read
  end
  return s
end

def write_file(path, content)
  File.open(path, "w") do |file|
    file.write content
  end
end

def interpolate(str, env)
  return Erubis::Eruby.new(str).result(env)
end

def login(login_url_template, confirm_url_template, user, pass)
  env = { :user => user, :pass => pass }
  url = interpolate(login_url_template, env)

  c = Curl::Easy.new(url)
  cookies = {}
  c.on_header do |h|
    if h.chomp =~ /Set-Cookie: (wiki[^=]*)=([^;]+)/
      cookies[$1] = $2
    end
    h.size
  end
  c.http_post
  
  if !confirm_url_template.nil?
    prefix = c.body_str.scan(/cookieprefix=\"(.*?)\"/)[0][0]
    token = c.body_str.scan(/token=\"(.*?)\"/)[0][0]
    env[:token] = token
    
    url = interpolate(confirm_url_template, env)

    c = Curl::Easy.new(url)
    s = ""
    cookies.each_pair do |k, v|
      s += '; ' unless s.empty?
      s += "#{k}=#{v}"
    end
    c.cookies = s
    c.http_post
    
    userid = c.body_str.scan(/lguserid=\"(.*?)\"/)[0][0]
    
    cookies[prefix + "UserName"] = user
    cookies[prefix + "UserID"] = userid
    cookies[prefix + "Token"] = token
  end
  
  raise "Invalid Login" unless c.body_str =~ /Success/

  return cookies
end

def read_url(url, headers=nil, timeout_sec=60, redir_limit=10)
  status = :ok
  content = nil

  begin
    response = Curl::Easy.perform(url) do |c|
      #c.on_debug {|type, data| $log.trace data }
      unless timeout_sec.nil? || timeout_sec <= 0
        c.timeout = timeout_sec
      end
      unless redir_limit.nil? || redir_limit <= 0
        c.follow_location = true
        c.max_redirects = redir_limit
      end
      unless headers.nil?
        headers.each_pair do |name, value|
          if value.is_a?(Hash)
            s = ''
            value.each_pair do |k, v|
              s += '; ' unless s.empty?
              s += "#{k}=#{v}"
            end
            c.headers[name] = s
          else
            c.headers[name] = value
          end
        end
      end
      if defined? $opt[:cookie_file]
        c.enable_cookies = true
        c.cookiefile = $opt[:cookie_file]
        c.cookiejar = $opt[:cookie_file]
      end
    end
    content = response.body_str
  rescue Exception => e
    status = e.is_a?(Curl::Err::TimeoutError) ? :timeout : :error
    content = e
  end
  return status, content
end

def parse_wm_template(template, prefix='Template:')
  return nil unless match = template.match(/\{\{#{Regexp.quote(prefix)}([^\|]+)(.+)\}\}/m)
  h = { '__class__' => match[1] }
  open = 0
  seensep = false
  key = value = nested = nil
  match[2].each_char do |c|
    if c == '{' && seensep
      nested ||= ''
      nested += c
      open += 1
      value = [] if open == 2 && value.nil?
    elsif c == '}' && seensep && !nested.nil?
      nested += c
      open -= 1
      if open == 0
        value << parse_wm_template(nested, prefix)
        nested = nil
      end
    elsif open >= 2
      nested += c
    else
      if open > 0
        value ||= ''
        value += nested
        nested = nil
      end
      if c == '|'
        h[key] = value unless key.nil?
        key = value = nil
        seensep = false
      elsif c =~ /\s/ && (c != ' ' || value.nil? || value.is_a?(Array))
        next
      elsif c == '='
        seensep = true
      elsif seensep
        value ||= ''
        value += latex_escape(c)
      else
        key ||= ''
        key += c
      end
    end
  end
  h[key] = value unless key.nil?
  return h
end

# escape reserved LaTeX characters
def latex_escape(c)
  c =~ /&/ ? '\\' + c : c
end
