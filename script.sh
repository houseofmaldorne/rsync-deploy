#!/bin/bash
set -eu

SSHPATH="$HOME/.ssh"
mkdir -p "$SSHPATH"
echo "$DEPLOY_KEY" >> "$SSHPATH/key"
chmod 600 "$SSHPATH/key"

# file with a list of files/folders which are NOT to be rsync'd
EXCLUDE_FILE="$HOME/exclude.txt"
cat "$EXCLUDE_FILES" >> "$HOME/exclude.txt"

DEPLOY_STRING="$REMOTE_USER@$REMOTE_SERVER:$REMOTE_PATH"

# sync it up
sh -c "rsync -ahz --force --delete --progress --exclude-from=$EXCLUDE_FILE -e 'ssh -p22 -i $SSHPATH/key -o StrictHostKeyChecking=no -p $REMOTE_PORT' $GITHUB_WORKSPACE/$FOLDER $DEPLOY_STRING"
