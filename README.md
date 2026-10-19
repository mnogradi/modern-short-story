# modern-short-story

A clean, editorial-grade [Typst](https://typst.app) template for short stories and literary fiction. It strips away the apparatus of a full-length novel and gives you:

- a title page and copyright page
- running headers (title and author) and page numbers, hidden on the opening page
- a centered story title with a rule beneath it
- shorthand for scene breaks, smallcaps, and verse

## Quick start

In the Typst web app, click **Start from template** and search for `modern-short-story`. Or from the command line:

```sh
typst init @preview/modern-short-story:0.1.0
```

Then edit `main.typ` (title, author, paper size) and write your story in `story.typ`.

## Shorthand

| You type | You get |
| --- | --- |
| `= Title` | Centered story title (start of the story) |
| `+++` on its own line | Centered scene-break ornament |
| `\|Text\|` | Smallcaps (plain text, single line) |
| `---` | Em-dash (built into Typst) |
| `#q("line one\nline two", author: "Name")` | Centered verse or epigraph, with optional attribution |
| a fenced code block | Also rendered as centered verse |

## Options

Pass these to `short-story.with(...)` in `main.typ`.

| Option | Default | Notes |
| --- | --- | --- |
| `title`, `author`, `year` | `"Untitled Story"`, `"Anonymous"`, `"2026"` | Title page, copyright page, headers |
| `font-size` | `11pt` | Body text |
| `paper-size` | `"6x9"` | Inches (`"5.5x8.5"`) or a Typst paper name (`"a5"`) |
| `inner-margin` | none | Larger binding gutter; margins are 0.75in otherwise |
| `line-height` | `1.4` | Multiplied into the paragraph leading |
| `lang`, `region` | `"en"`, `"us"` | Controls hyphenation |
| `rights` | `"all-rights"` | `"all-rights"` prints "All rights reserved." |
| `include-legal` | `true` | Legal paragraph on the copyright page |
| `credit` | `true` | Set `false` to remove the template credit line |
| `frontmatter` | none | Your own content to replace the title and copyright pages |
| `chapter-numbering` | none | Heading numbering pattern |

## Known limitations

- The smallcaps shorthand matches plain text on one line. Formatting inside the pipes (for example italics) won't work, and a stray pair of `|` characters in prose will become smallcaps.
- Only level-1 headings are styled by the template. Lower levels use Typst defaults.
- Level-1 headings start on a right-hand page, and the title and copyright pages assume facing pages.

## Development

Install the package locally so `@preview` imports resolve while you test (Linux shown; use the equivalent Typst data directory on macOS and Windows):

```sh
mkdir -p ~/.local/share/typst/packages/preview/modern-short-story/0.1.0
cp -r lib.typ typst.toml template LICENSE README.md \
  ~/.local/share/typst/packages/preview/modern-short-story/0.1.0/
typst init @preview/modern-short-story:0.1.0 /tmp/story-test
typst compile /tmp/story-test/main.typ
```

Build the guide from the repository root:

```sh
typst compile guide.typ
```

Generate the Typst Universe thumbnail (page 3 is the first page of the story):

```sh
typst compile -f png --pages 3 --ppi 250 template/main.typ thumbnail.png
```

To publish a new version: bump `version` in `typst.toml`, update the version in both template imports, regenerate the thumbnail, then open a pull request against [typst/packages](https://github.com/typst/packages) adding the files under `packages/preview/modern-short-story/<version>/`.

## License

[MIT-0](LICENSE). Use it for anything, no attribution required. The credit line on the copyright page is optional (`credit: false`).
