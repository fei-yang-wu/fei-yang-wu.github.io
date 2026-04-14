#import "../index.typ": template, tufted
#show: template.with(
  title: "Projects",
  description: "Projects by Feiyang Wu",
  lang: "en",
)

= Projects

== Inverse Reinforcement Learning for Humanoid Robot

We apply Learn to Teach to the Digit robot, targeting sample-efficient sim-to-real transfer for robust locomotion.

Main demo video#footnote[
  #html.iframe(
    src: "https://www.youtube.com/embed/pkw4gxOn6Ho?si=EcHfX0gOf0z9f5NB",
    title: "Learn to Teach video",
    width: 320,
    height: 220,
    loading: "lazy",
    referrerpolicy: "strict-origin-when-cross-origin",
    allow: "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share",
    allowfullscreen: true,
  )
  #linebreak()
  #link("https://www.youtube.com/watch?v=pkw4gxOn6Ho")[Open in YouTube]
].

- #link("humanoid-locomotion/")[Humanoid Locomotion Details]
- #link("https://lidar-learn-to-teach.github.io/")[Project Website]
- #link("https://arxiv.org/abs/2402.06783")[Paper: Learn to Teach]
