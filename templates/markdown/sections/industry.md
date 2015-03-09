{% extends "section.md" %}

{% block body %}
|   |
|---|---|
{% for i in items %}
| <span style="white-space:nowrap">{{ i.dates }}</span> | {{ i.place }}, {{ i.location }} |
| | _{{ i.title }}_ |
{% endfor %}
{% endblock body %}
