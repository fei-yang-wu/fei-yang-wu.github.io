#let template-links(content) = {
  // Open external links and non-web resources in a new tab
  show link: it => {
    if type(it.dest) == str {
      // 1. Determine whether it is an external link (starting with http)
      let is-external = it.dest.starts-with("http")

      // 2. Determine whether it is a "non-web page resource"
      //    Exclude relative paths (starting with "." e.g. "../" or "/" for root-relative)
      //    because ".." contains a dot and would otherwise be mis-identified as a resource.
      let is-relative = it.dest.starts-with(".") or it.dest.starts-with("/")
      let is-resource = not is-relative and it.dest.contains(".") and not it.dest.ends-with(".html")

      if is-external or is-resource {
        html.a(
          href: it.dest,
          target: "_blank",
          rel: ("noopener", "noreferrer"),
          it.body,
        )
      } else {
        it // Internal page link (.html) or anchor link (#top), keep as is
      }
    } else {
      it // Internal reference object, keep as is
    }
  }

  content
}
