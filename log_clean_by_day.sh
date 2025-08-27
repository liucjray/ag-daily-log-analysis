#!/bin/sh

# 從命令行取得刪除天數參數，預設為30
DAYS_AGO=${1:-30}

# 取得目標的日期閾值，格式為 YYYYMMDD
TARGET_DATE=$(date -d "$DAYS_AGO days ago" +%Y%m%d)

# 設定資料夾所在的路徑，要根據實際情況修改
TARGET_DIR="./"  # 假設在當前資料夾

# 進入資料夾，列出所有名稱為日期格式的資料夾
find "$TARGET_DIR" -maxdepth 1 -mindepth 1 -type d | while read folder; do
    # 取得資料夾名稱
    folder_name=$(basename "$folder")
    
    # 檢查資料夾名稱是否為日期格式
    if echo "$folder_name" | grep -E '^[0-9]{8}$' > /dev/null; then
        # 比較字串大小，確定是否早於閾值
        if [ "$folder_name" -lt "$TARGET_DATE" ]; then
            echo "刪除資料夾：$folder"
            rm -rf "$folder"
        fi
    fi
done
