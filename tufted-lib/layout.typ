// TODO: figures and figures with captions inside margin notes

#let margin-note(content) = {
  html.span(class: "marginnote", content)
}

// TODO: implement <figure class="fullwidth">
// possible requires introspection or `set html.figure(class: "fullwidth")` support

#let full-width(content) = {
  html.div(class: "fullwidth", content)
}

/// Embed a YouTube (or other) video in a responsive 16:9 container.
///
/// The container matches the Tufte text-column width on desktop and
/// expands to full width on mobile (controlled via CSS).
///
/// - url:   embed URL, e.g. "https://www.youtube.com/embed/VIDEO_ID"
/// - title: accessible iframe title (default "Video")
#let video-embed(url, title: "Video") = {
  html.div(
    class: "video-embed",
    html.iframe(
      src: url,
      title: title,
      loading: "lazy",
      referrerpolicy: "strict-origin-when-cross-origin",
      allow: "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share",
      allowfullscreen: true,
    ),
  )
}

/// Back-navigation breadcrumb for detail pages (projects, blog posts, etc.).
///
/// Renders a dimmed "← Label" line above the page title.
///
/// - path:  link target (default "../")
/// - label: link text   (default "Back")
#let back-link(path: "../", label: "Back") = {
  // Use html.a directly to bypass the template-links rule, which would
  // mis-classify "../" as a resource (because ".." contains a dot) and
  // open the link in a new tab.
  html.div(class: "back-link")[← #html.a(href: path)[#label]]
}

/// Publication entry with title, authors, and venue on separate lines.
///
/// - title:   paper title (content)
/// - url:     optional URL for the title link (string or none)
/// - authors: author list (content)
/// - venue:   venue / year (content or none to omit)
#let pub-entry(title: [], url: none, authors: [], venue: none) = {
  html.div(class: "pub-entry")[
    #html.div(class: "pub-title")[
      #if url != none { link(url)[#title] } else { title }
    ]
    #html.div(class: "pub-authors")[#authors]
    #if venue != none {
      html.div(class: "pub-venue")[#venue]
    }
  ]
}
