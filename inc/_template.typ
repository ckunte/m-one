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
  set text(
    font: "erewhon", // New Computer Modern
    top-edge: "cap-height", 
    bottom-edge: "baseline",
    number-type: "old-style",
    size: 10pt
    )
  // raw text / code
  show raw: set text(size: 7.5pt)

  // Table caption
  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  
  // Table stroke and row height
  set table(
    stroke: none,
    row-gutter: -0.5em
  )


  // Emphasise caption
  show figure.caption: emph

  // Set block quote
  set quote(block: true)
  // show quote: set text(style: "italic")

  // Set blue color for links
  show link: set text(fill: rgb(0, 0, 255))

  // Configure the page properties.
  set page(
    paper: paper,
    numbering: "1",
    margin: (bottom: 1.75cm, top: 2.25cm),
    header: context {
      if calc.odd( counter(page).get().first() ) {
        return smallcaps(title)
      }
      // Are we on a page that starts a chapter?
      // We also check the previous page because
      // headings contain pagebreaks
      let i = here().page()
      let all = query(heading)
      if all.any( it => it.location().page() in (i - 1, i) ) {
        return
      }
      // Find the heading of the section we are currently in
      let before = query( selector(heading).before(here()) )
      if before != () {
        align(right, smallcaps(before.last().body))
      }
      set text(0.95em)
    }, // context ends
  )

  // small caps
  let sc(content) = text(features: ("c2sc",))[#content]
  show regex("[A-Z]{2,}"): match => {
    sc(match)
  }
  //// smallcaps
  //show regex("[A-Z]{2,}"): match => {
  //  smallcaps(lower(match))
  //}

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
  set par(
    spacing: 0.65em, 
    leading: 0.65em, 
    first-line-indent: 12pt, 
    justify: true
  )

  // Start with a chapter outline.
  // outline(title: [Chapters])

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
  show heading: set text(10pt, weight: 600)

  body
}