#!/bin/bash

# Default values
FORMAT="pdf"
THEME="kendall"

# Function to display usage information
usage() {
    echo "Usage: $0 [-f format] [-t theme] [-h|--help]"
    echo
    echo "Options:"
    echo "  -f format    指定輸出格式 (pdf 或 html)。預設: ${FORMAT}"
    echo "  -t theme     指定使用的主題。預設: ${THEME}"
    echo "  -h, --help   顯示此幫助訊息並結束。"
    exit 1
}

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -f|--format)
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


# Set the output filename based on the format
OUTPUT_FILE="resume.${FORMAT}"

# Display the configuration being used
echo "正在建立履歷..."
echo "格式: ${FORMAT}"
echo "主題: ${THEME}"
echo "輸出: ${OUTPUT_FILE}"

# Run the command
npx resume-cli export "${OUTPUT_FILE}" --format "${FORMAT}" --theme "${THEME}"

echo "建立完成: ${OUTPUT_FILE}"