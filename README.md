# modern-short-story

A clean, editorial-grade [Typst](https://typst.app) template for short stories and literary fiction. It strips away the apparatus of a full-length novel and gives you:

- a title page and copyright page
- running headers (title and author) and page numbers, hidden on the opening page
- a centered story title with a rule beneath it
- shorthand for scene breaks, smallcaps, and verse

> **Status:** not yet published on Typst Universe. For now, use the manual setup below. Once it is published, `typst init` and "Start from template" will work and the import-editing step will go away.

## Quick start (Typst web app)

1. Click the green **Code** button on this page, choose **Download ZIP**, and unzip it.
2. At [typst.app](https://typst.app), create a new empty project.
3. Upload three files into the project: `lib.typ`, `template/main.typ`, and `template/story.typ`.
4. If Typst created a blank `main.typ`, delete it once your own files are in the project (the app won't let you delete a project's only file). Then hover over `main.typ` in the sidebar and click the **Eye icon** to set it as the main file. The formatting only renders correctly if `main.typ` is the main file.
5. Point the imports at your local copy of the template. In `main.typ`, change the first line to:
   ```typst
   #import "lib.typ": short-story
   ```
   In `story.typ`, change the first line to:
   ```typst
   #import "lib.typ": q
   ```
6. Edit the title and author in `main.typ`, then replace the placeholder text in `story.typ` with your story.

## Quick start (command line)

Copy `lib.typ`, `template/main.typ`, and `template/story.typ` into one folder, make the two import edits from step 5 above, then:

```sh
typst compile main.typ
```

Use `typst watch main.typ` to recompile as you write.

## Shorthand

| You type | You get |
| --- | --- |
| `= Title` | Centered story title (start of the story) |
| `+++` on its own line | Centered scene-break ornament |
| `\|Text\|` | Smallcaps (plain text, single line) |
| `---` | Em-dash (built into Typst) |
| `#q("line one\nline two", author: "Name")` | Centered verse or epigraph, with optional attribution |
| a fenced code block | Also rendered as centered verse |

The `author-gap` option on `#q(...)` adjusts the space above the attribution line (default `0.3em`).

Your story's title is set in two places: `title` in `main.typ` (title page, copyright page, running headers) and the `=` heading in `story.typ`. Keep them in sync.

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
- The first paragraph after a scene break is indented.

## Development

To test the package the way Typst Universe will serve it, install it into your local Typst packages folder so `@preview` imports resolve.

Windows (PowerShell, from the repository folder):

```powershell
$dest = "$env:APPDATA\typst\packages\preview\modern-short-story\0.1.0"
New-Item -ItemType Directory -Force -Path $dest
Copy-Item typst.toml, lib.typ, LICENSE, README.md -Destination $dest
Copy-Item template -Destination $dest -Recurse
```

Linux:

```sh
mkdir -p ~/.local/share/typst/packages/preview/modern-short-story/0.1.0
cp -r lib.typ typst.toml template LICENSE README.md \
  ~/.local/share/typst/packages/preview/modern-short-story/0.1.0/
```

Then create a test project and compile it from a different folder:

```sh
typst init @preview/modern-short-story:0.1.0 test-story
cd test-story
typst compile main.typ
```

Build the guide from the repository root:

```sh
typst compile guide.typ
```

Generate the Typst Universe thumbnail (page 3 is the first page of the story):

```sh
typst compile -f png --pages 3 --ppi 250 main.typ thumbnail.png
```

To publish a version to Typst Universe: bump `version` in `typst.toml`, update the version in both template imports, regenerate the thumbnail, then open a pull request against [typst/packages](https://github.com/typst/packages) adding the files under `packages/preview/modern-short-story/<version>/` (leave out `guide.typ`, `.gitignore`, and `.gitattributes`).

## License

[MIT-0](LICENSE). Use it for anything, no attribution required. The credit line on the copyright page is optional (`credit: false`).