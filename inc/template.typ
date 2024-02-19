// This function gets your whole document as its `body` and formats
// it as a simple fiction book.
#let book(
  // The book's title.
  title: [Book title],

  // The book's author.
  author: "Author",

  // The paper size to use.
  paper: "a5",

  // A dedication to display on the third page.
  dedication: none,

  // Details about the book's publisher that are
  // display on the second page.
  publishing-info: none,

  // The book's content.
  body,
) = {
  // Set the document's metadata.
  set document(title: title, author: author)

  // Set the body font
  set text(font: "erewhon")
  show raw: set text(font: "Inconsolata")

  // Table caption
  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  
  // Emphasise caption
  show figure.caption: emph

  // Set block quote
  set quote(block: true)

  // Set blue color for links
  show link: set text(fill: rgb(0, 0, 255))

  // Configure the page properties.
  set page(
    paper: paper,
    margin: (bottom: 1.75cm, top: 2.25cm),
  )

  // shade code block alternative with line numbers
  /*
  show raw: it => stack(dir: ttb, ..it.lines)
  show raw.line: it => {
    box(
      width: 100%,
      height: 1.75em,
      inset: 0.2em,
      fill: if calc.rem(it.number, 2) == 0 { luma(90%) } else { white },
      align(horizon, stack(
        dir: ltr,
        box(width: 10pt)[#it.number],
        it.body,
      ))
    )
  }

  show raw.line: block.with(
    fill: luma(80%)
  );    
  */
  
  // The first page.
  page(align(center + horizon)[
    #text(2em)[*#title*]
    #v(2em, weak: true)
    #text(1.6em, author)
  ])

  // Display publisher info at the bottom of the second page.
  if publishing-info != none {
    align(center + bottom, text(0.8em, publishing-info))
  }

  pagebreak()

  // Display the dedication at the top of the third page.
  if dedication != none {
    v(15%)
    align(center, dedication)
  }

  // Books like their empty pages.
  pagebreak(to: "odd")

  // Configure paragraph properties.
  set par(leading: 0.78em, first-line-indent: 12pt, justify: true)
  show par: set block(spacing: 0.78em)

  // Start with a chapter outline.
  // outline(title: [Chapters])

  // Configure page properties.
  set page(
    numbering: "1",

    // The header always contains the book title on odd pages and
    // the chapter title on even pages, unless the page is one
    // the starts a chapter (the chapter title is obvious then).
    header: locate(loc => {
      // Are we on an odd page?
      let i = counter(page).at(loc).first()
      if calc.odd(i) {
        return text(0.95em, smallcaps(title))
      }

      // Are we on a page that starts a chapter? (We also check
      // the previous page because some headings contain pagebreaks.)
      let all = query(heading, loc)
      if all.any(it => it.location().page() in (i - 1, i)) {
        return
      }

      // Find the heading of the section we are currently in.
      let before = query(selector(heading).before(loc), loc)
      if before != () {
        align(right, text(0.95em, smallcaps(before.last().body)))
      }
    }),
  )

  // Configure chapter headings.
  show heading.where(level: 1): it => {
    // Always start on odd pages.
    pagebreak(to: "odd")

    // Create the heading numbering.
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
      h(7pt, weak: true)
    }

    v(5%)
    text(2em, weight: 700, block([#number #it.body]))
    v(1.25em)
  }
  show heading: set text(11pt, weight: 600)

  body
}