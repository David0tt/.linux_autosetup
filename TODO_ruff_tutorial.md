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
