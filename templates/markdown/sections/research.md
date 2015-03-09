{% extends "section.md" %}

{% block body %}
|   |
|---|---|
{% for r in items %}
| <span style="white-space:nowrap">{{ r.dates }}</span> | __{{ r.place }}, {{ r.location }}__ |
|               | _{{ r.title }}, Laboratory of {{ r.advisor }}_ |
|               | {{ r.details}} |
{% endfor %}

{% endblock body %}
