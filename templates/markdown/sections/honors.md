{% extends "section.md" %}

{% block body %}

|   |
|---|---|
{% for award in items %}
| <span class="dates">{{ award.dates }}</span> | **{{ award.title }}** |
| | _{{ award.from }}_ |
| | {{ award.descr }} |
{% endfor %}
{% endblock body %}
