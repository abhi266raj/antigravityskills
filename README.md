# antigravityskills

Useful utilities, scripts, and terminal extensions for **Google Antigravity (`agy`)**.

---

## ⚡ `wqa` / `weeklyquotaagy`

**`wqa`** is an ultra-fast, local terminal utility for tracking weekly quota pacing and burn rates across **Gemini** and **Claude/GPT** models in Antigravity (`agy`).

### Preview

```text
╭──────────────────────────────────────────────────────────╮
│  WEEKLY PACING live(terminal)   2d 7h / 7d  lat:~28.5ms  │
├──────────────────────────────────────────────────────────┤
│  Gemini      [███████████░░░░░░░]  62% (+19%)            │
│  Claude/GPT  [██████░░░░░░░░░░░░]  34% (-8%)             │
╰──────────────────────────────────────────────────────────╯
```

### ✨ Key Features

- **🚀 Near-Zero Latency (~25-30ms)**: Auto-detects running interactive `agy` sessions and reads state directly, bypassing the 8–10s cold-start overhead of launching new CLI sessions.
- **🔄 Standalone / Offline Execution**: Runs directly in your shell—completely outside the AI chat prompt loop, saving LLM tokens and eliminating chat interface delays.
- **🎯 Dynamic Pacing Target**: Automatically calculates where your usage *should* be relative to the elapsed days in the 7-day quota window, color-coding whether you are ahead or behind your weekly budget.
- **⚡ Multiple Aliases / Commands**: Works via `wqa` or `weeklyquotaagy`.

---

## 📦 Setup & Installation

### 1. Clone the Repository

Clone directly to your preferred workspace or tools directory (e.g. `~/Documents/code/antigravityskills`):

```bash
cd ~/Documents/code
git clone https://github.com/abhi266raj/antigravityskills.git
cd antigravityskills
```

### 2. Make Binaries Executable

Ensure the scripts in `bin/` are executable:

```bash
chmod +x bin/weeklyquotaagy bin/wqa
```

*(Optional)* If you want to install them into another folder, you can also run:
```bash
chmod +x install.sh
./install.sh
```

---

## 🐚 Shell Configuration

To make `wqa` and `weeklyquotaagy` available from any terminal session, add the repository's `bin/` directory to your shell's configuration:

### 1. Zsh (`~/.zshrc`)

Add to `~/.zshrc`:

```bash
# 1. Add bin directory to PATH
export PATH="$HOME/Documents/code/antigravityskills/bin:$PATH"

# 2. Add alias
alias wqa="weeklyquotaagy"

# 3. In-process runner: sources directly for maximum sub-millisecond speed (~25-30ms)
weeklyquotaagy() {
  source "$HOME/Documents/code/antigravityskills/bin/weeklyquotaagy" "$@"
}
```

*(Optional)* High-Precision Microsecond Latency Hook (tracks latency from exact <kbd>Enter</kbd> keystroke):

```bash
zmodload zsh/datetime 2>/dev/null

_wq_enter() {
  typeset -g __ENTER_KEY_EPOCH=$EPOCHREALTIME
  zle .accept-line 2>/dev/null || zle accept-line 2>/dev/null
}
[[ -o interactive ]] && zle -N accept-line _wq_enter 2>/dev/null

_wq_preexec() {
  [[ -z "$__ENTER_KEY_EPOCH" ]] && typeset -g __ENTER_KEY_EPOCH=$EPOCHREALTIME
}
autoload -Uz add-zsh-hook 2>/dev/null
add-zsh-hook preexec _wq_preexec 2>/dev/null

_wq_precmd() { __ENTER_KEY_EPOCH=""; }
add-zsh-hook precmd _wq_precmd 2>/dev/null
```

Reload Zsh:
```bash
source ~/.zshrc
```

---

### 2. Bash (`~/.bashrc` or `~/.bash_profile`)

Add to your `~/.bashrc` (Linux) or `~/.bash_profile` (macOS):

```bash
# 1. Add bin directory to PATH
export PATH="$HOME/Documents/code/antigravityskills/bin:$PATH"

# 2. Add alias
alias wqa="weeklyquotaagy"
```

Reload Bash:
```bash
source ~/.bashrc        # On Linux
# or
source ~/.bash_profile  # On macOS
```

---

### 3. Fish (`~/.config/fish/config.fish`)

Add to `~/.config/fish/config.fish`:

```fish
fish_add_path $HOME/Documents/code/antigravityskills/bin
alias wqa="weeklyquotaagy"
```

---

## 🛠️ Usage

### Quick Execution
```bash
wqa
```

### Command Options

```text
Usage: weeklyquotaagy [--cached | --fetch] [--no-progress]

Options:
  --cached       Use cached data if < 1h old (auto falls back to live network if expired)
  --fetch        Force fresh live network fetch from agy (mutually exclusive with --cached)
  --no-progress  Disable animated progress spinner during network fetch
  -h, --help     Show help message
```

---

## ❓ Troubleshooting

### 1. `weeklyquotaagy:source:1: no such file or directory: /Users/.../.agents/scripts/weeklyquotaagy`
**Cause**: An existing terminal window still has the old in-memory function definition pointing to the previous path.  
**Fix**: Reload your shell configuration in that terminal window:
```bash
source ~/.zshrc
```
Or open a new terminal tab/window.

### 2. `command not found: wqa`
**Cause**: The repository's `bin/` directory hasn't been added to your current shell's `$PATH`, or the shell configuration hasn't been reloaded yet.  
**Fix**:
1. Check that `export PATH="$HOME/Documents/code/antigravityskills/bin:$PATH"` is present in your `~/.zshrc` (or `~/.zshenv` / `~/.bashrc`).
2. Run `source ~/.zshrc`.

---

## 🔗 Related & Links

- **Repository**: [https://github.com/abhi266raj/antigravityskills](https://github.com/abhi266raj/antigravityskills)
- **Primary Executables**:
  - [`bin/wqa`](bin/wqa) - Lightweight standalone wrapper
  - [`bin/weeklyquotaagy`](bin/weeklyquotaagy) - Core pacing monitor & ANSI renderer

---

## 📄 License

MIT

