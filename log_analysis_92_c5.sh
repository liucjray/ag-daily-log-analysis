#!/bin/bash

# 檢查是否傳入參數，若無則預設為 yesterday
if [ $# -eq 0 ]; then
    INPUT_DATE="yesterday"
else
    INPUT_DATE="$1"
fi

# 檢查是否傳入過濾關鍵字，若無則使用預設過濾器
if [ $# -ge 2 ]; then
    FILTER_KEYWORD="$2"
else
    FILTER_KEYWORD=""
fi

# 處理日期參數
case "$INPUT_DATE" in
    "today")
        MY_DATE=$(date +%Y%m%d)
        ;;
    "yesterday")
        MY_DATE=$(date -d "yesterday" +%Y%m%d)
        ;;
    *)
        # 檢查是否為 YYYYMMDD 格式
        if echo "$INPUT_DATE" | grep -E '^[0-9]{8}$' >/dev/null; then
            MY_DATE="$INPUT_DATE"
        else
            echo "錯誤：無效的日期格式，應為 YYYYMMDD、today 或 yesterday"
            exit 1
        fi
        ;;
esac

# 檔案前綴
FILE_PREFIX="92c5"

# 定義輸入和輸出檔案
INPUT_FILE="./${MY_DATE}/resources/${FILE_PREFIX}${MY_DATE}.log"
OUTPUT_FILE="./${MY_DATE}/${FILE_PREFIX}${MY_DATE}.filter.daily.log"

# 檢查輸入檔案是否存在
if [ -f "$INPUT_FILE" ]; then

    # 如果有傳入關鍵字，使用 grep -E 過濾；否則使用預設過濾器
    if [ -n "$FILTER_KEYWORD" ]; then
        OUTPUT_FILE="./${MY_DATE}/${FILE_PREFIX}${MY_DATE}.filter.keyword.$(date +%s).log"
        grep -E "$FILTER_KEYWORD" "$INPUT_FILE" > "$OUTPUT_FILE"
    else
        # 應用過濾條件並輸出到目標檔案
        grep -v "ping" "$INPUT_FILE" \
        | grep -v "getFeedbackLists" \
        | grep -v "getResources" \
        | grep -v "getdomainurl" \
        | grep -v "getcacha" \
        | grep -v "getCustom" \
        | grep -v "getCaptcha" \
        | grep -v "getVcodeByDevice" \
        | grep -v "\-\-\-\-\-" \
        | grep -v "===" \
        | grep -v "isV3" \
        | grep -v "isE1" \
        | grep -v "e1 route" \
        | grep -v "user-article-custom-log\.INFO" \
        | grep -v "pubkey" \
        | grep -v "user info ip_info" \
        | grep -v "pkq9/success" \
        | grep -vi '|OPTIONS|' \
        | grep -vi '|GET|' \
        | grep -vi 'user\\\/article\\\/getlist' \
        | grep -vi 'user\\\/Article\\\/getRule' \
        | grep -vi 'user\\\/article\\\/custom' \
        | grep -vi 'chatchat\\\/token\\\/check' \
        | grep -vi 'index.php\\\/v3\\\/User\\\/Ucenter\\\/logout' \
        | grep -vi 'click\\\/counter' \
        | grep -v '"is_v3_login":true' \
        | grep -vi '"success":true,"message":"Success"' \
        | grep -v '"error_code":0' \
        | grep -v '"msg_code":"0"' \
        | grep -v '"errCode":"0000"' \
        | grep -v "验证tonken\.INFO" \
        | grep -v "登录成功" \
        | grep -v "异地登录短信日志" \
        | grep -v "获取IP信息\.INFO" \
        | grep -v "获取IP信息经由db\.INFO" \
        | grep -v "获取IP信息成功\.INFO" \
        | grep -vE "getVcodeByRegister.*post_data" \
        | grep -vE "checkVcodeByForgetPwd.*post_data" \
        | grep -vE "getVcodeByResetPwd.*post_data" \
        | grep -vE "bindSafeDevice.*post_data" \
        | grep -vE "func\\\/report.*post_data" \
        | grep -vE "userAdd.*post_data" \
        | grep -vE "addFeedbackComment.*post_data" \
        | grep -vE "getVcodeByResetSafe.*post_data" \
        | grep -vE "resetSafe.*post_data" \
        | grep -vE "getFeedbackCommentLists.*post_data" \
        | grep -vE "modifyUserInfo.*post_data" \
        | grep -vE "getVcodeByForgetPwd.*post_data" \
        | grep -vE "checkUsername.*post_data" \
        | grep -vE "forgetPwd.*post_data" \
        | grep -vE "checkVcodeByRegister.*post_data" \
        | grep -vE "checkmobilenum.*手机号不同" \
        | grep -vE "forgetPwd.*密码不能和二级密码一致！" \
        | grep -vE "resetSafe.*密码不能和登录密码一致" \
        | grep -vE "getVcodeByRegister.*手机格式不正确" \
        > "$OUTPUT_FILE"
    fi

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