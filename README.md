### 使用說明
1. 到 Finder 底下，將昨日日誌下載回來，預設會放到本地的下載路徑
2. 開啟 wsl 並且切換目錄至 /mnt/d/ag-daily-log-analysis
3. 執行 bash ./daily_log_rename_and_move.sh
4. 將下載回來的日誌更名並移動至 /mnt/d/ag-daily-log-analysis/${date}/resources

### 執行日誌下載檔案更名與移動指令
```
cd /mnt/d/ag-daily-log-analysis; bash ./daily_log_rename_and_move.sh;
```

### 昨日日誌分析
```
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_ca.sh yesterday;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_c5.sh yesterday;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_88_ca.sh yesterday;
```

### 92ca 日誌分析
```
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_ca.sh yesterday;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_ca.sh today;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_ca.sh 2025xxxx;
```

### 92c5 日誌分析
```
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_c5.sh yesterday;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_c5.sh today;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_c5.sh 2025xxxx;
```

### 88ca 日誌分析
```
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_88_ca.sh yesterday;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_88_ca.sh today;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_88_ca.sh 2025xxxx;
``` 

### 指定 trace_id 日誌過濾
```
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_c5.sh yesterday '6873d63c19d07';
```

### 指定 keyword 日誌過濾
```
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_c5.sh yesterday '2406141';
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_ca.sh yesterday 'Failed|Undefined';
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_88_ca.sh yesterday 'Failed|Undefined';
```

### 計算特定格式內容出現次數 

#### 過濾條件 = 验证手机号是否存在 + mobile
```
grep "checkmobileexist" $(sh ./logname_gen.sh) | \
grep -oP '"mobile":"\K[^"]+' | \
sort | \
uniq -c | \
sort -nr;
```

#### 過濾條件 = 黑名单日志 + user_id
```
grep "黑名单日志" $(sh ./logname_gen.sh) | \
grep -oP '"user_id":\K\d+' | \
sort | \
uniq -c | \
sort -nr;
```

#### 過濾條件 = 获取用户信息 + user_id
```
grep "useronequery" $(sh ./logname_gen.sh 92c5 yesterday resource) | \
grep -oP '"id":\K\d+' | \
sort | \
uniq -c | \
sort -nr | \
head -n 10;
```

#### 過濾條件 = 原始资料 + 获取用户信息 + user_id + 僅顯示前十筆
```
grep "useronequery" $(sh ./logname_gen.sh 92c5 today resource) | \
grep -oP '"id":\K\d+' | \
sort | \
uniq -c | \
sort -nr | \
head -n 10;
```

#### 過濾條件 = addaccountdevice + post_data.mobile
```
grep "addaccountdevice" $(sh ./logname_gen.sh 92c5 today resource) | \
grep -oP '"post_data":\{[^}]*"mobile":"\K[^"]+' | \
sort | \
uniq -c | \
sort -nr
head -n 10;
```

#### 過濾條件 = 原始资料 + IP請求計數 + 僅顯示前十筆
```
grep -v "ping" \
$(./logname_gen.sh 92c5 yesterday resource) | \
grep "|POST|" | \
grep -oP '\|\K\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\|' | \
sed 's/|$//' | \
sort | \
uniq -c | \
sort -nr | \
head -n 50;
```