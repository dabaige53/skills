---
name: codex-handoff
description: Hand the current conversation off to a fresh Codex task that starts working immediately from a concise context summary. Use when the user asks to hand off or continue the current work in a new Codex task. Also supports returning the handoff prompt without creating a task when explicitly requested.
---

Write a handoff summary of the current conversation so a fresh Codex task can continue the work. Instead of saving it, launch a new user-visible Codex task seeded with the summary as its initial prompt. It starts in the current project and returns immediately; the user manages it from the Codex task list.

Treat explicit invocation of this skill as authorization to create the new task. If the user explicitly asks for a prompt only, return the summary without creating anything.

Use the official Codex thread-management tools:

- Resolve the current saved project when project context is available, then call `create_thread` with its local environment and the handoff summary as the prompt.
- Use a projectless task only when the current work is genuinely projectless.
- Do not use `fork_thread`: handoff transfers distilled context, not the full conversation history.
- Do not use a subagent: the destination must be a user-owned task that can be opened and continued directly.
- Set a descriptive title such as `Fix login bug` or `Continue dashboard binding audit`.

Include:

- **Objective:** what the new task should accomplish.
- **Current state:** what has already been decided, changed, or verified.
- **Source of truth:** files, commits, issues, URLs, tasks, logs, or commands to inspect first.
- **Suggested skills:** only skills materially useful to the continuation.
- **Boundaries:** what must not change without confirmation.
- **Verification:** evidence that proves completion.
- **Open questions:** only decisions that block the next action.

Do not duplicate content already captured in PRDs, plans, ADRs, issues, commits, diffs, or handoff artifacts. Reference them by path or URL instead.

Redact secrets, tokens, cookies, credentials, account values, personal data, and private URLs because the summary becomes the new task's prompt. If the user supplied arguments, use them as the destination task's focus.

After creation, report the new task ID or created-task directive. In prompt-only mode, return the complete handoff summary.
