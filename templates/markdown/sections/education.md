{% extends "section.md" %}

{% block body %}

|   |
|---|---|
{% for school in items %}
| <span class="dates">{{ school.dates }}</span> | **{{ school.degree }}, {{ school.department }}** |
| | _{{ school.school }}, {{ school.location }}_ |
{% endfor %}
{% endblock body %}
