# OpenClaw Continuity Backup

This repository stores core OpenClaw agent continuity data for disaster recovery.

## What's Backed Up

- `core/` - Core identity and configuration files
  - MEMORY.md - Long-term memory index
  - USER.md - User context
  - SOUL.md - Agent identity
  - IDENTITY.md - Agent identification
  - TOOLS.md - Tool configurations
  - AGENTS.md - Operating rules
  - HEARTBEAT.md - Periodic check configurations
  - SESSION-STATE.md - Current session state

- `memory/` - Daily memory logs (YYYY-MM-DD.md)
- `topics/` - Curated topic memories

## What's NOT Backed Up (Security)

- Secrets, tokens, API keys, passwords
- node_modules, skills, plugins
- Large cache files
- Temporary files
- openclaw-config.json (contains secrets)

## Recovery Instructions

1. Clone this repository
2. Copy files back to `~/.openclaw/workspace/`
3. Restore memory: `cp -r memory/ ~/.openclaw/workspace/`
4. Restore topics: `cp -r topics/ ~/.openclaw/workspace/`

## Auto-Backup

Automated via cron. Runs daily at 02:00 UTC if files changed.
