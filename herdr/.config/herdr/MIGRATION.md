# tmux → herdr migration

Config: `herdr/.config/herdr/config.toml` (stowed to `~/.config/herdr/`)
Ghostty: `ghostty/.config/ghostty/config`

Validate any change with `herdr server reload-config && herdr config check`.
A clean reload does **not** validate plugin_action targets — those fail silently.

## Keybinds

Prefix is `ctrl+a`. Arrow scheme: horizontal = tabs, vertical = spaces, `prefix`+arrow = panes.

| Key | Action |
| --- | --- |
| `prefix+s` / `prefix+x` | split vertical / horizontal |
| `prefix+arrow` | focus pane |
| `ctrl+shift+left/right`, `ctrl+pageup/pagedown` | prev / next tab |
| `ctrl+shift+up/down` | prev / next space |
| `ctrl+w` | new tab |
| `prefix+shift+w` | new workspace |
| `prefix+shift+1..9` / `prefix+1..9` | switch workspace / tab |
| `prefix+,` | rename tab |
| `prefix+b` | workspace picker |
| `prefix+g` | gitui (popup) |
| `prefix+w` | herdr-bar (session picker) |
| `cmd+k` / `super+k` | command palette |
| `prefix+p` / `prefix+f` | fzf file picker → nvim |
| `prefix+n` | yazi (popup) |
| `prefix+shift+n` | yazi pane on the left, toggle (`herdr-yazi-side`, plugin pane `local.user.yazi`) |
| `prefix+a` | agenda in a focused right split (plugin pane `local.user.agenda`; `type = "pane"` keys are always zoomed) |
| `cmd+k` → `User: Toggle pane orientation` | side-by-side ↔ stacked (`herdr-pane-flip`; no built-in key exists) |
| `cmd+k` → `User: Toggle Remote Control` | collie LAN front door on/off (`collie-lan toggle`); `herdr-tab-status` shows ` on` or ` off` |
| `prefix+h` | toggle sidebar |
| `prefix+z` | zoom |
| `prefix+d` / `prefix+q` | detach |
| `prefix+shift+s` | settings |
| `prefix+shift+b` | new worktree (native, branch name only) |
| `prefix+c` | new worktree + agent (launcher form) |
| `prefix+shift+r` | reload config (shell command, shows a toast) |

Unbound deliberately: `rename_workspace` (reachable from the palette), `goto` and
`new_worktree` (unused; `prefix+c` covers worktree creation).

## Deliberate departures from tmux

- **Page keys are not bindable in herdr.** Its keybinding parser rejects `pageup`/`pagedown`/
  `home`/`end`/`insert`/`delete` — only letters, function keys, and enter/tab/esc/arrows.
  Ghostty translates the chord instead: `ctrl+page_up=csi:1;6D`.
- **`cmd+k`** is bound two ways because delivery is terminal-dependent: `super+k` (direct,
  needs Ghostty to forward Cmd) and `ctrl+alt+k` (a chord Ghostty can translate to). Ghostty has `cmd+k=unbind` so its clear-screen default gets out
  of the way. If `super+k` never arrives, swap that line to `cmd+k=csi:107;7u`.
- Both need a **new Ghostty window** to take effect, not just a config reload.
- No `-r` repeat mode; held-key repeat replaces it.
- `close_pane` is `prefix+shift+q`, not `X`, because `prefix+x` is the tmux split.

## herdr actions with no socket API

`settings`, `help`, `detach`, `goto`, `toggle_sidebar`, `edit_scrollback`, `resize_mode`,
`copy_mode` are client-side only. **No palette plugin can ever invoke them** — keep real
keybinds. Verified against `herdr api schema`.

## Plugins

