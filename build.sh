#!/bin/bash

# Default values
THEME="kendall"
FORMAT=""
FORMAT_SPECIFIED=false

# Function to display usage information
usage() {
    echo "Usage: $0 [-f format] [-t theme] [-h|--help]"
    echo
    echo "Options:"
    echo "  -f format    指定輸出格式 (pdf 或 html)。預設: 同時產生 pdf 和 html"
    echo "  -t theme     指定使用的主題。預設: ${THEME}"
    echo "  -h, --help   顯示此幫助訊息並結束。"
    exit 1
}

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f|--format)
            FORMAT_SPECIFIED=true
            if [[ "$2" == "pdf" || "$2" == "html" ]]; then
                FORMAT="$2"
                shift
            else
                echo "無效的格式: $2. 允許的值為 'pdf' 或 'html'。" >&2
                exit 1
            fi
            ;;
        -t|--theme)
            THEME="$2"
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "未知的參數: $1" >&2
            usage
            ;;
    esac
    shift
done

# Function to run the build command
build_resume() {
    local format=$1
    local output_file="resume.${format}"
    echo "正在建立 ${format} 格式履歷..."
    echo "主題: ${THEME}"
    echo "輸出: ${output_file}"
    npx resume-cli export "${output_file}" --format "${format}" --theme "${THEME}"
    echo "建立完成: ${output_file}"
}


if [ "$FORMAT_SPECIFIED" = true ]; then
    # User specified a format, build only that one
    build_resume "${FORMAT}"
else
    # Default behavior: build both pdf and html
    build_resume "pdf"
    echo # Add a separator line
    build_resume "html"
fi