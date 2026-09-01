---
paths:
  - '**/{test_*.py,*.rb}'
---
<!-- Why a single line with brace expansion? Because right now it's a *must match all*
situation. Perhaps a bug in claude that has been fixed?
  - '**/test_*.py'
  - '**/*.rb'
-->

# Rules when running, writing or reviewing tests

- Prefer running single tests over the entire test suite for better performance.
- Test docstrings must begin with "Should" and describe the test's purpose.
- Use the AAA pattern. Include only one set of assertions per test.

## Python

- Always use pytest
- Name test files after the file under test, with a `test_` prefix.
  Example: `foo/bar/baz.py` -> `foo/bar/test_baz.py`
- Group tests into pytest classes by unit under test.
- Whenever patching, *always* use spec_set=True and autospec=True unless in conflicts
  with other parameters to the patch.

