---
permalink: /
title: "Hello World 👋"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---

I'm Long Tran. This is a personal website to record, journal, and tracking my academic journey in software developemnt, application design for heterogenous systems.

As a First Year PhD Student, I'm interested in problems and solutions focusing on solving I/O bottlenecks, memory bottlenecks, parallel mechanisms. I'm working in [Systems Research Lab](https://people.cs.rutgers.edu/~sk2113/rsrl.html) at [Rugters](https://www.cs.rutgers.edu/) - New Brunswick, advised by Prof. [Sudarsun Kannan](https://people.cs.rutgers.edu/~sk2113/).

---
# CV
[My Resume]({{ '/files/resume.pdf' | relative_url }})

{% include base_path %}

# Teaching
{% for post in site.teaching reversed %}
  {% include archive-single.html %}
{% endfor %}