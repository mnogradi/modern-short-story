#import "lib.typ": short-story, q

#show: short-story.with(
  title: "The Template Guide",
  author: "North Pass Press",
  year: "2026",
)

= User Guide & Documentation

|Welcome to the Modern Short Story| template by North Pass Press. This document serves as both your user manual and a live demonstration of the template's capabilities.

This template is designed to strip away the complex apparatus of a full-length novel in favor of a clean, editorial-grade layout specifically tailored for short stories and literary fiction.

== Getting Started in Typst.app

The quickest way to begin is from Typst Universe:

1. *Start from template.* In the Typst web app, click *Start from template*, search for "modern-short-story", and create the project.
2. *Configure.* Open `main.typ` and set your story's title and author.
3. *Write.* Open `story.typ`, replace the placeholder text, and begin writing.

Prefer the command line? Run `typst init @preview/modern-short-story:0.1.0` and open the new folder.

=== Manual setup

If you downloaded the files from GitHub instead:

1. *Create Project.* Go to typst.app and create a new empty project.
2. *Upload Files.* Upload `lib.typ`, `main.typ`, and `story.typ`.
3. *Clean Up.* Typst auto-generates a blank `main.typ`. Once your own files are in the project, delete the blank one.
4. *Set Main File.* Hover over `main.typ` in the left sidebar and click the *Eye icon* (Set as main). This is critical; the formatting only renders correctly if `main.typ` is set as the main file.
5. *Point the imports at lib.typ.* In both `main.typ` and `story.typ`, change the `@preview` import path to `"lib.typ"`.

+++

== Core Features & Shorthand

The power of this template lies in its "invisible" automation. We've built in several shorthand triggers to help you maintain your creative flow without hunting for formatting menus.

=== Titles & Paragraphs
Use the equals sign followed by a space (\=) to create your story title. It will be centered and spaced automatically. Your title is set in two places: the `title` in `main.typ` (used for the title page and running headers) and the `=` heading in `story.typ`. Keep them in sync. Note that Typst requires a *single empty line* between paragraphs to apply the correct indenting and vertical rhythm.

=== Intelligent Scene Breaks
To create a professional scene break, simply type three plus signs (`+`#h(0pt)`++`) on their own line. The template will automatically convert this into the centered ornament you see above.

=== Em-Dashes
Simply type three hyphens back-to-back (`---`) and Typst converts them into a continuous em-dash. (Two hyphens give you an en-dash.)

=== Smallcaps
Wrap your text in pipes (for example: |#h(0pt)|Like This|#h(0pt)|) to render smallcaps. This is the standard literary way to open a story or denote a significant transition. The text between the pipes must be plain text on a single line; formatting such as italics inside the pipes is not supported.

=== Poetry & Epigraphs
For poems or epigraphs, use the `#q()` function. Add an `author` to include an attribution line.

#q("Poetry and epigraphs are simple.
This verse block is automatically centered.", author: "The Author")

=== Automated Headers & Page Numbers
The template generates running headers (title and author name) and page numbers on every page. These are hidden on the story's opening page to keep the layout clean and focused.

== Options

Set these in `main.typ`:

- `title`, `author`, `year`: used on the title page, copyright page, and running headers.
- `font-size`: body text size (default `11pt`).
- `paper-size`: `"6x9"` (default), another size in inches such as `"5.5x8.5"`, or a Typst paper name such as `"a5"`.
- `inner-margin`: increase for a larger binding gutter.
- `lang`, `region`: language settings; these control hyphenation.
- `rights`, `include-legal`: control the "All rights reserved" line and the legal paragraph on the copyright page.
- `credit`: set to `false` to remove the template credit line.
- `frontmatter`: pass your own content to replace the title and copyright pages.

== File Structure

- *main.typ*: Your control center for title, author, and paper size.
- *story.typ*: Your blank canvas where you do your actual writing.
- *lib.typ*: The template engine. When you start from Typst Universe it lives in the package and you never need to touch it.
\
|Happy Writing!|
