#!/bin/sh

# 定義指定日期
# MY_DATE="20250712"
MY_DATE=$(date -d "yesterday" +%Y%m%d)

# 檔案前綴
FILE_PREFIX="88ca"

# 定義輸入和輸出檔案
INPUT_FILE="./${MY_DATE}/resources/${FILE_PREFIX}${MY_DATE}.log"
OUTPUT_FILE="./${MY_DATE}/${FILE_PREFIX}${MY_DATE}.filter.main.log"

# 檢查輸入檔案是否存在
if [ -f "$INPUT_FILE" ]; then
    # 應用過濾條件並輸出到目標檔案
    grep -v "checktoken" "$INPUT_FILE" \
    | grep -v '\-\-\-\-\-' \
    | grep -v 'getCountDown' \
    | grep -v 'goldrecord' \
    | grep -v 'getplayerdatawithcond' \
    | grep -v 'scaler_quote' \
    | grep -v 'backenduserlist' \
    | grep -v 'base64' \
    | grep -v 'changeavatar' \
    | grep -v 'club_wpt_transaction' \
    | grep -v '"error_code":0' \
    | grep -v 'user session' \
    > "$OUTPUT_FILE"
    
    # 檢查是否成功生成輸出檔案
    if [ $? -eq 0 ]; then
        echo "成功生成過濾後的日誌檔案：$OUTPUT_FILE"
    else
        echo "無錯誤 或是 處理 $INPUT_FILE 時發生錯誤"
    fi
else
    echo "輸入檔案 $INPUT_FILE 不存在"
    exit 1
fi