{% extends "section.md" %}

{% block body %}
|   |
|---|---|
{% for school in items %}
| <span style="white-space:nowrap">{{ school.dates }}</span> | {{ school.degree }}, {{ school.department }} |
| | _{{ school.school }}, {{ school.location }}_ |
{% endfor %}
{% endblock body %}
