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
- **🔄 Standalone / Offline Ready**: Can be run completely outside the AI prompt loop—no LLM tokens, no conversational delay.
- **🎯 Dynamic Pacing Target**: Automatically calculates where your usage *should* be relative to the elapsed days in the 7-day quota window, color-coding whether you are ahead or behind your weekly budget.
- **⚡ Multiple Aliases**: Works with `wqa`, `weeklyquotaagi`, or `weeklyquotaagy`.

---

## 📦 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/abhi266raj/antigravityskills.git
cd antigravityskills
```

### 2. Run the Installer

```bash
./install.sh
```

This installs both `weeklyquotaagy` and `wqa` into `~/.agents/scripts/`.

### 3. Configure Your Shell (`~/.zshrc`)

Add the directory to your `$PATH` and setup the aliases:

```bash
# Add to ~/.zshrc
export PATH="$HOME/.agents/scripts:$PATH"

# Direct aliases for instant execution
alias wqa="weeklyquotaagy"
alias weeklyquotaagi="weeklyquotaagy"
```

To enable microsecond enter-key precision latency tracking in `zsh`, optionally add:

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

weeklyquotaagy() {
  source "$HOME/.agents/scripts/weeklyquotaagy" "$@"
}
```

Reload your shell:
```bash
source ~/.zshrc
```

---

## 🛠️ Usage

### Quick Run
```bash
wqa
```
or
```bash
weeklyquotaagi
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

## 🔗 Related & Links

- **Repository**: [https://github.com/abhi266raj/antigravityskills](https://github.com/abhi266raj/antigravityskills)
- **Primary Executables**:
  - [`bin/wqa`](bin/wqa) - Lightweight binary entrypoint
  - [`bin/weeklyquotaagy`](bin/weeklyquotaagy) - Core pacing monitor & ANSI renderer

---

## 📄 License

MIT