| Plugin | Purpose |
| --- | --- |
| `vjeantet/herdr-palette` | command palette (`cmd+k`) |
| `jeffarese/herdr-bar` | session picker |
| `smarzban/herdr-file-viewer` | file tree; config stowed alongside |
| `persiyanov/herdr-reviewr` | agent diff review; **passive** (`auto_open = false`), gitui took over |
| `qu8n/herdr-automatic-rename` | tab = foreground program + Nerd Font glyph |
| `arjenblokzijl/herdr-launcher` | worktree + agent creation form (`prefix+c`) |
| `getpipher/herdr-sysmon` | metrics library; rendered once by `herdr-tab-status` in `tab_bar_right`, not per space |
| `AltanS/collie` | phone PWA (needs `bun`); fronted by Caddy on the LAN via `collie-lan`, see "Collie" below |
| `local.gitwatch` | feeds the sidebar's branch/git_status tokens |

`herdr-automatic-rename` renames the **agent** as well as the tab, not just the tab. With
`AUTO_INDEX_AGENTS=1` (its default), focusing a shell pane in a split that also holds an agent
rewrites the agent's session name to match the tab. `AUTO_INDEX_AGENTS=0` stops that and lets
herdr's own detection name the agent row. `AGENT_TITLES=1` stays on — that is what names a tab
after the agent's task and tells five claude tabs apart.

Its config lives at `herdr/.config/herdr-automatic-rename/config.sh`
(its own dir, not under `.config/herdr/`). It leaves hand-renamed tabs alone, so
`prompt_new_tab_name = false` is required — a name typed at the prompt counts as a hand rename
and opts the tab out permanently. Its shell hook (renames the instant a command starts, rather
than on the next tab event) still needs adding to `.zshrc`; see its README.

Marketplace is auto-indexed from the GitHub `herdr-plugin` topic with no vetting; stars are
popularity, not safety.

**Reinstalling on a new machine.** herdr keeps no declarative plugin list — `plugins.json` is a
generated cache full of absolute paths, and `.plugins.lock` is empty. The source of truth is
`herdr_plugin_list` in `ansible/config.yml`; `ansible-playbook ... --tags herdr` installs
anything missing and skips the rest. Add new plugins there, not just via `herdr plugin install`.

`arjenblokzijl/herdr-launcher` (`prefix+c`) replaced `royal-lobster.spinup`, now uninstalled. It declares `[[panes]]` with
`placement = "split"`, so herdr spawns the binary **directly, no shell** — the same mechanism
the palette, herdr-bar, file-viewer and reviewr use, and why those open instantly. A manifest
`[[panes]]` entry is the way to avoid shell startup; the CLI (`tab create`, `pane split`) takes
no command, which is a different thing.

Workflows are declarative TOML under `herdr/.config/herdr-launcher/workflows/`. `launch-agent`
asks title, prompt, agent, base branch, then creates a worktree and starts the agent. Building
it needs Rust, so `rust` is now declared in `asdf_plugins`.

Three fixes to the upstream `launch-agent` script, all in our copy:
- Its `agent start` call passed `--workspace/--cwd/--focus`, none of which that subcommand takes;
  under `exec` it failed silently and left a bare shell. It needs `--kind` plus an existing
  `--pane` (use `.result.root_pane.pane_id` from the worktree response), retried while the
  response says `agent_pane_busy` — a fresh pane is not at its prompt yet.
- Worktree creation uses `--focus`: the launcher is an explicit "take me to a new task" action.
  Scripted multi-repo loops should pass `--no-focus` instead so they do not yank focus per repo.

The diff pane comes from reviewr's `auto_open` (its own `config.toml`), not the launcher. Set it
`false` to stop a pane appearing on every worktree; `prefix+shift+v` toggles it either way.

Both plugins ship rosters naming binaries that aren't installed here (`codex`, `fresh`,
`tuicr`), and the example agent roster defaulted to `--dangerously-skip-permissions`. Check any
bundled command list before trusting it.

Spinup was uninstalled because its cost was its own design, not a herdr limit: a plugin manifest can declare
`[[panes]]` with `placement = "split" | "popup" | "tab"` and herdr spawns that command
**directly, with no shell** — which is why the palette, herdr-bar, file-viewer and reviewr open
instantly. Spinup declares only an `[[events]]` hook and drives the tab's shell via `pane run`,
paying shell startup plus paste-injection on every tab. The CLI (`tab create`, `pane split`)
genuinely takes no command; the manifest is the mechanism that does.

