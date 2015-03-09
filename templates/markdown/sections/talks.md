{% extends "section.md" %}

{% block body %}

|   |
|---|---|
{% for talk in items %}
|  <span class="dates">{{ talk.date }}</span> | **{{ talk.venue }}, {{ talk.location }}** |
{% if talk.title %}| | _{{ talk.title }}_ |{% endif %} 
{% endfor %}
{% endblock body %}
