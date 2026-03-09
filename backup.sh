#!/bin/bash
# OpenClaw Continuity Backup Script
# Run via cron: 0 2 * * * /root/.openclaw/workspace/backup-github/backup.sh

BACKUP_DIR="/root/.openclaw/workspace/backup-github"
SOURCE_DIR="/root/.openclaw/workspace"
DATE=$(date +%Y-%m-%d)

# Files to backup (core continuity files)
CORE_FILES=(
    "MEMORY.md"
    "USER.md"
    "SOUL.md"
    "IDENTITY.md"
    "TOOLS.md"
    "AGENTS.md"
    "HEARTBEAT.md"
    "SESSION-STATE.md"
)

echo "=== OpenClaw Backup started at $(date) ==="

# Backup core files
for file in "${CORE_FILES[@]}"; do
    if [ -f "$SOURCE_DIR/$file" ]; then
        cp "$SOURCE_DIR/$file" "$BACKUP_DIR/core/$file"
        echo "Backed up: $file"
    fi
done

# Backup topics
if [ -d "$SOURCE_DIR/topics" ]; then
    cp -r "$SOURCE_DIR/topics"/* "$BACKUP_DIR/topics/" 2>/dev/null
    echo "Backed up: topics/"
fi

# Backup daily memory (only recent ones, skip if contains secrets)
if [ -d "$SOURCE_DIR/memory" ]; then
    for file in "$SOURCE_DIR"/memory/2026-03-*.md; do
        if [ -f "$file" ]; then
            # Skip files with API keys or secrets
            if ! grep -q "API_KEY\|token\|password\|secret" "$file" 2>/dev/null; then
                cp "$file" "$BACKUP_DIR/memory/"
                echo "Backed up: $(basename $file)"
            else
                echo "Skipped (contains secrets): $(basename $file)"
            fi
        fi
    done
fi

# Check for changes
cd "$BACKUP_DIR"
git add -A

if git diff --staged --quiet; then
    echo "No changes to commit."
else
    # Get change summary
    CHANGES=$(git diff --staged --stat | tail -1)
    echo "Changes: $CHANGES"
    
    # Commit with timestamp
    git commit -m "Backup $(date +%Y-%m-%d\ %H:%M): $CHANGES" --allow-empty
    
    # Push to GitHub
    git push origin main
    
    echo "Backup pushed to GitHub."
fi

echo "=== Backup completed at $(date) ==="
