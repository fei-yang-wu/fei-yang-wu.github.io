#import "../index.typ": template, tufted
#show: template.with(
  title: "Projects",
  description: "Projects by Feiyang Wu",
  lang: "en",
)

= Projects

This page highlights selected research projects. Each project links to a dedicated detail page.

#let icon(path) = image(path, width: 0.95em)

#html.div(class: "project-cards", [
  #html.div(class: "project-card", [
    == #link("humanoid-locomotion/")[Learn to Teach: Improve Sample Efficiency in Teacher-student Learning for Sim-to-Real Transfer]

    We study teacher-student learning for robust humanoid locomotion and improve sample efficiency for sim-to-real transfer on the Digit robot.

    #html.div(class: "project-video-wrap", html.iframe(
      src: "https://www.youtube.com/embed/pkw4gxOn6Ho?si=EcHfX0gOf0z9f5NB",
      title: "Learn to Teach video",
      class: "project-video",
      width: 960,
      height: 540,
      loading: "lazy",
      referrerpolicy: "strict-origin-when-cross-origin",
      allow: "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share",
      allowfullscreen: true,
    ))

    - #link("humanoid-locomotion/")[#icon("../../assets/icons/project-page.svg") Project page]
    - #link("https://lidar-learn-to-teach.github.io/")[#icon("../../assets/icons/website.svg") Project website]
    - #link("https://arxiv.org/abs/2402.06783")[#icon("../../assets/icons/paper.svg") Paper]
    - #link("https://www.youtube.com/watch?v=pkw4gxOn6Ho")[#icon("../../assets/icons/video.svg") Video]
  ])

  #html.div(class: "project-card", [
    == #link("distributional-inverse-rl/")[Distributional Inverse Reinforcement Learning]

    DistIRL learns reward and return distributions in offline IRL, replacing expectation-only matching with first-order stochastic dominance (FSD) based distribution matching and risk-aware policy learning.

    The core distributional IRL objective is:

    $
      max_(pi) min_(r) integral_(-oo)^(oo) [F_(Z^(pi))(z) - F_(Z^(E))(z)]_+ d z + H(pi) + psi(r)
    $

    and reward distribution learning is optimized with a variational objective:

    $
      min_(phi) E_(q_(phi)(r | s, a))[L_("fsd")(pi, r)] + "KL"(q_(phi)(r | s, a) || p_0(r))
    $

    while policy learning uses a distortion risk measure (DRM):

    $
      max_(phi) M_(xi)(Z^(pi_(phi))) + H(pi_(phi))
    $

    - #link("distributional-inverse-rl/")[#icon("../../assets/icons/project-page.svg") Project page]
    - #link("https://arxiv.org/abs/2510.03013")[#icon("../../assets/icons/paper.svg") Paper]
    - #link("https://arxiv.org/html/2510.03013v2")[#icon("../../assets/icons/paper.svg") Paper (HTML)]
  ])
])

