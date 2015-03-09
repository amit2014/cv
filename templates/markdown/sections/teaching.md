{% extends "section.md" %}

{% block body %}
|   |
|---|---|
{% for item in items %}
| <span style="white-space:nowrap">{{ item.dates }}</span> | {{ item.university }} |
| | _{{ item.course.name }}, {{ item.details }}_ |
{% endfor %}
{% endblock body %}
