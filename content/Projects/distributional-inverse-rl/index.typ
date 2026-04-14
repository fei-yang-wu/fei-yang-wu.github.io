#import "../../index.typ": template, tufted
#show: template.with(
  title: "Distributional Inverse RL",
  description: "Distributional inverse reinforcement learning with uncertainty over reward functions and return distributions",
  lang: "en",
  wide: true,
)

#tufted.back-link(label: "Projects")

= Distributional Inverse Reinforcement Learning

Offline IRL that recovers full reward distributions rather than a single point-estimate reward, enabling risk-aware imitation learning and richer behavioral analysis.

== Overview

Conventional IRL methods recover a single reward function from expert demonstrations. This collapses the richness of expert behavior into a point estimate, losing information about uncertainty and the distribution of returns.

We introduce a distributional framework for offline IRL that instead models the full *distribution* over reward functions and returns. By exploiting first-order stochastic dominance (FSD) violations and distortion risk measures, our method captures nuanced structure in expert behavior — including risk preferences and multi-modal patterns — that scalar reward estimation cannot represent.

== Core Formulation

The distributional IRL objective replaces expected-return matching with FSD-violation minimization:

$
  max_(pi) min_(r) integral_(-oo)^(oo) [F_(Z^(pi))(z) - F_(Z^(E))(z)]_+ d z + H(pi) + psi(r)
$

where $Z^(E)$ is the expert return distribution.

Reward is modeled as a conditional distribution $r_t ~ q_(phi)(. | s_t, a_t)$ via an energy-based likelihood with a variational posterior:

$
  min_(phi) E_(q_(phi)(r | s, a))[L_("fsd")(pi, r)] + "KL"(q_(phi)(r | s, a) || p_0(r))
$

This is implemented by approximating quantile functions from Monte Carlo return samples and optimizing the FSD-based distance in quantile space.

== Risk-Aware Policy Learning

After reward-distribution estimation, policy optimization uses distortion risk measures (DRMs):

$
  max_(phi) M_(xi)(Z^(pi_(phi))) + H(pi_(phi)), quad M_(xi)(X) = integral_0^1 F_X^(-1)(v) d tilde(xi)(v)
$

where $tilde(xi)$ is the dual distortion function. This enables risk-averse or risk-seeking policy behavior while remaining fully offline.

== Results

- *Gridworld*: recovers both reward mean and variance under stochastic rewards.
- *Neurobehavioral data*: recovers reward distributions aligned with dopamine fluctuation distributions from mouse behavior.
- *MuJoCo control*: achieves state-of-the-art imitation performance against offline IRL baselines.

== Publication

#tufted.pub-entry(
  title: [Distributional Inverse Reinforcement Learning],
  url: "https://arxiv.org/abs/2510.03013",
  authors: [Feiyang Wu, Ye Zhao, Anqi Wu],
  venue: [Preprint, 2025],
)

== Links

- #link("https://arxiv.org/abs/2510.03013")[arXiv: 2510.03013]
- #link("https://arxiv.org/pdf/2510.03013")[PDF]
- #link("https://arxiv.org/html/2510.03013v2")[HTML version]
