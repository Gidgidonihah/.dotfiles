# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in
this repository.

## General guidelines

Request clarification for anything unclear or ambiguous.

## Repository Guidelines

- Never use git to stage or commit changes unless explicitly instructed.
- When making code changes, lint the code in this order of priority:
  1. black
  2. isort
  3. ruff
  4. mypy
  5. pylint
- Prefer running single tests over the entire test suite for better performance.

## Development Environment:

- Use Python 3.12+ with strict type hints.
- Install dependencies using: `poetry install`


## Bash commands

### Linting commands

- black: `black --config /Users/jason/Sites/termly/containers/termly/python-ci/pyproject.toml .`
- isort: `isort --sp /Users/jason/Sites/termly/containers/termly/python-ci/pyproject.toml --src . .`
- ruff: `ruff check --config /Users/jason/Sites/termly/containers/termly/python-ci/pyproject.toml .`
- mypy: `mypy --config-file /Users/jason/Sites/termly/containers/termly/python-ci/pyproject.toml .`
- pylint: `pylint --rcfile=/Users/jason/Sites/termly/containers/termly/python-ci/pyproject.toml **/*.py`


### Testing commands
 - Run all tests: `pytest tests/`
 - Run a single test: `pytest tests/path/to/test_file.py::TestClass::test_method`

## Code Style Guidelines:

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

## Testing Guidelines:

- Name test files after the file under test, with a `test_` prefix.
- Use pytest and pytest styles consistently.
- Group tests into classes by unit under test.
- Include only one set of assertions per test.
- Test docstrings should begin with "Should" and describe the test's purpose.
- Whenever patching, *always* use spec_set=True and autospec=True unless in conflicts
  with other parameters to the patch.

## Reviewing code

Whenever being asked to review code, do so as a seasoned programmer with over 20 years
of commercial experience.

Especially look at readability, maintainability, grokability, and organization of the code.

You are expected to identify any potential bugs, security vulnerabilities, or
performance issues and suggest specific improvements or optimizations.

Additionally, assess the code's adherence to industry standards and best practices.

Your feedback should be constructive and detailed, offering clear explanations and
recommendations for changes. Where applicable, provide examples or references to support
your suggestions. Your goal is to ensure that the code not only functions as intended
but also meets high standards of quality and can be easily managed and scaled in the
future. This review is an opportunity to mentor and guide less experienced developers,
so your insights should be both educational and actionable.

## Commit messages

Whenever a commit message need be written, follow these guidelines. Never make the
commit directly, only provide the commit message.

Commit messages should:
* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 50 characters or less (not including ticket number and emoji)
* MUST include an applicable emoji at the end of the first line:
  * See https://gitmoji.carloscuesta.me for examples
* SHOULD include the Jira ticket number in brackets at the end of the first line (after
  the emoji): [TER-123]
  * May be omitted if this is not the first commit on a branch
* If the Jira ticket is unknown, ask the user to provide it before writing the commit message

The PR title and message are the most important. The PR title contains the 50 character
short string that appears in the git logs.  When only one commit is included at time of
creation, the PR title and message default to the sections in the commit message. When
multiple commits are included upon creation, it must be filled out manually.

### Commit message sections:

For PRs and initial commits, all 3 sections are required.  For all additional
commits, you may omit section 2.

If no task is associated with the work, you may omit section 3.

Each section is separated by a single blank line

#### The What:

* It completes the sentence, "This change will..."
* It does not end in a period
* It is no longer than 50 characters (not including emoji and ticket number)
* It ends with an emoji and the ticket number in brackets: 🐛 [TER-123]
  * The emoji and ticket number may exceed the 50 character limit

#### The Why:

* Why specifically and technically is this change being made?
* If referencing details for which the files inside this commit provide context, also
  reference those files here as that information will be muddied in a squashed message.
* This can also be used to generate changelogs

#### The Where:
Where can I find more information about this task?

* Why the Jira ticket, of course!
* You may list more than one ticket
* Each ticket on its own line.

This allows github to automatically link to the jira ticket

### Example Commit Message

```
Implement a simple queue system ✨ [TER-123]

The robust queue system that we want is quite complex. We need
to have a good starting place. This will implement a simple queue
system that will only send emails upon triggered events. No digests included.

Key Features:
- SQS-based implementation with native FIFO queue support
- Event-triggered email sending without digest functionality
- Managed system approach for better reliability

It was decided that using SQS would be a better implementation because it
supports a native FIFO queue. We also looked at RabbitMQ and Redis Queues but
ultimately decided in favor of SQS because it supports FIFO and is a managed
system.

TER-123
```

### Good PR Descriptions

Follow standard git commit message guidelines to write a good commit message.

If you've followed those guidelines, the commit message from the first commit may be all you need.

It might include a brief description of the problem that’s being solved, and why this is the best approach. If there are any shortcomings to the approach, they should be mentioned. Include background information such as JIRA tickets, benchmark results, and links to design documents as necessary.

If you include links to external resources consider that they may not be visible to future readers due to access restrictions or retention policies. Where possible include enough context for reviewers and future readers to understand the PR.

Include any tasks that will need to be completed alongside or after the PR is merged, along with relevant Jira tickets.

Even small PRs deserve a little attention to detail. Put the PR in context.

#### Bad descriptions
`Fix bug` is an inadequate PR description. What bug? What did you do to fix it?
Other similarly subpar examples include:
* `Fix build.`
* `Add patch.`
* `Moving code from A to B.`
* `Phase 1.`
* `Add convenience functions.`, `kill weird URLs.`
Although short, they do not provide enough useful information.
