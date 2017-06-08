{% extends "section.md" %}

{% block body %}

|   |
|---|---|
{% for conf in items %}
|  <span class="dates">{{ conf.date }}</span> | **{{ conf.venue }}, {{ conf.location }}** |
{% if conf.type %}| {{ conf.type }} | {% if conf.title %}_{{ conf.title }}_{% endif %} |{% endif %}
{% endfor %}
{% endblock body %}
