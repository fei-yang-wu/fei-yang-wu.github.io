#import "@preview/zebraw:0.6.1": *
#import "@preview/tablem:0.3.0": *

#set page(height: auto)
#set text(font: "Noto Serif CJK SC", size: 12pt)
#show: zebraw

= Typst PDF Sample

In PDF output, you can directly customize text #text(fill: blue)[color], #text(size: 20pt)[size], and #text(font: "Liu Jian Mao Cao")[font].

```typ
In PDF output, you can directly customize text #text(fill: blue)[color], #text(size: 20pt)[size], and #text(font: "Liu Jian Mao Cao")[font].
```

== Paragraph Alignment

Text is left-aligned by default.

#align(center)[But I want this line centered temporarily!]

Without affecting the rest of the document.

#set align(left)
This and following paragraphs are left-aligned.

#set align(right)
This and following paragraphs are right-aligned.

#set align(center)
This and following paragraphs are center-aligned.

This is also centered.

```typ
Text is left-aligned by default.

#align(center)[But I want this line centered temporarily!]

Without affecting the rest of the document.

#set align(left)
This and following paragraphs are left-aligned.

#set align(right)
This and following paragraphs are right-aligned.

#set align(center)
This and following paragraphs are center-aligned.

This is also centered.
```

#set align(left)

== Columns

#columns(2, gutter: 1em)[
  This is the first part of a two-column layout. Typst balances column heights automatically.

  We use `lorem` to generate placeholder text:
  #lorem(10)

  #colbreak() // force a column break

  This is the second column. You can place images, formulas, or any other content here.
]

```typ
#columns(2, gutter: 1em)[
  This is the first part of a two-column layout. Typst balances column heights automatically.

  We use `lorem` to generate placeholder text:
  #lorem(10)

  #colbreak() // force a column break

  This is the second column. You can place images, formulas, or any other content here.
]
```

== Tables

The `tablem` package is convenient for Markdown-style tables:

#align(center)[
  #three-line-table[
    | *Name* | *Location* | *Height* | *Score* |
    | :----: | :--------: | :------: | :-----: |
    | John   | Second St. | 180 cm   | 5       |
    | Wally  | Third Av.  | 160 cm   | 10      |
  ]
]

```typ
#import "@preview/tablem:0.3.0": *

#align(center)[
  #three-line-table[
    | *Name* | *Location* | *Height* | *Score* |
    | :----: | :--------: | :------: | :-----: |
    | John   | Second St. | 180 cm   | 5       |
    | Wally  | Third Av.  | 160 cm   | 10      |
  ]
]
```

Cell merging is also supported:

#align(center)[
  #tablem[
    | Soldier | Hero       | <        | Soldier |
    | Guard   | Horizontal | <        | Guard   |
    | ^       | Soldier    | Soldier  | ^       |
    | Soldier | Gate       | <        | Soldier |
  ]
]

```typ
#align(center)[
  #tablem[
    | Soldier | Hero       | <        | Soldier |
    | Guard   | Horizontal | <        | Guard   |
    | ^       | Soldier    | Soldier  | ^       |
    | Soldier | Gate       | <        | Soldier |
  ]
]
```
