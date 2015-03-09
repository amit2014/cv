{% extends "section.md" %}

{% block body %}
|   |
|---|---|
{% for award in items %}
| <span style="white-space:nowrap">{{ award.dates }}</span> | {{ award.title }} |
| | _{{ award.from }}_ |
| | {{ award.descr }} |
{% endfor %}
{% endblock body %}
