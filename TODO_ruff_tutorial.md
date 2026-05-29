################################################################################
###  >>> BEGIN RUFF TUTORIAL
################################################################################


# Setting up ruff formatter
in environment: 

    pip install ruff

in VSCode settings

  "python.linting.enabled": true,

  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true
  },

  "editor.codeActionsOnSave": {
    "source.fixAll.ruff": "explicit",
    "source.organizeImports.ruff": "explicit"
  }, 


# Add to project config (pyproject.toml)

    [tool.ruff]
    line-length = 88
    target-version = "py312"

    [tool.ruff.lint]
    select = ["E", "W", "F", "I", "UP", "B", "SIM", "C4", "N", "PTH", "RUF"]
    # E: pycodestyle errors
    # W: pycodestyle warnings
    # F: pyflakes
    # I: import sorting
    # UP: pyupgrade, modernize pythono syntax
    # B: flake8 bugbear checks
    # SIM: flake8 simplify code
    # C4: flake8 better comprehensions
    # N: PEP8 naming conventions
    # PTH: flake8 prefer pathlib
    # RUF: ruff specific rules

    [tool.ruff.format]
    quote-style = "double"
    indent-style = "space"

# Can manually use it using 

    ruff check .
    ruff check . --fix
    ruff format .

# If typechecking is needed: use Pylance


# TODO: when using this, i should remove the black formatter extension

################################################################################
###  <<< END RUFF TUTORIAL
################################################################################


################################################################################
###  Install ruff pre-commit (see also: https://github.com/astral-sh/ruff-pre-commit)
################################################################################
# install pre-commit in the environment 
pip install pre-commit

# Create or update the `pre-commit-config.yaml` in the project root

```
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.15.15  # Use the latest version
    hooks:
      # Run the linter
      - id: ruff
        args: [--fix]  # Optional: auto-fix issues
      # Run the formatter
      - id: ruff-format
```

# Install the hooks: 
pre-commit install

# Now the pre-commit hooks are executed whenever you run 
git commit 

# If for some commit you want to ignore these, you can run
git commit --no-verify


################################################################################
###  >>> END Install ruff pre-commit (see also: https://github.com/astral-sh/ruff-pre-commit)
################################################################################


################################################################################
###  Git cheatsheet
################################################################################


# To get changes from a different branch into the current branch (and rebase, to make the history nice)

    git rebase main

# Workflow to choose the changes from a big change (e.g. AI from code refactor) and apply them individually

# 1. Create a backup branch containing ALL current changes
# starting from the current messy working tree:
# create backup branch
git switch -c backup/code-cleanup

# 1.1 commit everything as a safety snapshot
git add -A 
git commit -m "WIP: full refactor snapshot before commit splitting" # or some other message

# 2. return to the original branch, from which you now want to apply the changes piece by piece (and potentially make commits for each individual change)
git switch feature/isaac_sim_backend


# 3. show all the changed files, and open the difftool for multiple files:
git diff --name-only feature/isaac_sim_backend..backup/code-cleanup

# 3.1 With gitlens installed, right click the wanted files -> Open Changes -> Open Changes with Branch or Tag..
# Do this for all files that are related to each other

# or do: 
git difftool backup/code-cleanup -- path/to/file.py

# 3.2 Apply the changes using the difftool, or make own edits
# Then add and commit individual changes and repeat
git add -A 
git commit -m "some atomic change"

# 3.2 repeat, until all desired changes are applied

# 4. verify completion 
git diff feature/isaac_sim_backend..backup/code-cleanup


# Note in step 3, sadly just opening the difftool does not work, since it just opens tmp files
git difftool feature/isaac_sim_backend..backup/code-cleanup


# Maybe applying hunks directly from backup branch could also be a good workflow
# git restore -p --source backup/code-cleanup .
# This lets Git ask: Apply this hunk to working tree [y/n/s/e]?
# You can selectively pull changes FROM the backup branch into the clean branch interactively.

# Git cherry-pick could also be useful for selecting specific commits from another branch


################################################################################
###  <<< END git cheatsheet
################################################################################

