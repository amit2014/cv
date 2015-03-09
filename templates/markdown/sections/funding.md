{% extends "section.md" %}

{% block body %}

|   |
|---|---|
{% for award in items %}
| <span class="dates">{{ award.dates }}</span> | **{{ award.name }}** |
| | _{{ award.title }}_ |
| | {{ award.descr }} |
{% endfor %}
{% endblock body %}
