# trace-lab.net

Lab website for Trace Lab, running on Hugo (PaperMod theme) and hosted on Akamai/Linode.

---

## How the site works

- Content lives in the `content/` directory as Markdown files
- Pushing to `main` automatically deploys the site via GitHub Actions
- The live site is at [trace-lab.net](https://trace-lab.net)
- Interactive experiments are at [experiments.trace-lab.net](https://experiments.trace-lab.net)

---

## Making changes

### 1. Clone the repo (first time only)

```bash
git clone https://github.com/Gnarwha13/trace-lab.git
cd trace-lab
```

### 2. Create a new branch

Always work on a branch, not directly on `main`:

```bash
git checkout -b your-name/what-youre-changing
# e.g. git checkout -b sara/add-publications
```

### 3. Edit content

All site content lives in the `content/` folder:

```
content/
├── _index.md          # Homepage text
├── research/          # Research projects
├── people/            # Team member profiles
├── publications/      # Papers and outputs
└── experiments/       # Links to experiment pages
```

To add a new page, create a `.md` file in the relevant folder:

```bash
# Example: add a new team member
touch content/people/sara-smith.md
```

Every page needs a header block at the top:

```markdown
---
title: "Sara Smith"
date: 2026-03-09
---

Sara is a postdoc working on...
```

Then write your content in plain Markdown below the `---`.

### 4. Preview locally (optional)

If you have Hugo installed locally:

```bash
hugo server
```

Then open [http://localhost:1313](http://localhost:1313) in your browser.

### 5. Push and open a pull request

```bash
git add .
git commit -m "describe what you changed"
git push origin your-branch-name
```

Then go to [github.com/Gnarwha13/trace-lab](https://github.com/Gnarwha13/trace-lab), open a Pull Request, and request a review. Once approved and merged to `main`, the site deploys automatically within about 30 seconds.

---

## Common content tasks

### Update the homepage

Edit `content/_index.md`.

### Add a team member

Create `content/people/firstname-lastname.md`:

```markdown
---
title: "First Last"
date: 2026-03-09
---

Brief bio here. Research interests, background, contact info.
```

### Add a publication

Create `content/publications/paper-short-title.md`:

```markdown
---
title: "Full Paper Title"
date: 2026-03-09
---

**Authors:** First Last, First Last

**Published in:** Journal/Conference Name, Year

**Abstract:** ...

[PDF](#) | [Code](#) | [DOI](#)
```

### Add a research project

Create `content/research/project-name.md`:

```markdown
---
title: "Project Name"
date: 2026-03-09
---

Description of the project, goals, methods, and current status.
```

---

## Updating the experiments app

The Streamlit experiments app lives on the server at `/var/www/experiments/app.py`. To update it, SSH into the Linode and edit the file directly — it reloads automatically.

---

## Infrastructure overview

| Component | Details |
|---|---|
| Hosting | Akamai Linode 2GB, Ubuntu 24.04 |
| Web server | Caddy |
| DNS + CDN | Cloudflare (orange cloud) |
| Static site | Hugo + PaperMod theme |
| Experiments | Streamlit on port 8501 |
| Deploy | GitHub Actions → SSH → `deploy-lab` |

---

## Need help?

Open an issue on this repo or contact the repo owner.
