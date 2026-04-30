#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Read version from plugin.json
VERSION=$(grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' "${SCRIPT_DIR}/../.claude-plugin/plugin.json" | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

FILEPATH="${SCRIPT_DIR}/legalrabbit-docx-mcp-${VERSION}"

# Delete other versions
find "${SCRIPT_DIR}" -maxdepth 1 -name "legalrabbit-docx-mcp-*" ! -name "legalrabbit-docx-mcp-${VERSION}" -type f -delete 2>/dev/null

if [ ! -f "${FILEPATH}" ]; then
    # Download the file to the script's directory
    curl -s -L -o "${FILEPATH}" https://github.com/LegalRabbit-AI/legalrabbit-docx-claude-plugin/releases/download/${VERSION}/legalrabbit-docx-mcp

    # Make the downloaded file executable
    chmod +x "${FILEPATH}"

    echo "Download completed: ${FILEPATH}" >&2
else
    echo "File already exists, skipping download: ${FILEPATH}" >&2
fi

# Execute the binary
exec "${FILEPATH}"
