# 22-10-mardi-workshop

René Fritze
rene.fritze@wwu.de

* [Slides](https://renefritze.github.io/22-10-mardi-workshop)
* [PDF](https://github.com/renefritze/22-10-mardi-workshop/blob/master/slides/fritze2022_2210mardiworkshop_slides.pdf)

repository_description.

[![Build Status](https://github.com/renefritze/22-10-mardi-workshop/actions/workflows/build.yml/badge.svg?main)](https://github.com/renefritze/22-10-mardi-workshop/actions/workflows/build.yml)
[![GitHub license](https://img.shields.io/github/license/renefritze/22-10-mardi-workshop.svg)](https://github.com/renefritze/22-10-mardi-workshop/blob/main/LICENSE)


## Install

1. Install [npm](https://www.npmjs.com/)
2. [Clone](https://git-scm.com/docs/git-clone) this repository
3. Install dependencies with `npm`

```
git clone https://github.com/renefritze/22-10-mardi-workshop
cd 22-10-mardi-workshop
make install
```

See [Edits](#edits) and [Implementation](#implementation) for more details.

## Usage

1. Generate `static_html/index.html` (see `script.html` in [package.json](https://github.com/renefritze/22-10-mardi-workshop/blob/master/package.json))
2. Generate `slides/fritze2022_2210mardiworkshop_slides.pdf` (see `script.pdf` in [package.json](https://github.com/renefritze/22-10-mardi-workshop/blob/master/package.json))

```
make html
make pdf
```

## Developer Notes

### Edits

The following can be edited before generating:

* `slides/fritze2022_2210mardiworkshop_slides.md`: [Markdown](https://daringfireball.net/projects/markdown/) file with slide contents
* `slides/template.html`: Custom [reveal-md](https://github.com/webpro/reveal-md) template to generate slides with
* `static_html/edit/style.css`: [CSS](https://developer.mozilla.org/en-US/docs/Web/CSS) file to adjust styling of slides
* `static_html/edit/logo.png`: logo image to use

### Implementation


The slides [22-10-mardi-workshop](https://github.com/renefritze/22-10-mardi-workshop) uses the following [npm](https://www.npmjs.com/) packages for its implementation:

npm | Purpose
--- | ---
[reveal-md](https://www.npmjs.com/package/reveal-md) | Converting `slides/fritze2022_2210mardiworkshop_slides.md` to `static_html/index.html`
[decktape](https://www.npmjs.com/package/decktape) | Converting `slides/fritze2022_2210mardiworkshop_slides.md` to `slides/fritze2022_2210mardiworkshop_slides.pdf`
[windows-build-tools](https://www.npmjs.com/package/windows-build-tools) | Compiling dependencies for decktape on Windows Operating System (OS)

```
       reveal-md            <-- Convert markdown  slides to html

       decktape             <-- Convert markdown slides to pdf
          |
  windows-build-tools       <-- Compile decktape on Windows OS
```

### Deployment

Pushes to the main branch trigger a Github Action that builds the html slides and deploys the `static_html/` directory via the `gh-pages` branch to Github Pages.
For this to work goto Repository Settings -> Actions -> General -> Workflow permissions and set that to "read and write".

### Notes

- [Mermaid](https://mermaid-js.github.io/mermaid/) Support thanks to [plugin by @amra](https://github.com/amra/reveal-md-scripts)
