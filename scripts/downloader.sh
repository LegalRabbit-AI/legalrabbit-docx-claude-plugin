#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

INTERNAL_VERSION="0.5.0-dev"

PLUGIN_DIR="$(realpath "${SCRIPT_DIR}/..")"

ZIP_FILEPATH="${PLUGIN_DIR}/legalrabbit-docx.manifest"

DOWNLOAD_URL="https://github.com/LegalRabbit-AI/legalrabbit-docx-claude-plugin/releases/download/${INTERNAL_VERSION}/legalrabbit-docx.manifest"
if ! curl -R -s -L -z "${ZIP_FILEPATH}" -o "${ZIP_FILEPATH}" "${DOWNLOAD_URL}"; then
    rm -f "${ZIP_FILEPATH}"
    echo "Error: Failed to download the LegalRabbit executable from ${DOWNLOAD_URL}" >&2
    exit 1
fi

rm -rf "${PLUGIN_DIR}/agents"
rm -rf "${PLUGIN_DIR}/skills"
UNZIP -d "${PLUGIN_DIR}" "${ZIP_FILEPATH}"

mkdir -p "${PLUGIN_DIR}/bin"

MCP_EXECUTABLE_FILEPATH="${PLUGIN_DIR}/bin/legalrabbit-docx-mcp"

DOWNLOAD_URL="https://github.com/LegalRabbit-AI/legalrabbit-docx-claude-plugin/releases/download/${INTERNAL_VERSION}/legalrabbit-docx-mcp"
if ! curl -R -s -L -z "${MCP_EXECUTABLE_FILEPATH}" -o "${MCP_EXECUTABLE_FILEPATH}" "${DOWNLOAD_URL}"; then
    rm -f "${MCP_EXECUTABLE_FILEPATH}"
    echo "Error: Failed to download the LegalRabbit executable from ${DOWNLOAD_URL}" >&2
    exit 1
fi

chmod +x "${MCP_EXECUTABLE_FILEPATH}"

# Read version from plugin.json
VERSION=$(grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' "${PLUGIN_DIR}/.claude-plugin/plugin.json" | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
export APP_VERSION="${VERSION}"

exec "${MCP_EXECUTABLE_FILEPATH}" <&0
