{% extends "section.md" %}

{% block body %}
|   |
|---|---|
{% for item in items %}
| <span style="white-space:nowrap">{{ item.date }}</span> | {{ item.org }} |
| | _{{ item.position }}_ |
{% endfor %}
{% endblock body %}
