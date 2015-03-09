{% extends "section.md" %}

{% block body %}

|   |
|---|---|
{% for award in items %}
| <span class="dates">{{ award.dates }}</span> | **{{ award.name }}** |
| | _{{ award.title }}_ |
{% if award.descr %}| | {{ award.descr }} |{% endif %} 
{% endfor %}
{% endblock body %}
