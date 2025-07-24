#!/bin/bash

# 設置預設參數
prefix="${1:-92c5}"
date_input="${2:-yesterday}"
log_type="${3:-daily}"

# 驗證 prefix
case "$prefix" in
    92ca|92c5|88ca|92ps)
        ;;
    *)
        echo "Error: Invalid prefix. Must be 92ca, 92c5, or 88ca." >&2
        exit 1
        ;;
esac

# 處理日期參數
case "$date_input" in
    today)
        date_str=$(date +%Y%m%d)
        ;;
    yesterday)
        date_str=$(date -d "yesterday" +%Y%m%d)
        ;;
    [0-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]) # 簡單驗證 YYYYMMDD 格式
        date_str="$date_input"
        ;;
    *)
        echo "Error: Invalid date. Must be today, yesterday, or YYYYMMDD (e.g., 20250722)." >&2
        exit 1
        ;;
esac

# 驗證 log_type 並生成 logpath
case "$log_type" in
    daily)
        echo "./${date_str}/${prefix}${date_str}.filter.daily.log"
        ;;
    resource)
        echo "./${date_str}/resources/${prefix}${date_str}.log"
        ;;
    *)
        echo "Error: Invalid log type. Must be daily or resource." >&2
        exit 1
        ;;
esac