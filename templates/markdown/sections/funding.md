{% extends "section.md" %}

{% block body %}
|   |
|---|---|
{% for award in items %}
| <span style="white-space:nowrap">{{ award.date }}</span> | {{ award.name }} |
| | _{{ award.title }}_ |
| | {{ award.descr }} |
{% endfor %}
{% endblock body %}
