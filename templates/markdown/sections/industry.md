{% extends "section.md" %}

{% block body %}

|   |
|---|---|
{% for i in items %}
| <span class="dates">{{ i.dates }}</span> | **{{ i.place }}, {{ i.location }}** |
| | _{{ i.title }}_ |
{% endfor %}
{% endblock body %}