## Open

- [x] **Tab-bar colour: not possible, settled.** `herdrdev/herdr#3001` (ANSI bodies leaking
      as text) was fixed in 0.9.0 by PR 3003, "strip ansi sequences from tab bar status". The
      bar strips escapes rather than rendering them, and there is still no styling config for
      `tab_bar_right` and no separator/border glyph config. `herdr-tab-status` therefore stays
      plain text with glyphs. 0.9.0 did add value-based colour rules for **sidebar** tokens, which
      is where any coloured metric would have to live.

- [x] **Work/personal isolation.** `~/.claude/hooks/work-world-guard.sh`, wired as a
      `PreToolUse` hook. Denies the six employer MCP servers when cwd is outside
      the work checkout roots (set via `CLAUDE_WORK_DIRS`; the defaults live in the
      script, which is outside this repo).
      herdr cannot do this: `--env` does not inherit to panes split later.
- [x] **Tab bar right side.** One script, `bin/.local/bin/herdr-tab-status`: zoom glyph, collie
      state, CPU, memory, battery, joined by two spaces. It used to be three entries, and herdr's
      own gap between entries did not match the gap inside sysmon's line. A `command` entry is
      spawned WITHOUT a shell, so pipes and `&&` are literal args — put any pipeline in a script.
- [x] **terminal-browser** — was `TERM` plus a stale client. herdr hardcodes
      `TERM=xterm-256color`; `exports.zsh` corrects it to `xterm-ghostty` inside herdr.
      `experimental.kitty_graphics = true` needs a full detach/reattach, not a reload
      (zenbu-labs/terminal-browser#89). Works now.
- [x] **Auto-naming** — settled. `qu8n/herdr-automatic-rename` names tabs after the
      foreground program with Nerd Font glyphs and honours hand renames;
      `AUTO_INDEX_AGENTS=0` keeps it off agent rows. cwd-based naming and a
      dir-vs-process glyph split would need a custom plugin — deliberately not done.
- [x] **Sidebar tokens.** `bin/.local/bin/herdr-git-tokens` publishes `branch` and
      `git_status` per workspace; the `local.gitwatch` linked plugin runs it on startup and on
      workspace/worktree/pane-focus events. Add a `$linear` token the same way.
- [x] Plugin decisions made: native worktrees over `herdr-worktrunk`; `collie` installed;
      `herdr-plus`/`ramarivera-palette`/`herdmates`/`herdr-board` all evaluated and skipped.
## Collie

Collie's DEPLOYMENT.md "Variant C": the bridge binds `127.0.0.1:8787` and never runs
`tailscale serve` (the tailnet this Mac joins is not a personal one). Caddy is the only front
door, bound to the home LAN address with a cert from its own local CA and basic auth as the
per-device gate (`X-Device-Id` is SET from the basic-auth user, so a client cannot forge it).

- `collie-lan on|off|toggle|status|init`; the palette entry `User: Toggle Remote Control` runs
  `toggle`. `on` refuses when the default gateway MAC is not the home router (`--force`
  overrides), and Caddy is not registered at login, so a reboot or a coffee shop lands in the
  off state.
- Config lives outside the repo: `~/.config/collie-lan/env` (LAN address, router MAC, user,
  bcrypt hash; `collie-lan init` writes it) and the plugin's own `.env` under
  `~/.config/herdr/plugins/config/herdr.collie/` (`COLLIE_SKIP_SERVE=1`, `COLLIE_PUBLIC_HOSTS`,
  `COLLIE_ALLOWED_ORIGINS`, `COLLIE_DEVICE_HEADER`, `COLLIE_DEVICE_ALLOWLIST`, VAPID keys).
  The user in the env file must be in `COLLIE_DEVICE_ALLOWLIST` or the phone is read-only.
- The phone must trust Caddy's root CA once
  (`~/Library/Application Support/Caddy/pki/authorities/local/root.crt`: AirDrop it, install the
  profile, then Settings > General > About > Certificate Trust Settings). Without HTTPS the page
  works but the service worker, install and push silently no-op.
- Install from `https://<LAN IP>:8443` only. The PWA is pinned to one origin and `.local` names
  do not resolve through a VPN, so the address needs a DHCP reservation on the router. 8443 rather
  than 443 because this macOS denies non-root binds below 1024 (`bind: permission denied` on :80
  and :443), so the Caddyfile also has `auto_https disable_redirects`.
- `COLLIE_TRUSTED_USER` does nothing without `tailscale serve`; it fails open, so leave it unset.

## Gotchas that cost real time

- **herdr hardcodes `TERM=xterm-256color`** for the panes it spawns — it is the only TERM
  string in the binary and there is no config key for it. That advertises no kitty-graphics
  support, so image-rendering TUIs give up. `exports.zsh` now corrects it back to
  `xterm-ghostty` inside herdr (guarded on `$HERDR_ENV`, `$TERM_PROGRAM`, and an `infocmp`
  check). Takes effect in a NEW pane. The tmux-era `[[ -n $TMUX ]]` guard on the original
  override was a red herring — it fires before herdr overwrites the value anyway.
- **A `tab_bar_right` `command` entry gets no shell.** Pipes, `&&` and redirections are passed
  as literal argv. Put the logic in a script on PATH.
- **`${var/#pat/rep}` does not expand a leading `~` under bash** (it does under zsh). Strip
  `$HOME` with an explicit `case` instead, or a prompt silently shows the absolute path.
- **`~/.local/bin` is itself a symlink** into `bin/.local/bin/`, so files dropped there land in
  the repo automatically — and `rm`ing one there deletes it from the repo.

## Sidebar tokens: built-in vs custom

`branch` and `git_status` are **built-ins herdr computes itself**; a
`report-metadata --token branch=...` is silently ignored, and the row keeps showing herdr's
value. Custom metadata lives in a separate namespace and must be referenced with a **`$`
prefix** (`$gitref`). That is the whole trick — a custom token renders any text you like,
Nerd Font glyphs included, and takes the same inline `fg`/`bold`/`dim` styling.

`bin/.local/bin/herdr-git-tokens` therefore publishes five tokens, because **a token takes one
`fg` for its whole value** — anything needing its own colour needs its own token:
`$gitref` (glyph + branch), `$gitahead` (↑n), `$gitbehind` (↓n), `$gitclean` (✓),
`$gitdirty` (n). Clean and dirty are mutually exclusive by construction.
Inline styles accept **only** `fg`, `bold` and `dim` — there is no font-weight or per-token
font selection (`weight = "light"` is rejected).
Overriding a **built-in** name with an empty string leaves it blank permanently — herdr will
not recompute it — so own both fields in one place rather than mixing.

herdr never fetches: ahead/behind come from local refs, so `herdr-git-fetch` (launchd, 10 min)
keeps them honest.

## Verified API facts

Checked against the local 0.8.2 binary, not the docs.

- **Tabs carry no `tokens`** and have no `report-metadata` subcommand. Custom `$token` rendering
  is workspace- and pane-scoped only; tab customisation is `herdr tab rename <tab_id> <label>`.
- `herdr pane process-info` returns `name`, `argv0`, `cmdline`, `cwd`, `pid` per foreground
  process — a deterministic naming source, no LLM needed.
- 26 plugin event hooks exist. Useful ones: `pane.agent_detected`, `pane.agent_status_changed`,
  `tab.created`, `worktree.created`, `pane.exited`. `pane.updated` is excluded from plugin
  hooks; a plugin needing it must subscribe to the socket stream itself.
- `WorkspaceInfo` carries `worktree` (`repo_name`, `repo_root`, `is_linked_worktree`), which is
  what herdr groups the sidebar on. `is_linked_worktree` is not a renderable token.

## Won't fix

- **Prefix hint footer can't be disabled.** No config key exists; enumerated the full `[ui]`
  struct from the binary.
- **Nested sub-agent tree doesn't exist in herdr.** Its sidebar has two levels (space with
  worktree children, plus a flat agent panel). No plugin can add a third. `caioniehues/herdmates`
  gives panes-per-teammate, not a tree. This is the real gap vs Orca.
