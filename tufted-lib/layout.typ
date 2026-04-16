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

/// Embed a local video file in a responsive 16:9 container.
///
/// - src:      path to the video file, e.g. "/assets/videos/demo.mp4"
/// - autoplay: start playing automatically (requires muted: true in most browsers)
/// - loop:     whether the video loops (default false)
/// - muted:    whether the video starts muted (default false)
/// - poster:   optional poster image shown before playback starts
#let local-video(src, autoplay: false, loop: false, muted: false, poster: none) = {
  html.div(
    class: "video-embed",
    html.video(
      src: src,
      controls: true,
      autoplay: autoplay,
      loop: loop,
      muted: muted,
      playsinline: true,
      poster: poster,
      preload: "metadata",
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

/// News entry with date on the left and content on the right.
///
/// - date:    date string, e.g. "Jan 2026"
/// - content: news text (content)
#let news-entry(date, content) = {
  html.div(class: "news-entry")[
    #html.span(class: "news-date")[#date]
    #html.span(class: "news-text")[#content]
  ]
}

/// Publication entry with title, authors, and venue on separate lines.
///
/// - title:    paper title (content)
/// - url:      optional URL for the title link (string or none)
/// - authors:  author list (content)
/// - venue:    venue / year (content or none to omit)
/// - featured: if true, show accent bar beside the entry (default: false)
/// - project:  optional URL to an internal project page (string or none)
#let pub-entry(title: [], url: none, authors: [], venue: none, featured: false, project: none) = {
  html.div(class: "pub-entry")[
    #html.div(class: "pub-title")[
      #if featured { html.span(class: "pub-star")[★] }
      #if url != none { link(url)[#title] } else { title }
      #if project != none {
        html.a(href: project, class: "pub-project-link", title: "Project page")[
          #html.span(class: "proj-icon icon-arrow-up-right")[]
        ]
      }
    ]
    #html.div(class: "pub-authors")[#authors]
    #if venue != none {
      html.div(class: "pub-venue")[#venue]
    }
  ]
}
