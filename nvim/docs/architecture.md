# Architecture

The configuration has two layers, and the split is the point:

```text
init.lua
  ├── lua/config/    behavior that is not a plugin
  └── lua/plugins/   plugin specifications, one file per area
```

## lua/config

Everything here would exist even if lazy.nvim did not:

```text
init.lua       startup order and the Config* commands
options.lua    editor options
autocmds.lua   automatic behavior and filetype options
keymaps.lua    every user-facing mapping, and the keymap manual
toggles.lua    per-buffer assistance toggles, learning mode, minimal mode
langs.lua      the one switch: enabled languages and their tools
lsp.lua        server definitions and per-buffer attach/detach
lazy.lua       lazy.nvim bootstrap and the plugin list
health.lua     health checks derived from langs.lua
icons.lua      the semantic glyphs this config owns
```

Startup order in `init.lua` is deliberate: options, then autocmds, then toggles
(they own the diagnostic handlers the first file needs), then plugins, then the
LSP, and keymaps last so nothing can claim a key after the user-facing one.

## lua/plugins

Every file here is a Lazy spec, and `config/lazy.lua` imports the directory, so
a new file is a new feature area with no list to update. Each file owns one area:

```text
ui          colorscheme, statusline, notifications, maximize
snacks      shared primitives: picker, terminal, notifier, git tools
coding      Mason, completion, formatting, linting, LSP-facing tools
editing     pairs, surrounds, comments, Tree-sitter, undo tree
navigation  Oil, Flash, TODO comments, find and replace
git         Gitsigns and Diffview
project     tasks and per-directory sessions
terminal    terminal commands and the last-terminal workflow
ai          explicit, selection-scoped AI editing and code search
repl        interactive code execution
debug       DAP and the adapters for the enabled languages
school42    header, Norminette, c_formatter_42
```

Snacks is configured once in `plugins/snacks.lua`. Everything else consumes
`Snacks.*` rather than declaring a second copy of those options.

## Rules

1. A feature exists because a line says so, never because a switch elsewhere is true.
2. `langs.lua` is the only switch; derive, do not duplicate.
3. Every user-facing mapping goes in `config/keymaps.lua`, including the ones a
   plugin would install for itself.
4. Add a file to `lua/plugins/` only when it owns a feature area of its own.
5. Reuse an existing command or plugin before installing anything.
6. Prefer built-in Neovim behavior when it already solves the problem.

## Derived, not declared

The point of `langs.lua` is that these are all the same list seen from different
sides, and none of them is written twice:

| Consumer | What it reads |
| --- | --- |
| `config/lsp.lua` | `profile.lsp`, and starts it only if the binary exists |
| `plugins/coding.lua` | `profile.formatters`, `profile.linters` |
| `plugins/debug.lua` | `profile.debugger` |
| `plugins/repl.lua` | `profile.repl` |
| `plugins/school42.lua` | `profile.norm` |
| `config/keymaps.lua` | whether any of the above exist at all |
| `config/health.lua` | all of them, to report what is missing |
| `bin/lang/<name>.sh` | the same tools, installed explicitly |

## UI icons

`lua/config/icons.lua` keeps only the state and tool glyphs with no natural
source: diagnostics, learning and maximize indicators, window titles, TODO
markers, and debugger signs. File and LSP-kind glyphs come from `mini.icons`.
Snacks uses its defaults, and Mini Clue keeps plain group names, so the config
carries no separate decoration layer.

## Performance rules

1. Lazy-load a plugin unless something correct depends on its API at startup.
2. Blink is the exception and stays eager: its LSP capabilities have to be sent
   when a server is configured, not when completion first runs.
3. Tree-sitter and Snacks stay startup-loaded because their supported setup
   expects it.
4. Prefer tagged prebuilt native components; compile only as a verified fallback.
5. Measure with `:Lazy profile` before adding loading conditions.
