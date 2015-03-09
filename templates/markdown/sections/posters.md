{% extends "section.md" %}

{% block body %}
|   |
|---|---|
{% for poster in items %}
| {{ poster.date }} | {{ poster.venue }} {{ poster.location}} |
| | {% if poster.title %} {{ poster.title }} {% endif %} |
{% endfor %}
{% endblock body %}
