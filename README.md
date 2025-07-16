### 使用說明
1. 到 Finder 底下，將昨日日誌下載回來，預設會放到本地的下載路徑
2. 開啟 wsl 並且切換目錄至 /mnt/d/ag-daily-log-analysis
3. 執行 bash ./daily_log_rename_and_move.sh
4. 將下載回來的日誌更名並移動至 /mnt/d/ag-daily-log-analysis/${date}/resources

### 執行日誌下載檔案更名與移動指令
```
cd /mnt/d/ag-daily-log-analysis; bash ./daily_log_rename_and_move.sh;
```

### 92ca 昨日日誌分析
```
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_ca.sh yesterday;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_ca.sh today;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_ca.sh 20250101;
```

### 92c5 昨日日誌分析
```
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_c5.sh yesterday;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_c5.sh today;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_92_c5.sh 20250101;
```

### 88ca 昨日日誌分析
```
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_88_ca.sh yesterday;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_88_ca.sh today;
cd /mnt/d/ag-daily-log-analysis; bash ./log_analysis_88_ca.sh 20250101;
``` 

### 指定 trace_id 日誌過濾
```
grep -e '6873d63c19d07' ./92c520250713.log > ./92c520250713.6873d63c19d07.log;
```