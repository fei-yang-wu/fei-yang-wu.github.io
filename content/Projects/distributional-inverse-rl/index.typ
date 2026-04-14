#import "../../index.typ": template, tufted
#show: template.with(
  title: "Distributional Inverse Reinforcement Learning",
  description: "Distributional IRL project overview",
  lang: "en",
)

= Distributional Inverse Reinforcement Learning

This work proposes an offline IRL framework that models uncertainty over rewards and full return distributions, instead of recovering only a deterministic point estimate of reward.

The method emphasizes distributional structure in expert behavior and introduces first-order stochastic dominance (FSD) constraints to reduce dominance violations during learning.

== Core Formulation

The paper defines a distributional IRL objective that replaces expected-return matching with FSD-violation minimization:

$
  max_(pi) min_(r) integral_(-oo)^(oo) [F_(Z^(pi))(z) - F_(Z^(E))(z)]_+ d z + H(pi) + psi(r)
$

where $Z^(E)$ is the expert return distribution.

== Reward Distribution Learning

Reward is modeled as a conditional distribution $r_t ~ q(phi)(. | s_t, a_t)$. The paper uses an energy-based likelihood with a variational posterior, yielding:

$
  min_(phi) E_(q_(phi)(r | s, a))[L_("fsd")(pi, r)] + "KL"(q_(phi)(r | s, a) || p_0(r))
$

This is implemented by approximating quantile functions from Monte Carlo return samples and optimizing the FSD-based distance in quantile space.

== Risk-aware Policy Learning

After reward-distribution estimation, policy optimization is performed with distortion risk measures (DRMs):

$
  max_(phi) M_(xi)(Z^(pi_(phi))) + H(pi_(phi))
$

with

$
  M_(xi)(X) = integral_0^1 F_X^(-1)(v) d tilde(xi)(v)
$

where $tilde(xi)$ is the dual distortion function. This enables risk-averse or risk-seeking policy behavior while staying fully offline.

#let icon(path) = image(path, width: 0.95em)

== Empirical Highlights

- Gridworld: recovers both reward mean and variance under stochastic rewards.
- Mouse neurobehavioral data: recovers reward distributions aligned with dopamine fluctuation distributions.
- Risk-sensitive MuJoCo benchmarks: achieves strong imitation performance against offline IRL baselines.

== Links

- #link("/Projects/")[#icon("../../../assets/icons/back.svg") Back to Projects]
- #link("https://arxiv.org/abs/2510.03013")[#icon("../../../assets/icons/paper.svg") Paper]
- #link("https://arxiv.org/html/2510.03013v2")[#icon("../../../assets/icons/paper.svg") Paper (HTML)]
