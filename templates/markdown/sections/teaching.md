{% extends "section.md" %}

{% block body %}

|   |
|---|---|
{% for item in items %}
| <span class="dates">{{ item.dates }}</span> | **{{ item.university }}** |
| | _{{ item.course.name }}, {{ item.details }}_ |
{% endfor %}
{% endblock body %}
