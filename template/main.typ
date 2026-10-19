#import "@preview/modern-short-story:0.1.0": short-story

// ==============================
// STORY SETUP (EDIT THIS SECTION)
// ==============================

#show: short-story.with(
  title: "Your Story Title",
  author: "Author Name",
  year: str(datetime.today().year()),
  font-size: 11pt,
  // paper-size: "6x9", // Other sizes: "5x8", "5.5x8.5", or a Typst paper name like "a5"
  // inner-margin: 1.25in, // Increase if the binding gutter is too small
  // lang: "en", // Language code; controls hyphenation
  // credit: false, // Set to false to remove the template credit line
)

#include "story.typ"
