#import "tufted-lib/tufted.typ" as tufted

/// Define the global site template in `config.typ`.
/// Each page imports this template and applies it with `#show: template`.
/// You can override specific parameters per page with `template.with(...)`.
#let template = tufted.tufted-web.with(
  /// Top navigation links in the format `("path": "label")`.
  // Example: to add an Entry page, add `"/Entry/": "Entry"`
  // and create `content/Entry/index.typ`.
  header-links: (
    "/": "Home",
    "/Projects/": "Projects",
    "/CV/": "CV",
  ),

  /// Site title shown in the browser tab and social preview metadata.
  website-title: "Feiyang",
  /// Site author for <meta name="author"> (optional).
  author: "Feiyang Wu",
  /// Site description for search/snippet previews (optional).
  description: "Feiyang Wu personal homepage",
  /// Canonical root URL (for example, "https://example.com") (optional).
  website-url: "https://www.feiyangwu.com",
  /// Default site language, for example "en" or "zh".
  lang: "en",
  /// RSS feed source directories (string array), optional.
  /// Example: `("/Blog/",)` includes posts under `Blog` in the feed.
  feed-dir: (),

  /// Custom header elements (content array).
  header-elements: (),
  /// Custom footer elements (content array).
  footer-elements: ("© 2026 Feiyang Wu",),
)

// See the website configuration docs for more parameters.
