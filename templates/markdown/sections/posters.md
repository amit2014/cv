{% extends "section.md" %}

{% block body %}

|   |
|---|---|
{% for poster in items %}
|  <span class="dates">{{ poster.date }}</span> | **{{ poster.venue }} {{ poster.location}}** |
| | {% if poster.title %} _{{ poster.title }}_ {% endif %} |
{% endfor %}
{% endblock body %}
