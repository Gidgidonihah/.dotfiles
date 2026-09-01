---
paths:
  - '**/*.py'
---
# Rules for Python

## Tooling

After making code changes, lint the code in this order of priority:

1. black (tblack)
2. isort (tisort)
3. ruff (truff)
4. mypy (tmypy)
5. pylint (tpylint)

Each has an alias provided (in parens) that includes the configuration file.

## Styleguide

- Docstrings:
  * Use Google-style with Args and Returns sections.
  * Write in imperative mood.
  * First line should be a single line ending with punctuation.
- Error handling:
  * Catch specific exceptions when possible.
  * Log broad exceptions appropriately.
- Naming conventions:
  * snake_case for variables/functions
  * PascalCase for classes
  * UPPER_CASE for constants
- Logging:
  * Use structured JSON logging by default.
  * Include additional properties via an `extra = {}` dict parameter.
  * Always use lazy % formatting in logging functions.
- Type hints should be consistent and specific.

