#import "../index.typ": template, tufted
#show: template.with(
  title: "Projects",
  description: "Projects by Feiyang Wu",
  lang: "en",
)

= Projects

#tufted.full-width[
  #html.div(class: "project-entry")[
    === #link("humanoid-locomotion/")[Inverse Reinforcement Learning for Humanoid Robots]

    #html.div(class: "project-tags")[
      #html.span(class: "tag")[RA-L 2025]
      #html.span(class: "tag")[ICRA 2024]
      #html.span(class: "tag")[Robotics]
    ]

    We apply the Learn to Teach framework to the Digit humanoid robot, targeting
    sample-efficient sim-to-real transfer for robust locomotion across diverse terrains
    and conditions. Our approach uses inverse reinforcement learning to learn reward
    functions from expert demonstrations, then distills a LiDAR-enriched teacher policy
    into a deployable proprioceptive student.

    #html.div(class: "project-links")[
      #link("https://lidar-learn-to-teach.github.io/")[#html.span(class: "proj-icon icon-project")[]Project page]
      #link("https://arxiv.org/abs/2402.06783")[#html.span(class: "proj-icon icon-arxiv")[]arXiv]
      #link("https://www.youtube.com/watch?v=pkw4gxOn6Ho")[#html.span(class: "proj-icon icon-video")[]Video]
    ]
  ]

  #html.div(class: "project-entry")[
    === #link("distributional-inverse-rl/")[Distributional Inverse Reinforcement Learning]

    #html.div(class: "project-tags")[
      #html.span(class: "tag")[Preprint 2025]
      #html.span(class: "tag")[IRL]
    ]

    We introduce a distributional framework for offline inverse reinforcement learning
    that models uncertainty over reward functions and the full distribution of returns,
    rather than estimating a single reward. Using first-order stochastic dominance and
    distortion risk measures, the method captures richer structure in expert behavior,
    enabling risk-aware imitation and state-of-the-art performance across synthetic,
    neurobehavioral, and MuJoCo benchmarks.

    #html.div(class: "project-links")[
      #link("https://arxiv.org/abs/2510.03013")[#html.span(class: "proj-icon icon-arxiv")[]arXiv]
    ]
  ]
]
