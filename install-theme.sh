#!/bin/bash

# 顯示幫助訊息的函式
show_help() {
    cat << EOF
用法: $(basename "$0") <主題名稱>

從 npm 安裝 jsonresume 主題。主題套件名稱將會是 'jsonresume-theme-<主題名稱>'。

可用的主題可以在以下網址找到：
https://www.npmjs.com/search?ranking=maintenance&q=jsonresume-theme

參數:
    <主題名稱>   要安裝的主題名稱 (例如: elegant)。

選項:
    --help, -h     顯示此幫助訊息並離開。
EOF
}

# 檢查是否需要顯示幫助
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# 檢查是否提供主題名稱
if [ -z "$1" ]; then
    echo "錯誤：需要提供主題名稱。" >&2
    show_help
    exit 1
fi

THEME_NAME=$1
PACKAGE_NAME="jsonresume-theme-${THEME_NAME}"

echo "正在安裝主題: ${PACKAGE_NAME}..."

# 執行 npm install 指令
npm install "${PACKAGE_NAME}" --save-dev

# 檢查 npm 指令的結束狀態
if [ $? -eq 0 ]; then
    echo "主題 '${THEME_NAME}' 已成功安裝。"
else
    echo "錯誤：安裝主題 '${THEME_NAME}' 失敗。請檢查主題名稱後再試一次。" >&2
    exit 1
fi
