@echo off

REM Start IAP tunnel, if not already running
netstat /o /a | find /i "listening" | find ":%2" >nul 2>nul && (
   echo IAP tunnel is already open and listening on %2
) || (
  echo Starting IAP tunnel on port %2
  CALL gcloud auth login --update-adc
  START /B gcloud compute start-iap-tunnel %1 3389 --local-host-port=localhost:%2 --zone=europe-north1-a --project=visma-274514
  timeout /t 3 /nobreak >nul
)