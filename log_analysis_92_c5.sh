#!/bin/sh

# 定義指定日期
# MY_DATE="20250712"
MY_DATE=$(date -d "yesterday" +%Y%m%d)

# 檔案前綴
FILE_PREFIX="92c5"

# 定義輸入和輸出檔案
INPUT_FILE="./${MY_DATE}/resources/${FILE_PREFIX}${MY_DATE}.log"
OUTPUT_FILE="./${MY_DATE}/${FILE_PREFIX}${MY_DATE}.filter.main.log"

# 檢查輸入檔案是否存在
if [ -f "$INPUT_FILE" ]; then
    # 應用過濾條件並輸出到目標檔案
    grep -v "ping" "$INPUT_FILE" \
    | grep -v "getFeedbackLists"  \
    | grep -v "getResources"  \
    | grep -v "getdomainurl"  \
    | grep -v "getcacha"  \
    | grep -v "\-\-\-\-\-"  \
    | grep -v "==="  \
    | grep -v "isV3"  \
    | grep -v "isE1"  \
    | grep -v "e1 route"  \
    | grep -v "191\.INFO"  \
    | grep -v "登录成功"  \
    | grep -v '"error_code":0'  \
    | grep -v '"msg_code":"0'  \
    | grep -v '"errCode":"0000'  \
    | grep -v 'is_v3_login":true'  \
    | grep -v 'pubkey'  \
    | grep -v 'getCustom'  \
    | grep -v 'user info ip_info'  \
    | grep -v 'pkq9/success'  \
    | grep -vi '\\/user\\/article\\/getlist'  \
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