# CLAUDE.md

## Writing

These rules apply to every piece of text you produce: chat replies, code comments,
commit messages, PR descriptions, review replies, Jira tickets, Slack messages, docs.

@~/.claude/voice.md

## Modal usage

Unless told otherwise, when planning implementation use Opus.
When doing the actual implementation, use Sonnet.

## General rules

<!--
  Note: Language specific guidelines are found in rules/<lang>.md
  As are other rules that apply to specific files (e.g. testing.md)
-->

- Request clarification for anything unclear or ambiguous.
- Never use git to stage or commit changes unless explicitly instructed.
- Never submit code review responses unless explicitly instructed. Only draft them.

## Styleguide

- Logging:
  * Emoji are welcome, but not required, in logs
- YAML files: always use the `.yaml` extension, never `.yml`

## Code comments

When adding code above comments, keep the verbosity to a minimum. Retain only the
necessary bits. Do not reference tickets. Only use a comment to explain the why when it
can't be easily derived from the code.

## Repo scratchpad

When making plans or creating temporary files or otherwise creating scratchpad files for
a repo,  specifically when working on a ticket, place the files in a sandbox/ folder at
the repo root.
Ticket plan files should be named `<TICKETNUMBER>.plan.md`

Use a markdown frontmatter to indicate the ticket number and the claude session
discussing it. Example:

```
--
Jira Ticket: TER-12345
Claude Session Name: TER-19717/monitor-changes
--
```

If the session name changes and we have a plan file in use, update it. However, if we
stat a *new* session and reference the plan emit a warning and ask the user to verify.

The plan file should have a TL;DR section after the frontmatter with a short (1-2
sentences) summary and then a markdown task list showing what has been completed, and
what remains.

## Production access

Never try to access production (or staging) without explicit direction to do so. Instead
provide what would be run on production, or prompt for a decision.
