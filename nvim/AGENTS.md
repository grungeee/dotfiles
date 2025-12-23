# Repository Guidelines

## Project Structure & Module Organization
This repo mirrors the active Neovim profile under `~/.config/nvim`. Keep only the config you truly override: Lua modules belong in `lua/config/`, optional plugin specs in `lua/plugins/`, and shared notes (this file, `luca_config.md`, `universal_coding_assistant_setup_v005.md`) live at the root. Document any new directories inside `docs/` or the relevant module README so future agents know why they exist.

## Build, Test, and Development Commands
Use the canonical commands below before every change set:
- `stow nvim` — symlink this folder into `$HOME` when bootstrapping or after structural changes.
- `nvim --headless "+Lazy sync" +qa` — install/upgrade plugins and fail fast on lockfile drifts.
- `nvim --headless "+checkhealth" +qa` — verify dependencies (node, python, clipboard) after plugin or tooling updates.
- `stylua lua/` — format Lua modules; add a `stylua.toml` if special rules are needed.

## Coding Style & Naming Conventions
Favor declarative Lua tables with two-space indentation and trailing commas so diffs stay tidy. Module files should describe their scope (`lua/config/ui.lua`, `lua/plugins/git.lua`) and return a single table. Prefer snake_case for local variables, PascalCase only when mirroring plugin APIs. Keep Neovim option tweaks grouped and commented by surface (UI, editing, LSP) instead of mixing concerns inside one file.

## Testing Guidelines
There is no separate harness, so treat Neovim itself as the test runner. After edits, open `nvim` once interactively to confirm Lazy loads cleanly, keymaps resolve, and commands referenced in docs exist. For shared helpers, add lightweight assertions using `vim.validate` inside the module so misuse is reported during startup. Capture regressions or reproducible issues in `docs/` with repro steps and the commands you ran.

## Commit & Pull Request Guidelines
Follow Conventional Commit prefixes (`feat`, `fix`, `chore`, `docs`, `refactor`) and keep the subject under 72 characters. Describe why the change was needed in the body, including configs touched and validation commands. Pull requests should link the relevant issue or notebook entry, enumerate validation output, and attach screenshots for visual tweaks (UI colors, statusline). Avoid bundling unrelated edits; open follow-up PRs when in doubt.

## Security & Configuration Tips
Never commit machine-specific secrets or API tokens; keep them in `~/.local/share/` or environment files ignored by git. When sharing reproduction steps, strip usernames and hostnames from command samples. If a plugin requires credentials, document the expected env vars in `docs/setup.md` and reference them—instead of example secrets—within configuration files.
