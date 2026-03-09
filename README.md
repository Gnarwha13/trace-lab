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

## Writing Streamlit experiments

Streamlit is a Python library that turns a plain Python script into an interactive web app — no HTML or JavaScript needed. The experiments app lives at [experiments.trace-lab.net](https://experiments.trace-lab.net) and is served from `/var/www/experiments/app.py` on the server.

### How it works

Streamlit runs your script top to bottom and renders each line as a UI element. When a user interacts with a widget (slider, button, dropdown), the script reruns automatically with the new values — no callbacks needed.

```python
import streamlit as st

st.title("My Experiment")
x = st.slider("Pick a number", 0, 100)
st.write(f"You picked {x}")
```

That's a complete interactive app.

### Common UI elements

```python
# Text
st.title("Title")
st.header("Header")
st.write("Any text or variable")

# Inputs
x = st.slider("Label", min, max, default)
option = st.selectbox("Label", ["A", "B", "C"])
text = st.text_input("Label")
clicked = st.button("Run")

# Display
st.pyplot(fig)        # matplotlib figure
st.plotly_chart(fig)  # plotly figure
st.dataframe(df)      # pandas dataframe
st.image("path.png")  # image
```

### Adding a new experiment

The simplest approach is a single app with sidebar navigation. Edit `/var/www/experiments/app.py` on the server:

```python
import streamlit as st

page = st.sidebar.selectbox("Experiment", [
    "Home",
    "Experiment 1",
    "Experiment 2",
])

if page == "Home":
    st.title("Trace Lab Experiments")
    st.write("Select an experiment from the sidebar.")

elif page == "Experiment 1":
    st.title("Experiment 1")
    # your code here

elif page == "Experiment 2":
    st.title("Experiment 2")
    # your code here
```

The app reloads automatically when you save the file — no restart needed.

### Caching expensive computations

If your experiment loads a model or processes a large dataset, cache it so it only runs once:

```python
@st.cache_data
def load_data():
    # runs once, result is cached
    return pd.read_csv("data.csv")

df = load_data()
```

### Installing new Python packages

SSH into the Linode and install into the virtual environment:

```bash
source /var/www/experiments/venv/bin/activate
pip install package-name
sudo systemctl restart streamlit
```

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
