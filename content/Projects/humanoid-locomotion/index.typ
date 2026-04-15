#import "../../index.typ": template, tufted
#show: template.with(
  title: "Humanoid Locomotion",
  description: "Inverse reinforcement learning and teacher-student learning for humanoid robot sim-to-real transfer",
  lang: "en",
  wide: true,
)

#tufted.back-link(label: "Projects")

= Humanoid Locomotion

Sim-to-real transfer for robust bipedal locomotion via inverse reinforcement learning and teacher-student training.

#tufted.local-video(
  "/assets/videos/RAL-revision-faststart.mp4",
  autoplay: true,
  muted: true,
  loop: true,
  poster: "/assets/videos/RAL-revision-card-poster.jpg",
)

== Overview

This project applies the Learn to Teach framework to the Digit humanoid robot, targeting sample-efficient sim-to-real transfer for robust locomotion across diverse terrains and conditions.

We use inverse reinforcement learning to infer reward functions from expert demonstrations, then train a teacher policy in simulation using a LiDAR-enriched observation space. The teacher's knowledge is distilled into a deployable student policy that uses only proprioceptive sensing — enabling robust performance on hardware without privileged perception.

== Publications

#tufted.pub-entry(
  title: [Learn to Teach: Improve Sample Efficiency in Teacher-student Learning for Sim-to-Real Transfer],
  url: "https://arxiv.org/abs/2402.06783",
  authors: [Feiyang Wu, Xavier Nal, Zhaoyuan Gu, Ye Zhao, Anqi Wu],
  venue: [RA-L 2025],
)

#tufted.pub-entry(
  title: [Infer and Adapt: Bipedal Locomotion Reward Learning from Demonstrations via Inverse Reinforcement Learning],
  url: "https://arxiv.org/abs/2309.16074",
  authors: [Feiyang Wu, Zhaoyuan Gu, Hanran Wu, Anqi Wu, Ye Zhao],
  venue: [ICRA 2024],
)

== Links

- #link("https://lidar-learn-to-teach.github.io/")[Project website]
- #link("https://arxiv.org/abs/2402.06783")[arXiv: Learn to Teach]
- #link("https://arxiv.org/abs/2309.16074")[arXiv: Infer and Adapt]
- #link("https://www.youtube.com/watch?v=pkw4gxOn6Ho")[Video on YouTube]
