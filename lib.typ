// modern-short-story: a clean, editorial layout for short stories and literary fiction.

// Design token
#let ink = rgb("#1a1a1a")

// --- MODERN UTILITIES ---

// Minimalist Scene Break
#let scene-break() = {
  v(2em, weak: true)
  align(center)[#text(size: 1.2em, tracking: 0.5em)[\* \* \*]]
  v(1em, weak: true)
}



// Modern Verse / Epigraph (Supports literal formatting with backticks)
#let verse(it, author: none, author-gap: 0.3em) = {
  v(1em, weak: true)
  align(center, block(width: auto, breakable: true, align(center, {
    set text(style: "italic")

    if type(it) == raw {
      let lines = it.text.split("\n")
      for line in lines {
        let trimmed = line.trim()
        if trimmed == "" {
          v(1em) // Stanza gap
        } else {
          let leading-spaces = line.match(regex("^ +"))
          let indent-width = if leading-spaces != none { leading-spaces.text.len() } else { 0 }
          block(width: 100%, {
            par(justify: false, leading: 0.5em, hanging-indent: 1.5em, {
              if indent-width > 0 { h(indent-width * 0.4em) }
              eval(trimmed, mode: "markup")
            })
          })
          v(0.1em)
        }
      }
    } else if type(it) == str {
      let lines = it.split("\n")
      for line in lines {
        let trimmed = line.trim()
        if trimmed == "" {
          v(1em)
        } else {
          block(width: 100%, {
            par(justify: false, leading: 0.5em, hanging-indent: 1.5em, {
              eval(trimmed, mode: "markup")
            })
          })
          v(0.1em)
        }
      }
    } else {
      set par(justify: false, leading: 0.5em, spacing: 0.5em, first-line-indent: 0pt)
      show "  ": h(1.5em)
      show par: set block(spacing: 0.5em, above: 0.5em, below: 0.5em)
      it
    }

    if author != none [
      #v(author-gap)
      #text(size: 0.85em, style: "normal")[— #author]
    ]
  })))
  v(1em, weak: true)
}

// Shorthand alias for verse
#let q = verse

// --- FRONT MATTER STYLES ---

#let title-page(title, author: none, year: none) = {
  page(numbering: none)[
    #set align(left)
    #set par(first-line-indent: 0pt)
    #v(15%)
    
    // Title Section
    #block(width: 80%)[
      #text(size: 32pt, weight: "medium", tracking: -0.02em, fill: ink)[#title]
    ]
    
    #v(1.5em)
    #line(length: 5em, stroke: 1pt + ink)
    #v(2em)
    
    // Author and Year Section
    #block([
      #text(size: 14pt, weight: "regular", tracking: 0.05em)[#author]
      #if year != none {
        v(0.8em)
        text(size: 11.5pt, tracking: 0.15em, weight: "regular", fill: ink)[#year]
      }
    ])
    #v(10%)
  ]
}

#let copyright-page(
  title: "",
  author: "",
  year: "",
  rights: "all-rights",
  include-legal: true,
  credit: true,
) = {
  pagebreak(to: "even", weak: true)
  page(numbering: none)[
    #set text(size: 8.5pt, fill: gray.darken(40%))
    #set par(first-line-indent: 0pt)
    #set align(bottom + left)

    #block(width: 80%)[
      *#title* \
      Copyright © #year by #author

      #if rights == "all-rights" [
        \ All rights reserved.
      ]

      #if include-legal [
        #v(1em)
        No part of this publication may be reproduced, stored, or transmitted in any form or by any means—electronic, mechanical, photocopying, recording, or otherwise—without prior written permission of the author, except in the case of brief quotations used in reviews.
      ]
      
      #if credit [
        #v(1em)
        Template design and typography by North Pass Press (northpass.press).
      ]
    ]
  ]
}

// --- CORE TEMPLATE ---

