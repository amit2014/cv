{% extends "section.md" %}

{% block body %}

|   |
|---|---|
{% for r in items %}
| <span class="dates">{{ r.dates }}</span> | __{{ r.place }}, {{ r.location }}__ |
|               | _{{ r.title }}, Laboratory of {{ r.advisor }}_ |
|               | {% if r.details is string %} {{ r.details }} {% else %} {% for item in r.details %} * {{ item }} {% endfor %} {% endif %} |
{% endfor %}

{% endblock body %}
