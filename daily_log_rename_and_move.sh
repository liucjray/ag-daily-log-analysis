#!/bin/bash

# 讀取配置檔案
. ./config.sh

# 掃描來源目錄中的檔案
for file in "$SOURCE_DIR"/*_PHP_game_*.log; do
    # 檢查檔案是否存在
    if [ -f "$file" ]; then
        # 從檔名提取資訊
        filename=$(basename "$file")
        
        # 提取日期 (格式為 _YYYYMMDD.log)
        if [[ $filename =~ _([0-9]{8})\.log$ ]]; then
            date="${BASH_REMATCH[1]}"
            # 將日期格式從 YYYYMMDD 轉為 YYMMDD
            short_date="${date:2}"
            
            # 提取前綴 (V88 或 A92)
            if [[ $filename =~ ^([A-Z][0-9]{2})_ ]]; then
                prefix="${BASH_REMATCH[1]}"
                number="${prefix:1}"  # 提取數字部分 (88 或 92)
            else
                echo "跳過 $filename：無效的前綴格式"
                continue
            fi
            
            # 判斷檔案類型並設定後綴
            if [[ $filename =~ _coin_admin_ ]]; then
                suffix="ca"
            elif [[ $filename =~ _coin5_ ]]; then
                suffix="c5"
            else
                echo "跳過 $filename：未知的檔案類型"
                continue
            fi
            
            # 建立目標目錄 (如果不存在)
            # 因為原始日誌檔案都很大，多加一個 resources 資料夾，避免誤點到
            DEST_DIR="$DEST_BASE_DIR/$date/resources"
            mkdir -p "$DEST_DIR"
            
            # 定義目標檔案名稱
            DEST_FILE="$DEST_DIR/${number}${suffix}${date}.log"
            
            # 移動並更名檔案
            echo "正在移動 $filename 到 $DEST_FILE"
            mv "$file" "$DEST_FILE"
            
            # 檢查移動是否成功
            if [ $? -eq 0 ]; then
                echo "成功移動 $filename 到 $DEST_FILE"
            else
                echo "移動 $filename 時發生錯誤"
            fi
        else
            echo "跳過 $filename：無效的日期格式"
        fi
    fi
done