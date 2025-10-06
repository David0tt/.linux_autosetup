---
mode: agent
---
# Task: Clean up the code to adhere to proper and consistent style guidelines. Add appropriate documentation and type hints. Do not change the logic of the code.

## Do: 
- place appropriate and consistent docstrings 
- put correct type hints where appropriate
- use descriptive names (e.g. for variables, functions, classes)
- use comments sparingly, only where an additional explanation is necessary
- apply these modifications only to the directly attached file(s)
- ensure the code is clean, readable, and maintainable
- Adhere to PEP8 > PEP257 > PEP484 > Google Python Style Guide conventions in that order of importance.

## Don't:
- be overly verbose
- Refactor or change logic/control flow, side effects, data structures, I/O, or external behavior.
- Change function signatures beyond adding type annotations.
- Introduce dependencies or modify configuration


## Quick Style Guide (Concise)

- General
  - 4-space indents; no tabs. Max line length: 79 (72 for docstrings).
  - Keep imports at top; group as: stdlib, third-party, local. One per line.
  - Avoid wildcard imports. Prefer absolute imports.
  - Use with for resources; close files/sockets deterministically.

- Naming
  - Modules: lower_case_with_underscores
  - Packages: lowercase
  - Classes/Exceptions: CapWords
  - Functions/variables: lower_case_with_underscores
  - Constants: UPPER_CASE_WITH_UNDERSCORES
  - Internal (non-public): single leading underscore

- Whitespace
  - One space around binary operators and after commas/colons; none inside () [] {}.
  - No trailing whitespace. No aligning with extra spaces.
  - Two blank lines around top-level defs; one between class methods.

- Expressions and statements
  - Prefer simple comprehensions; avoid multiple fors/if in one comp if it hurts readability.
  - Avoid compound statements on one line.
  - Use isinstance instead of type(...) is ....
  - Compare to None with is / is not.
  - Prefer truthiness (if seq:) for emptiness checks.
  - Use str.startswith/endswith, not slicing.

- Exceptions
  - Catch specific exceptions, not bare except.
  - Keep try blocks small; use finally or context managers for cleanup.
  - Derive custom exceptions from Exception; name ends with Error.

- Strings and logging
  - Use consistent quoting; f-strings/format for formatting.
  - Don’t build strings with + in loops; accumulate then ''.join(...).
  - For logging APIs that accept %-style, pass a literal format string and args (no f-strings).

- Docstrings (PEP 257, Google style)
  - Triple double quotes. One-line summary ends with period.
  - Multi-line: summary, blank line, details.
  - Docstring required for public modules, classes, functions, and methods.
  - For functions: include Args:, Returns: (or Yields:), Raises: when non-trivial.
  - Class docstrings: describe purpose; document public attributes in Attributes: section.

- Type hints (PEP 484)
  - Annotate public APIs. __init__ returns -> None. Generally omit annotations for self/cls.
  - Prefer abstract collections for parameters (Sequence, Mapping, Iterable). Use concrete types for returns if needed.
  - Optional values: T | None (or Optional[T]); do not rely on default None implying Optional.
  - Use TypeVar for generics; NewType for distinct ID-like types; cast sparingly.
  - Callable[..., R], NoReturn for functions that never return, Type[T] for class objects.
  - Forward references: from __future__ import annotations (preferred) or quotes.
  - Conditional typing imports under if typing.TYPE_CHECKING:.

- Imports formatting (Google)
  - Order: future, stdlib, third-party, repo sub-packages.
  - Sort lexicographically within groups. Optional blank line between groups.

- Misc
  - Avoid mutable default arguments. Use None sentinel and initialize inside.
  - Use properties only for simple/cheap logic.
  - Guard execution with if __name__ == "__main__":.

## Links
- PEP 8: https://peps.python.org/pep-0008/
- PEP 257: https://peps.python.org/pep-0257/
- PEP 484: https://peps.python.org/pep-0484/
- Google Python Style Guide: https://google.github.io/styleguide/pyguide.html
