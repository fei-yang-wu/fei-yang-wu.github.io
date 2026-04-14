#import "../../index.typ": template, tufted
#show: template.with(
  title: "Humanoid Locomotion",
  description: "Inverse reinforcement learning and teacher-student learning for humanoid robot sim-to-real transfer",
  lang: "en",
)

#tufted.back-link(label: "Projects")

= Humanoid Locomotion

Sim-to-real transfer for robust bipedal locomotion via inverse reinforcement learning and teacher-student training.

#tufted.video-embed(
  "https://www.youtube.com/embed/pkw4gxOn6Ho?si=EcHfX0gOf0z9f5NB",
  title: "Learn to Teach — Humanoid Locomotion Demo",
)

== Overview

This project applies the Learn to Teach framework to the Digit humanoid robot, targeting sample-efficient sim-to-real transfer for robust locomotion across diverse terrains and conditions.

We use inverse reinforcement learning to infer reward functions from expert demonstrations, then train a teacher policy in simulation using a LiDAR-enriched observation space. The teacher's knowledge is distilled into a deployable student policy that uses only proprioceptive sensing — enabling robust performance on hardware without privileged perception.

== Publications

- #link("https://arxiv.org/abs/2402.06783")[Learn to Teach: Improve Sample Efficiency in Teacher-student Learning for Sim-to-Real Transfer]. RA-L 2025. \
  Feiyang Wu, Xavier Nal, Zhaoyuan Gu, Ye Zhao, Anqi Wu

- #link("https://arxiv.org/abs/2309.16074")[Infer and Adapt: Bipedal Locomotion Reward Learning from Demonstrations via Inverse Reinforcement Learning]. ICRA 2024. \
  Feiyang Wu, Zhaoyuan Gu, Hanran Wu, Anqi Wu, Ye Zhao

== Links

- #link("https://lidar-learn-to-teach.github.io/")[Project website]
- #link("https://arxiv.org/abs/2402.06783")[Paper: Learn to Teach (RA-L 2025)]
- #link("https://arxiv.org/abs/2309.16074")[Paper: Infer and Adapt (ICRA 2024)]
- #link("https://www.youtube.com/watch?v=pkw4gxOn6Ho")[Video on YouTube]
