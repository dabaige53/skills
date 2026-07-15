---
name: codex-handoff
description: Fork the current Codex task and continue in a fresh task that inherits the completed conversation history. Use when the user asks to hand off or continue the current work in a new Codex task. Also supports producing a handoff prompt without creating a task when explicitly requested.
---

Hand the current work to a fresh Codex task through the official thread-management tools. Do not use a subagent for handoff.

## Default: fork the current task

When the user asks to hand off or continue in a new task:

1. Call `fork_thread` for the current task. Use the same directory by default; request a worktree only when the user explicitly asks for repository isolation.
2. Remember that a fork inherits only completed conversation history. The active turn that performs the fork is not copied.
3. Immediately call `send_message_to_thread` for the returned task ID with a concise continuation instruction that captures the user's latest objective and anything decided during the active turn.
4. Give the fork a short descriptive title when the thread tools allow it.
5. Report the new task ID or created-task directive.

Do not paste a full conversation summary into the child: the fork already carries completed history. The follow-up message should contain only the delta needed to bridge the active turn:

- the next objective;
- decisions or changes made during the active turn;
- any new source-of-truth pointer;
- boundaries and completion evidence that were not already in completed history.

Use `create_thread` instead of `fork_thread` only when the user explicitly asks for a clean task with no inherited conversation history.

## Prompt-only mode

If the user explicitly says not to create or fork a task, return a concise handoff prompt instead. Include the objective, current state, source-of-truth pointers, boundaries, verification, and blocking questions. Reference existing artifacts instead of duplicating them.

In both modes, redact secrets, tokens, cookies, credentials, personal data, and private URLs. Treat supplied arguments as the continuation focus.
