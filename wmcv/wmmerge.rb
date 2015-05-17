#!/usr/bin/ruby
# Merges values from a WikiMedia template instance with an ERB template.
# Usage: wmmerge.rb wm_url erb_file out_file
require 'lib.rb'
require 'rubygems'
require 'erubis'

url, user, pass, page, erb, out = ARGV
login_url = url + '/api.php?action=login&format=xml&lgname=<%=user%>&lgpassword=<%=pass%>'
confirm_url = login_url + '&lgtoken=<%=token%>'
page_url  = url + "/index.php?action=raw&title=#{page}"

template_resp = read_url(page_url, { 'Cookie:' => login(login_url, confirm_url, user, pass) })
raise "Read template failed" unless template_resp[0] == :ok

env = parse_wm_template(template_resp[1])
write_file(out, Erubis::Eruby.new(read_file(erb)).result(env))
