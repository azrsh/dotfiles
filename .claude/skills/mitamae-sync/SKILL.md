---
name: mitamae-sync
description: Use this skill whenever working with mitamae cookbooks — either to test a cookbook change via dry-run, or to sync the current machine state back into the cookbook templates. Triggers on phrases like "dry-run", "test the cookbook", "verify with mitamae", "sync settings to cookbook", "absorb machine changes into dotfiles", or whenever default.rb or a managed config file (like ~/.claude/settings.json) has been edited and needs to be reconciled with the cookbook. Always invoke this skill to interpret dry-run output and decide the right fix direction — never just run the command and report raw output.
argument-hint: <cookbook-name-or-path>
allowed-tools: [Bash, Read, Edit, Glob, Grep]
---

# Mitamae Cookbook Sync

This skill has two complementary directions:

1. **Fix direction** — the cookbook has a problem; fix it so the dry-run goes clean.
2. **Sync direction** — the machine's current state is ahead of the cookbook; absorb the machine state into the template so the cookbook tracks it.

Both directions start from a dry-run and use its output as the source of truth.

## Resolving the target recipe

`$ARGUMENTS` is the cookbook name or path. If omitted, infer from recent edits or the managed files mentioned in the conversation.

- Short name → `cookbooks/<name>/default.rb`
- Already a path → use as-is

Mitamae root: `mitamae/` in this repo (contains `bin/mitamae`).

## Running the dry-run

```bash
cd <mitamae-root>
bin/mitamae local -n <recipe-path>
```

Exit code 0 = OK (diffs may still be shown). Non-zero = fatal error.

## Classifying each diff

For every diff in the output, determine **direction** and **intent** before acting:

| Classification | What it means | Action |
|---|---|---|
| **Intended** (template → machine) | Cookbook would update the machine as designed | Report; no fix needed |
| **Spurious** | Same content, different format | Fix the cookbook |
| **Unexpected** | Cookbook would make an unintended change | Diagnose; fix cookbook |
| **Machine-ahead** | Machine has content the template doesn't track | Decide: absorb into template, or let cookbook overwrite |

### Identifying Machine-ahead diffs

These appear as lines the machine has that the template would remove. Common cases:
- A config file on the machine has keys/sections added after the template was written (e.g., `hooks` in `~/.claude/settings.json`)
- The machine's file reflects a manual customization that should now become canonical

**Ask or infer which direction the user wants:**
- "Should this diff be absorbed into the cookbook, or should the cookbook overwrite the machine's version?"
- If the conversation context makes intent clear (e.g., the user just said "sync my settings to the cookbook"), proceed without asking.

### Absorbing machine state into the cookbook

When the user confirms a machine-ahead diff should be absorbed:

1. Read the current machine file.
2. Read the corresponding template in `cookbooks/<name>/files/<relative-path>`.
3. Merge or update the template so it tracks the machine's state.
4. Re-run the dry-run to confirm the diff is gone.

**This dotfiles repo's managed files:**

| Machine path | Template path |
|---|---|
| `~/.claude/settings.json` | `mitamae/cookbooks/claude_code/files/.claude/settings.json` |
| `~/.gitconfig` | `mitamae/cookbooks/git/files/.gitconfig` |
| `~/.vimrc` | `mitamae/cookbooks/vim/files/.vimrc` |
| `~/.config/nvim/init.vim` | `mitamae/cookbooks/vim/files/.vimrc` (shared source) |

## Fatal errors (non-zero exit)

Fix and re-run immediately. Common causes:

| Error | Cause | Fix |
|---|---|---|
| `undefined method 'require'` | mitamae uses **mruby** — no `require` | Remove the call; `JSON`, `File`, etc. are globally available |
| `undefined method 'X'` | mruby stdlib is a CRuby subset | Replace with a mruby-compatible alternative |
| Recipe not found | Wrong path | Check path resolution above |

## mruby constraints

- No `require` — `JSON`, `File`, `Dir` etc. are available without it
- `JSON.pretty_generate` omits spaces after `:` and `,` (differs from CRuby)
- `not_if` / `only_if` accept a Ruby block: `not_if { File.exist?(path) }`
- `file path do; action :edit; block do |content| ... end; end` — mitamae only writes if the string changed

## Iteration loop

After each fix or template update, re-run the dry-run. Repeat until:
- Only intended diffs remain (cookbook will update the machine as designed), or
- No changes (already converged)

## Final report

Summarize:
- **Intended diffs** — what will change on real apply
- **Fixes applied** — cookbook bugs fixed
- **Template updates** — machine state absorbed into cookbook
- **Caveats** — e.g., mruby format differences, merge semantics
