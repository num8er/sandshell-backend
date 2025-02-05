#!/bin/zsh

# Variables
LOCAL_DIR="/Users/num8er/My/Sandshell/sandshell_backend/"
REMOTE_USER="num8er"
REMOTE_HOST="dev0.sandshell.dev" # e.g., example.com or an IP address
REMOTE_DIR="/apps/sandshell_backend"

# Rsync command
rsync -avz --delete \
    --exclude-from=".sync_backend.exclude" \
    "$LOCAL_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

# Explanation of options:
# -a: Archive mode (preserves permissions, timestamps, symbolic links, etc.)
# -v: Verbose output
# -z: Compress data during transfer
# --delete: Deletes files on the destination that are not in the source
# --exclude-from="exclusion list file": Exclude files and directories listed in the specified file

VERSION=$(grep -E 'version:' mix.exs | sed -E "s/.*version: \"([^\"]+)\".*/\1/")

RELEASES_DIR="$REMOTE_DIR/_releases"
RELEASE_DIR="$RELEASES_DIR/$VERSION"

COMMANDS=(
  "cd $REMOTE_DIR ; rm -rf deps && mix deps.get"
  "cd $REMOTE_DIR ; MIX_ENV=dev mix cmd --app sandshell_api mix release --overwrite --path $RELEASES_DIR --version $VERSION"
  "cd $REMOTE_DIR ; rm -rf $RELEASE_DIR ; mkdir -p $RELEASE_DIR ; cd $RELEASES_DIR ; tar -zxf sandshell_api-$VERSION.tar.gz -C $VERSION"
  "cd $REMOTE_DIR ; cd $RELEASE_DIR ; ./bin/sandshell_api stop ; sleep 1 ; ./bin/sandshell_api daemon"
)

# Loop through each command and execute via ssh
for CMD in "${COMMANDS[@]}"; do
  echo "EXECUTING: $CMD"
  ssh -t "$REMOTE_USER@$REMOTE_HOST" "$CMD"
done
