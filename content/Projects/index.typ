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
      #link("humanoid-locomotion/")[Project page] ·
      #link("https://lidar-learn-to-teach.github.io/")[Website] ·
      #link("https://arxiv.org/abs/2402.06783")[Paper] ·
      #link("https://www.youtube.com/watch?v=pkw4gxOn6Ho")[Video]
    ]
  ]
]
