{% extends "section.md" %}

{% block body %}
|   |
|---|---|
{% for talk in items %}
| {{ talk.date }} | {{ talk.venue }}, {{ talk.location }} |
| | {% if talk.title %} {{ talk.title }} {% endif %} |
{% endfor %}
{% endblock body %}
