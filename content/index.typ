#import "../config.typ": template, tufted
#show: template.with(
  title: "Feiyang",
  description: "Feiyang Wu personal homepage",
  lang: "en",
)

#tufted.full-width[

= Feiyang

*Wu Fei Yang (Wú Fēi Yáng)*, "woo-FAY-yahng" #link("https://translate.google.com/?sl=auto&tl=en&text=wu%20fei%20yang&op=translate")[🔊] \
ML PhD student at Georgia Tech

#link("https://www.linkedin.com/in/feiyangwu/")[Linkedin] | #link("https://x.com/fei_yang_wu")[X] | #link("https://github.com/fei-yang-wu")[GitHub]

My research interests lie in the intersection of optimization, reinforcement learning, and robotics. I develop algorithms to efficiently train robots, ideally with theoretical guarantee.

I am co-advised by #link("https://sites.google.com/view/brainml/home")[Prof. Anqi Wu] and #link("https://lab-idar.gatech.edu/")[Prof. Ye Zhao] at Georgia Tech. Additionally, I had the privilege to collaborate with #link("https://sites.gatech.edu/guanghui-lan/")[Prof. George Lan] on stochastic optimization and RL.

Previously, I contributed to the development team of optimization solvers for large-scale linear programming problems at Chinese University of Hong Kong, Shenzhen (CUHKSZ), where I spent my undergrad years in computer science and engineering.

== News

#tufted.news-entry("Jan 2026", [Two papers accepted to ICRA 2026!])
#tufted.news-entry("Sep 2025", [Our work on IRL with reward distributions is released on arxiv.])
#tufted.news-entry("Aug 2025", [Our paper L2T got accepted at RA-L. Check out #link("https://lidar-learn-to-teach.github.io/")[here].])
#tufted.news-entry("May 2025", [I passed my qualifying exam.])
#tufted.news-entry("May 2025", [One paper accepted to ICML 2025. Congrats Jingyang!])
#tufted.news-entry("Apr 2025", [One paper submitted to RA-L. Check out #link("https://lidar-learn-to-teach.github.io/")[lidar-learn-to-teach.github.io].])
#tufted.news-entry("Sep 2024", [Visiting student Xavier Nal finished his master's project in our lab.])
#tufted.news-entry("May 2024", [Interned at Georgia Tech Research Institute on generalizing diffusion policies for robot manipulation.])
#tufted.news-entry("Dec 2023", [Our paper on inverse reinforcement learning accepted to ICRA 2024.])
#tufted.news-entry("Oct 2023", [Our paper on average reward IRL accepted as poster at NeurIPS 2023.])

== Publication

=== Reinforcement Learning

#tufted.pub-entry(
  title: [Distributional Inverse Reinforcement Learning],
  url: "https://arxiv.org/pdf/2510.03013",
  authors: [Feiyang Wu, Ye Zhao, Anqi Wu],
  venue: [Preprint 2025],
)

#tufted.pub-entry(
  title: [RL-augmented Adaptive Model Predictive Control for Bipedal Locomotion over Challenging Terrain],
  url: "https://arxiv.org/pdf/2509.18466",
  authors: [Junnosuke Kamohara, Feiyang Wu, Chinmayee Wamorkar, Seth Hutchinson, Ye Zhao],
  venue: [ICRA 2026],
)

#tufted.pub-entry(
  title: [SEEC: Stable End-Effector Control with Model-Enhanced Residual Learning for Humanoid Loco-Manipulation],
  url: "https://arxiv.org/pdf/2509.21231",
  authors: [Jaehwi Jang, Zhuoheng Wang, Ziyi Zhou, Feiyang Wu, Ye Zhao],
  venue: [ICRA 2026],
)

#tufted.pub-entry(
  title: [Inverse Reinforcement Learning with Switching Rewards and History Dependency for Characterizing Animal Behaviors],
  url: "https://arxiv.org/pdf/2501.12633",
  authors: [Jingyang Ke, Feiyang Wu, Jiyi Wang, Zhaoyuan Gu, Jeffrey Markowitz, Anqi Wu],
  venue: [ICML 2025],
)

#tufted.pub-entry(
  title: [Learn to Teach: Improve Sample Efficiency in Teacher-student Learning for Sim-to-Real Transfer],
  url: "https://arxiv.org/abs/2402.06783",
  authors: [Feiyang Wu, Xavier Nal, Zhaoyuan Gu, Ye Zhao, Anqi Wu],
  venue: [RA-L 2025],
)

#tufted.pub-entry(
  title: [Stochastic First-Order Methods for Average-Reward Markov Decision Processes],
  url: "https://arxiv.org/abs/2205.05800",
  authors: [Tianjiao Li, Feiyang Wu, Guanghui Lan],
  venue: [Mathematics of Operations Research 2024],
)

#tufted.pub-entry(
  title: [Infer and Adapt: Bipedal Locomotion Reward Learning from Demonstrations via Inverse Reinforcement Learning],
  url: "https://arxiv.org/abs/2309.16074",
  authors: [Feiyang Wu, Zhaoyuan Gu, Hanran Wu, Anqi Wu, Ye Zhao],
  venue: [ICRA 2024],
)

#tufted.pub-entry(
  title: [Inverse Reinforcement Learning with the Average Reward Criterion],
  url: "https://arxiv.org/abs/2305.14608",
  authors: [Feiyang Wu, Jingyang Ke, Anqi Wu],
  venue: [NeurIPS 2023],
)

=== Computer Vision

#tufted.pub-entry(
  title: [SAniHead: Sketching Animal-Like 3D Character Heads Using a View-Surface Collaborative Mesh Generative Network],
  url: "https://ieeexplore.ieee.org/abstract/document/9222121",
  authors: [Dong Du, Xiaoguang Han, Hongbo Fu, Feiyang Wu, Yizhou Yu, Shuguang Cui, Ligang Liu],
  venue: [IEEE Transactions on Visualization and Computer Graphics (TVCG) 2020],
)
]
