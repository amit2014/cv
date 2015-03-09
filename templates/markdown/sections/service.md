{% extends "section.md" %}

{% block body %}

|   |
|---|---|
{% for item in items %}
| <span class="dates">{{ item.dates }}</span> | **{{ item.org }}** |
| | _{{ item.position }}_ |
{% endfor %}
{% endblock body %}