#let short-story(
  title: "Untitled Story",
  author: "Anonymous",
  year: "2026",
  frontmatter: none,
  font-size: 11pt,
  line-height: 1.4,
  paper-size: "6x9",
  inner-margin: none,
  chapter-numbering: none,
  lang: "en",
  region: "us",
  rights: "all-rights",
  include-legal: true,
  credit: true,
  body
) = {
  // Document Metadata
  set document(title: title, author: author)
  
  // --- DYNAMIC PAGE SETUP ---
  // Accepts "6x9" / "5.5x8.5" (inches) or any Typst paper name such as "a5".
  let custom-size = paper-size.match(regex("^\\s*[0-9.]+\\s*(in)?\\s*x\\s*[0-9.]+\\s*(in)?\\s*$")) != none
  let page-size = if custom-size {
    let dims = paper-size.replace("in", "").split("x").map(s => float(s.trim()) * 1in)
    (width: dims.at(0), height: dims.at(1))
  } else {
    (paper: paper-size)
  }

  // Margins for digital/short story reading:
  // We use symmetrical margins by default (no binding gutter needed).
  let margin-outside = 0.75in
  let margin-inside = if inner-margin != none { inner-margin } else { margin-outside }
  let margin-vertical = 0.75in

  set page(
    ..page-size,
    margin: (
      inside: margin-inside,
      outside: margin-outside,
      top: margin-vertical,
      bottom: margin-vertical,
    ),
    fill: white,
  )

  // Typography
  set text(
    font: ("Libertinus Serif", "EB Garamond"),
    size: font-size,
    fill: ink,
    lang: lang,
    region: region,
    hyphenate: true, // Crucial for justified novel text
  )
  
  // Modern paragraph style
  let par-leading = line-height * 0.4em
  set par(
    justify: true,
    leading: par-leading,
    spacing: par-leading, // Matches leading for seamless flow
    first-line-indent: (amount: 1.5em, all: false),
    linebreaks: "optimized",
  )

  set heading(numbering: chapter-numbering)
  
  // Heading Styling (Short Story Title) — Centered, modern literary
  show heading.where(level: 1): it => {
    pagebreak(to: "odd", weak: true)
    v(15%)
    
    align(center, block(width: 100%)[
      #text(size: 24pt, weight: "regular", tracking: 0.02em)[#it.body]
      #v(1em)
      #line(length: 20%, stroke: 0.5pt + luma(150))
    ])
    v(2.5em)
  }

  // --- CONTENT ---
  
  // Smart Scene Break: Converts +++ on its own line into a professional break
  show regex("^\\+\\+\\+$"): scene-break()
  
  // Shorthand for smallcaps using pipes |Text|
  show regex("\\|(.+?)\\|"): it => {
    let content = it.text.slice(1, -1)
    smallcaps(content)
  }



  // Automatically format raw blocks (```...```) as centered verses
  show raw.where(block: true): it => verse(it)

  // Layout the book
  if frontmatter != none {
    frontmatter
  } else {
    title-page(title, author: author, year: year)
    copyright-page(
      title: title,
      author: author,
      year: year,
      rights: rights,
      include-legal: include-legal,
      credit: credit,
    )
  }
  
  
   pagebreak(to: "odd")
   counter(page).update(1)

  // Applied only to the body
  set page(
    numbering: none,
    header: context {
      let page-num = counter(page).display("1")
      let is-odd = calc.odd(counter(page).get().first())
      
      // Hide headers on chapter starts
      let current-abs-page = here().page()
      let headings = query(heading.where(level: 1))
      let is-chapter-start = headings.any(h => h.location().page() == current-abs-page)
      
      if is-chapter-start { return none }

      set text(size: 9.5pt, fill: gray.darken(20%), tracking: 0.08em)
      if is-odd {
        // Right page: Title (Centered), Page Num (Right)
        pad(bottom: 0.5em, grid(
          columns: (1fr, 4fr, 1fr),
          [],
          align(center, smallcaps(title)),
          align(right, page-num)
        ))
      } else {
        // Left page: Page Num (Left), Author (Centered)
        pad(bottom: 0.5em, grid(
          columns: (1fr, 4fr, 1fr),
          align(left, page-num),
          align(center, smallcaps(author)),
          []
        ))
      }
    }
  )
  
  body
}
