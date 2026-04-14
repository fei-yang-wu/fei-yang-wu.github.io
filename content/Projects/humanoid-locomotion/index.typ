#import "../../index.typ": template, tufted
#show: template.with(
  title: "Learn to Teach",
  description: "Learn to Teach project overview",
  lang: "en",
)

= Learn to Teach: Improve Sample Efficiency in Teacher-student Learning for Sim-to-Real Transfer

This project focuses on teacher-student learning for humanoid robot locomotion with strong sample efficiency in simulation and transfer robustness.

We apply Learn to Teach to the Digit robot for robust sim-to-real transfer across diverse terrains and conditions.

The key idea is to optimize a teacher policy that produces informative curricula for a student locomotion policy, improving data efficiency while maintaining stable transfer behavior.

#let icon(path) = image(path, width: 0.95em)

== Links

- #link("/Projects/")[#icon("../../../assets/icons/back.svg") Back to Projects]
- #link("https://lidar-learn-to-teach.github.io/")[#icon("../../../assets/icons/website.svg") Project website]
- #link("https://arxiv.org/abs/2402.06783")[#icon("../../../assets/icons/paper.svg") Paper]
- #link("https://www.youtube.com/watch?v=pkw4gxOn6Ho")[#icon("../../../assets/icons/video.svg") Video]
