@echo off
title Thorium+ [Optimizer] [V1.0]
chcp 65001 >nul
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"
echo %ESC%[92mV1.0 [alpha]%ESC%[0m

echo.
echo.
echo.
echo                    ████████╗██╗  ██╗ ██████╗ ██████╗ ██╗██╗   ██╗███╗   ███╗
echo                    ╚══██╔══╝██║  ██║██╔═══██╗██╔══██╗██║██║   ██║████╗ ████║
echo                       ██║   ███████║██║   ██║██████╔╝██║██║   ██║██╔████╔██║
echo                       ██║   ██╔══██║██║   ██║██╔══██╗██║██║   ██║██║╚██╔╝██║
echo                       ██║   ██║  ██║╚██████╔╝██║  ██║██║╚██████╔╝██║ ╚═╝ ██║
echo                       ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝     ╚═╝
echo.
echo                            [1] Sair                       [2] Iniciar

set /p op=^> 

if %op%==1 goto op1
if %op%==2 goto op2
:op1
exit

:op2
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f

net stop wuauserv
sc config wuauserv start= disabled
net stop bits
sc config bits start= disabled
net stop dosvc
sc config dosvc start= disabled

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
takeown /f "C:\Windows\System32\WaaSMedicSVC.dll" /a
icacls "C:\Windows\System32\WaaSMedicSVC.dll" /grant administrators:F
ren "C:\Windows\System32\WaaSMedicSVC.dll" "WaaSMedicSVC.dll.old"

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d 4 /f
sc config "Spooler" start= disabled && sc stop "Spooler"

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Fax" /v "Start" /t REG_DWORD /d 4 /f
sc config "Fax" start= disabled && sc stop "Fax"

sc stop DiagTrack
sc config DiagTrack start= disabled
sc stop dmwappushservice
sc config dmwappushservice start= disabled
sc stop WerSvc
sc config WerSvc start= disabled
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventoryBuilder" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /v "Disabled" /t REG_DWORD /d 1 /f

schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /disable
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /disable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable
del /f /s /q %ProgramData%\Microsoft\Diagnosis\ETLLogs\*

sc stop WerSvc
sc config WerSvc start= disabled
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DoNotShowUI" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DoNotSendAdditionalData" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d 1 /f
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable
del /f /s /q %ProgramData%\Microsoft\Windows\WER\*
del /f /s /q %LocalAppData%\Microsoft\Windows\WER\*

sc stop OneSyncSvc
sc config OneSyncSvc start= disabled
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\OneSyncSvc" /v "UserServiceFlags" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d 2 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d 1 /f
schtasks /change /tn "\Microsoft\Windows\SettingSync\BackgroundConfigSyncTask" /disable
schtasks /change /tn "\Microsoft\Windows\SettingSync\BackupTask" /disable
schtasks /change /tn "\Microsoft\Windows\SettingSync\NetworkStateIT" /disable

sc stop DPS
sc config DPS start= disabled
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI" /v "ScenarioExecutionEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DPS" /v "Start" /t REG_DWORD /d 4 /f
schtasks /change /tn "\Microsoft\Windows\Diagnosis\Scheduled" /disable
schtasks /change /tn "\Microsoft\Windows\WDI\ResolutionHost" /disable
del /f /s /q %WinDir%\System32\WDI\LogFiles\*

schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /disable
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventoryBuilder" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags" /v "DownloadJapanUpdate" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\TelemetryController" /v "TestMode" /t REG_DWORD /d 0 /f
takeown /f "%WinDir%\System32\CompatTelRunner.exe" /a
icacls "%WinDir%\System32\CompatTelRunner.exe" /grant administradores:F
icacls "%WinDir%\System32\CompatTelRunner.exe" /inheritance:r /deny todos:(X)
del /f /s /q "%WinDir%\AppCompat\Programs\*"

schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\AppInventory" /v "DisableInventory" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags" /v "DisableInventory" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventoryBuilder" /t REG_DWORD /d 1 /f
takeown /f "%WinDir%\System32\appraiser.dll" /a
icacls "%WinDir%\System32\appraiser.dll" /grant administradores:F
icacls "%WinDir%\System32\appraiser.dll" /deny todos:(F)
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\AppInventory" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\AppInventory" /f

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenSlideshow" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
schtasks /change /tn "\Microsoft\Windows\PushToInstall\LoginCheck" /disable
schtasks /change /tn "\Microsoft\Windows\PushToInstall\Registration" /disable
sc stop PushToInstall
sc config PushToInstall start= disabled

sc stop WdiServiceHost
sc config WdiServiceHost start= disabled
sc stop WdiSystemHost
sc config WdiSystemHost start= disabled
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdiServiceHost" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdiSystemHost" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI" /v "ScenarioExecutionEnabled" /t REG_DWORD /d 0 /f
schtasks /change /tn "\Microsoft\Windows\WDI\ResolutionHost" /disable
takeown /f "%WinDir%\System32\wdiwhois.exe" /a
icacls "%WinDir%\System32\wdiwhois.exe" /grant administradores:F
icacls "%WinDir%\System32\wdiwhois.exe" /deny todos:(X)
del /f /s /q %WinDir%\System32\WDI\LogFiles\*

reg add "HKLM\System\CurrentControlSet\Services\TapiSrv" /v Start /t REG_DWORD /d 4 /f
sc stop TapiSrv
sc config TapiSrv start= disabled

reg add "HKLM\System\CurrentControlSet\Services\WMPNetworkSvc" /v Start /t REG_DWORD /d 4 /f
sc stop WMPNetworkSvc
sc config WMPNetworkSvc start= disabled

reg add "HKLM\System\CurrentControlSet\Services\TabletInputService" /v Start /t REG_DWORD /d 4 /f
sc stop TabletInputService
sc config TabletInputService start= disabled

reg add "HKLM\System\CurrentControlSet\Services\MapsBroker" /v Start /t REG_DWORD /d 4 /f
sc stop MapsBroker
sc config MapsBroker start= disabled

reg add "HKLM\System\CurrentControlSet\Services\SensorService" /v Start /t REG_DWORD /d 4 /f
sc stop SensorService
sc config SensorService start= disabled

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f


reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012028010000000 /f
reg add "HKCU\Control Panel\Desktop" /v CursorShadow /t REG_SZ /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f

reg add "HKLM\System\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMin /t REG_DWORD /d 100 /f
reg add "HKLM\System\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMax /t REG_DWORD /d 100 /f

reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\Lsa" /v LconnectConfig /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f
taskkill /f /im explorer.exe
start explorer.exe

schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppScan" /disable
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /disable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /disable
schtasks /change /tn "\Microsoft\Windows\FileHistory\File History (maintenance mode)" /disable
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /disable
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefreshTask" /disable
schtasks /change /tn "\Microsoft\Windows\Speech\SpeechModelDownloadTask" /disable
schtasks /change /tn "\Microsoft\Windows\Maps\MapsUpdateTask" /disable
schtasks /change /tn "\Microsoft\Windows\Maps\MapsToastTask" /disable
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClient" /disable
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /disable
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\Automatic App Update" /disable
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /disable
schtasks /change /tn "\Microsoft\Windows\License Manager\TempSignedLicenseExchange" /disable
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
schtasks /change /tn "\Microsoft\Windows\DiskCleanup\SilentCleanup" /disable
schtasks /change /tn "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner" /disable
schtasks /change /tn "\Microsoft\Windows\Diagnosis\Scheduled" /disable
schtasks /change /tn "\Microsoft\Windows\Location\Notifications" /disable
schtasks /change /tn "\Microsoft\Windows\Location\WindowsActionDialog" /disable
schtasks /change /tn "\Microsoft\Windows\PushToInstall\LoginCheck" /disable
schtasks /change /tn "\Microsoft\Windows\PushToInstall\Registration" /disable
schtasks /change /tn "\Microsoft\Windows\Subscription\LicenseAcquisition" /disable
schtasks /change /tn "\Microsoft\Windows\Subscription\EnableLicenseAcquisition" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\ReportPolicies" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /disable
schtasks /change /tn "\Microsoft\Windows\XblGameSave\XblGameSaveTask" /disable
schtasks /change /tn "\Microsoft\Windows\ExperienceIndex\WinSAT" /disable
schtasks /change /tn "\Microsoft\Windows\HelloFace\FODCleanupTask" /disable
schtasks /change /tn "\Microsoft\Windows\Device Information\Device" /disable
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebsiteOfflineContent /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v AITEnable /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\google.exe" /v MitigationOptions /t REG_QWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DisableExceptionChainValidation /t REG_DWORD /d 1 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v GlobalTimerResolutionRequests /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager" /v SetTimerResolution /t REG_DWORD /d 1 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v PowerThrottlingOff /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f

reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TcpAckFrequency /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TCPNoDelay /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TcpDelAckTicks /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v ThreadPriorityAffinityPolicy /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v AffinedInterrupts /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v InterruptAffinityPolicy /t REG_DWORD /d 1 /f

fsutil behavior set DisableDeleteNotify 0
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v DisableDeleteNotify /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\0b2d69d7-a2a1-449c-9680-f91c70521c60" /v Attributes /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\0012ee47-9041-4b5d-9b77-535fba8b1442\dab60367-53fe-4fb1-aa2b-05efadfea128" /v Attributes /t REG_DWORD /d 2 /f

bcdedit /set useplatformclock yes
bcdedit /set disabledynamictick yes
bcdedit /set groupsize 64

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
bcdedit /set pciexpress forcedisable
reg add "HKLM\System\CurrentControlSet\Control\GraphicsDrivers" /v "PowerLimit" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "PlatformPowerManagement" /t REG_DWORD /d 0 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "

bcdedit /set disabledynamictick yes
bcdedit /set useplatformtick yes
bcdedit /set tscsyncpolicy Enhanced
bcdedit /set groupsize 64
bcdedit /set threadpriority 31
bcdedit /set pae ForceDisable
bcdedit /set nx OptOut

bcdedit /set pciexpress forcedisable
bcdedit /set msi Default
bcdedit /set integritychecks off
bcdedit /set vsmlaunchtype Off
bcdedit /set hypervisorenforcedcodeintegrity Off

bcdedit /set ems no
bcdedit /set isolatedcontext no
bcdedit /set vm no
bcdedit /set firstmegabytepolicy UseAll
bcdedit /set avoidlowmemory yes
bcdedit /set onecpu off
bcdedit /set removememory 0
bcdedit /set pcid on
bcdedit /set tscsyncpolicy Enhanced
bcdedit /set activepartition yes
bcdedit /set inherit {globalsettings}
bcdedit /set loadoptions DISABLE_INTEGRITY_CHECKS
bcdedit /set testsigning off

bcdedit /set timeout 0
bcdedit /set bootstatuspolicy ignoreallfailures
bcdedit /set bootmenupolicy legacy

sc stop DiagTrack
sc stop diagnosticshub.standardcollector.service
sc stop dmwappushservice
sc stop RemoteRegistry
sc stop TrkWks
sc stop WMPNetworkSvc
sc stop SysMain
sc stop lmhosts
sc stop VSS
sc stop RemoteAccess
sc stop WSearch
sc stop iphlpsvc
sc stop DoSvc
sc stop ICEsoundService
sc stop ClickToRunSvc
sc stop SEMgrSvc
sc stop BDESVC
sc stop TabletInputService
sc stop SstpSvc
sc stop NvTelemetryContainer
sc stop HomeGroupListener
sc stop HomeGroupProvider
sc stop lfsvc
sc stop MapsBroke
sc stop NetTcpPortSharing
sc stop SharedAccess
sc stop WbioSrvc
sc stop WMPNetworkSvc
sc stop wisvc
sc stop TapiSrv
sc stop SmsRouter
sc stop SharedRealitySvc
sc stop ScDeviceEnum
sc stop SCardSvr
sc stop RetailDemo
sc stop PhoneSvc
sc stop perceptionsimulation
sc stop BTAGService
sc stop AJRouter
sc stop CDPSvc
sc stop ShellHWDetection
sc stop RstMwService
sc stop DusmSvc
sc stop BthAvctpSvc
sc stop BITS
sc stop DPS

sc config DiagTrack start= disabled
sc config diagnosticshub.standardcollector.service start= disabled
sc config dmwappushservice start= disabled
sc config RemoteRegistry start= disabled
sc config TrkWks start= disabled
sc config WMPNetworkSvc start= disabled
sc config SysMain start= disabled
sc config lmhosts start= disabled
sc config VSS start= disabled
sc config RemoteAccess start= disabled
sc config WSearch start= disabled
sc config iphlpsvc start= disabled
sc config DoSvc start= disabled
sc config ICEsoundService start= disabled
sc config ClickToRunSvc start= demand
sc config SEMgrSvc start= disabled
sc config RtkAudioUniversalService start= disabled
sc config BDESVC start= disabled
sc config TabletInputService start= disabled
sc config SstpSvc start= disabled
sc config NvTelemetryContainer start= disabled
sc config HomeGroupListener start= disabled
sc config HomeGroupProvider start= disabled
sc config lfsvc start= disabled
sc config MapsBroke start= disabled
sc config NetTcpPortSharing start= disabled
sc config SharedAccess start= disabled
sc config WbioSrvc start= disabled
sc config WMPNetworkSvc start= disabled
sc config wisvc start= disabled
sc config TapiSrv start= disabled
sc config SmsRouter start= disabled
sc config SharedRealitySvc start= disabled
sc config ScDeviceEnum start= disabled
sc config SCardSvr start= disabled
sc config RetailDemo start= disabled
sc config PhoneSvc start= disabled
sc config perceptionsimulation start= disabled
sc config BTAGService start= disabled
sc config AJRouter start= disabled
sc config CDPSvc start= disabled
sc config ShellHWDetection start= disabled
sc config RstMwService start= disabled
sc config DusmSvc start= disabled
sc config BthAvctpSvc start= disabled
sc config BITS start= demand
sc config DPS start= disabled

wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=2255,MaximumSize=2255

SET "HOSTS=%systemroot%\system32\drivers\etc\hosts"

:: Garantir que o arquivo termine com uma nova linha antes de anexar
echo. >> %HOSTS%

echo 0.0.0.0 ad.doubleclick.net >> %HOSTS%
echo 0.0.0.0 googleads.g.doubleclick.net >> %HOSTS%
echo 0.0.0.0 stats.g.doubleclick.net >> %HOSTS%
echo 0.0.0.0 ad.yieldmanager.com >> %HOSTS%
echo 0.0.0.0 secure.adnxs.com >> %HOSTS%
echo 0.0.0.0 ib.adnxs.com >> %HOSTS%
echo 0.0.0.0 static.doubleclick.net >> %HOSTS%
echo 0.0.0.0 adservice.google.com >> %HOSTS%
echo 0.0.0.0 pagead2.googlesyndication.com >> %HOSTS%
echo 0.0.0.0 tpc.googlesyndication.com >> %HOSTS%
echo 0.0.0.0 adserver.yahoo.com >> %HOSTS%
echo 0.0.0.0 ads.yahoo.com >> %HOSTS%
echo 0.0.0.0 analytics.google.com >> %HOSTS%
echo 0.0.0.0 clickserve.dartsearch.net >> %HOSTS%
echo 0.0.0.0 api.ads.com >> %HOSTS%
echo 0.0.0.0 ads.youtube.com >> %HOSTS%
echo 0.0.0.0 s.youtube.com >> %HOSTS%
echo 0.0.0.0 video-stats.l.google.com >> %HOSTS%
echo 0.0.0.0 m.doubleclick.net >> %HOSTS%
echo 0.0.0.0 ad-g.doubleclick.net >> %HOSTS%
echo 0.0.0.0 ads.pubmatic.com >> %HOSTS%
echo 0.0.0.0 b.scorecardresearch.com >> %HOSTS%
echo 0.0.0.0 edge.quantserve.com >> %HOSTS%
echo 0.0.0.0 pixel.quantserve.com >> %HOSTS%
echo 0.0.0.0 ads.rubiconproject.com >> %HOSTS%
echo 0.0.0.0 optimized-by.rubiconproject.com >> %HOSTS%
echo 0.0.0.0 fast.adform.net >> %HOSTS%
echo 0.0.0.0 tracking.adform.net >> %HOSTS%
echo 0.0.0.0 tag.adform.net >> %HOSTS%
echo 0.0.0.0 ads.mopub.com >> %HOSTS%
echo 0.0.0.0 click.mopub.com >> %HOSTS%
echo 0.0.0.0 static.mopub.com >> %HOSTS%
echo 0.0.0.0 sync.mathtag.com >> %HOSTS%
echo 0.0.0.0 pixel.mathtag.com >> %HOSTS%
echo 0.0.0.0 match.adsrvr.org >> %HOSTS%
echo 0.0.0.0 ads.stickyadstv.com >> %HOSTS%
echo 0.0.0.0 ads.outbrain.com >> %HOSTS%
echo 0.0.0.0 widgets.outbrain.com >> %HOSTS%
echo 0.0.0.0 ads.taboola.com >> %HOSTS%
echo 0.0.0.0 cdn.taboola.com >> %HOSTS%
echo 0.0.0.0 trc.taboola.com >> %HOSTS%
echo 0.0.0.0 cdn.flurry.com >> %HOSTS%
echo 0.0.0.0 data.flurry.com >> %HOSTS%
echo 0.0.0.0 tracking.flurry.com >> %HOSTS%
echo 0.0.0.0 api.flurry.com >> %HOSTS%
echo 0.0.0.0 ad.mail.ru >> %HOSTS%
echo 0.0.0.0 an.yandex.ru >> %HOSTS%
echo 0.0.0.0 adservice.google.com.br >> %HOSTS%
echo 0.0.0.0 bid.openx.net >> %HOSTS%
echo 0.0.0.0 cas.criteo.com >> %HOSTS%
echo 0.0.0.0 static.criteo.net >> %HOSTS%
echo 0.0.0.0 widget.criteo.com >> %HOSTS%
echo 0.0.0.0 tags.bluekai.com >> %HOSTS%
echo 0.0.0.0 stags.bluekai.com >> %HOSTS%
echo 0.0.0.0 tracker.bluekai.com >> %HOSTS%
echo 0.0.0.0 api.bluekai.com >> %HOSTS%
echo 0.0.0.0 rtg.smarthad.com >> %HOSTS%
echo 0.0.0.0 track.smarthad.com >> %HOSTS%
echo 0.0.0.0 static.hotjar.com >> %HOSTS%
echo 0.0.0.0 script.hotjar.com >> %HOSTS%
echo 0.0.0.0 vars.hotjar.com >> %HOSTS%
echo 0.0.0.0 collector.newrelic.com >> %HOSTS%
echo 0.0.0.0 bam.nr-data.net >> %HOSTS%
echo 0.0.0.0 js-agent.newrelic.com >> %HOSTS%
echo 0.0.0.0 ads.twitter.com >> %HOSTS%
echo 0.0.0.0 analytics.twitter.com >> %HOSTS%
echo 0.0.0.0 static.ads-twitter.com >> %HOSTS%
echo 0.0.0.0 ads-api.twitter.com >> %HOSTS%
echo 0.0.0.0 connect.facebook.net >> %HOSTS%
echo 0.0.0.0 graph.facebook.com >> %HOSTS%
echo 0.0.0.0 pixel.facebook.com >> %HOSTS%
echo 0.0.0.0 an.facebook.com >> %HOSTS%
echo 0.0.0.0 stats.fb.com >> %HOSTS%
echo 0.0.0.0 analytics.facebook.com >> %HOSTS%
echo 0.0.0.0 adserver.bing.com >> %HOSTS%
echo 0.0.0.0 bat.bing.com >> %HOSTS%
echo 0.0.0.0 ads.linkedin.com >> %HOSTS%
echo 0.0.0.0 analytics.linkedin.com >> %HOSTS%
echo 0.0.0.0 pixel.ads.linkedin.com >> %HOSTS%
echo 0.0.0.0 static.licdn.com >> %HOSTS%
echo 0.0.0.0 ads.pinterest.com >> %HOSTS%
echo 0.0.0.0 analytics.pinterest.com >> %HOSTS%
echo 0.0.0.0 log.pinterest.com >> %HOSTS%
echo 0.0.0.0 ads.snapchat.com >> %HOSTS%
echo 0.0.0.0 analytics.snapchat.com >> %HOSTS%
echo 0.0.0.0 tr.snapchat.com >> %HOSTS%
echo 0.0.0.0 ads.tiktok.com >> %HOSTS%
echo 0.0.0.0 analytics.tiktok.com >> %HOSTS%
echo 0.0.0.0 ads-api.tiktok.com >> %HOSTS%
echo 0.0.0.0 log.tiktokv.com >> %HOSTS%
echo 0.0.0.0 mon.tiktokv.com >> %HOSTS%
echo 0.0.0.0 ad.71i.tk >> %HOSTS%
echo 0.0.0.0 ads.stickyadstv.com >> %HOSTS%
echo 0.0.0.0 ads.creative-serving.com >> %HOSTS%
echo 0.0.0.0 tags.creative-serving.com >> %HOSTS%
echo 0.0.0.0 adserver.adtech.de >> %HOSTS%
echo 0.0.0.0 adserver.adtechus.com >> %HOSTS%
echo 0.0.0.0 ads.adspyglass.com >> %HOSTS%
echo 0.0.0.0 player.adspyglass.com >> %HOSTS%
echo 0.0.0.0 adserver.juicyads.com >> %HOSTS%
echo 0.0.0.0 delivery.juicyads.com >> %HOSTS%
echo 0.0.0.0 ads.trafficjunky.net >> %HOSTS%
echo 0.0.0.0 ads.exoclick.com >> %HOSTS%
echo 0.0.0.0 main.exoclick.com >> %HOSTS%
echo 0.0.0.0 synergex.exoclick.com >> %HOSTS%
echo 0.0.0.0 ads.ero-advertising.com >> %HOSTS%
echo 0.0.0.0 tracker.ero-advertising.com >> %HOSTS%
echo 0.0.0.0 ads.plugrush.com >> %HOSTS%
echo 0.0.0.0 s.mmsads.com >> %HOSTS%
echo 0.0.0.0 ads.popads.net >> %HOSTS%
echo 0.0.0.0 serve.popads.net >> %HOSTS%
echo 0.0.0.0 ads.popcash.net >> %HOSTS%
echo 0.0.0.0 engine.popcash.net >> %HOSTS%
echo 0.0.0.0 ads.ad-maven.com >> %HOSTS%
echo 0.0.0.0 shared.ad-maven.com >> %HOSTS%
echo 0.0.0.0 ads.propellerads.com >> %HOSTS%
echo 0.0.0.0 api.propellerads.com >> %HOSTS%
echo 0.0.0.0 push.propellerads.com >> %HOSTS%
echo 0.0.0.0 ads.hilltopads.net >> %HOSTS%
echo 0.0.0.0 ads.clickadu.com >> %HOSTS%
echo 0.0.0.0 ads.adsterra.com >> %HOSTS%
echo 0.0.0.0 api.adsterra.com >> %HOSTS%
echo 0.0.0.0 ads.ad-center.com >> %HOSTS%
echo 0.0.0.0 ads.mgid.com >> %HOSTS%
echo 0.0.0.0 servicer.mgid.com >> %HOSTS%
echo 0.0.0.0 ads.revcontent.com >> %HOSTS%
echo 0.0.0.0 trending.revcontent.com >> %HOSTS%
echo 0.0.0.0 ads.buy sellads.com >> %HOSTS%
echo 0.0.0.0 s3.buysellads.com >> %HOSTS%
echo 0.0.0.0 ads.carbonads.net >> %HOSTS%
echo 0.0.0.0 srv.carbonads.net >> %HOSTS%
echo 0.0.0.0 ads.adzerk.net >> %HOSTS%
echo 0.0.0.0 engine.adzerk.net >> %HOSTS%
echo 0.0.0.0 ads.adbuff.com >> %HOSTS%
echo 0.0.0.0 ads.ad-speed.com >> %HOSTS%
echo 0.0.0.0 ads.adspirit.de >> %HOSTS%
echo 0.0.0.0 ads.adthink.com >> %HOSTS%
echo 0.0.0.0 ads.ad-trix.com >> %HOSTS%
echo 0.0.0.0 ads.adverticum.net >> %HOSTS%
echo 0.0.0.0 ads.ad-vantage.com >> %HOSTS%
echo 0.0.0.0 ads.ad-venture.com >> %HOSTS%
echo 0.0.0.0 ads.ad-ways.com >> %HOSTS%
echo 0.0.0.0 ads.affiliate.com >> %HOSTS%
echo 0.0.0.0 ads.amazon-adsystem.com >> %HOSTS%
echo 0.0.0.0 aax.amazon-adsystem.com >> %HOSTS%
echo 0.0.0.0 cdn.amazon-adsystem.com >> %HOSTS%
echo 0.0.0.0 ads.amung.us >> %HOSTS%
echo 0.0.0.0 stats.amung.us >> %HOSTS%
echo 0.0.0.0 whostalking.amung.us >> %HOSTS%
echo 0.0.0.0 ads.appier.net >> %HOSTS%
echo 0.0.0.0 j-ad.appier.net >> %HOSTS%
echo 0.0.0.0 ads.applovin.com >> %HOSTS%
echo 0.0.0.0 ms.applovin.com >> %HOSTS%
echo 0.0.0.0 rt.applovin.com >> %HOSTS%
echo 0.0.0.0 ads.appnexus.com >> %HOSTS%
echo 0.0.0.0 ads.bidswitch.com >> %HOSTS%
echo 0.0.0.0 x.bidswitch.net >> %HOSTS%
echo 0.0.0.0 ads.brightcom.com >> %HOSTS%
echo 0.0.0.0 ads.conversantmedia.com >> %HOSTS%
echo 0.0.0.0 ads.dotomi.com >> %HOSTS%
echo 0.0.0.0 ads.emxdgt.com >> %HOSTS%
echo 0.0.0.0 ads.exponential.com >> %HOSTS%
echo 0.0.0.0 ads.gumgum.com >> %HOSTS%
echo 0.0.0.0 ads.improvely.com >> %HOSTS%
echo 0.0.0.0 ads.inmobi.com >> %HOSTS%
echo 0.0.0.0 ads.inner-active.mobi >> %HOSTS%
echo 0.0.0.0 ads.integritads.com >> %HOSTS%
echo 0.0.0.0 ads.interactive-online.com >> %HOSTS%
echo 0.0.0.0 ads.interyield.com >> %HOSTS%
echo 0.0.0.0 ads.invitemedia.com >> %HOSTS%
echo 0.0.0.0 ads.iskyads.com >> %HOSTS%
echo 0.0.0.0 ads.ivads.com >> %HOSTS%
echo 0.0.0.0 ads.jads.co >> %HOSTS%
echo 0.0.0.0 ads.jump tap.com >> %HOSTS%
echo 0.0.0.0 ads.justpremium.com >> %HOSTS%
echo 0.0.0.0 ads.kargo.com >> %HOSTS%
echo 0.0.0.0 ads.kixer.com >> %HOSTS%
echo 0.0.0.0 ads.komoona.com >> %HOSTS%
echo 0.0.0.0 ads.kontera.com >> %HOSTS%
echo 0.0.0.0 ads.leadbolt.com >> %HOSTS%
echo 0.0.0.0 ads.leadiant.com >> %HOSTS%
echo 0.0.0.0 ads.ligatus.com >> %HOSTS%
echo 0.0.0.0 ads.lijit.com >> %HOSTS%
echo 0.0.0.0 ads.liveadvert.com >> %HOSTS%
echo 0.0.0.0 ads.lovelys-ads.com >> %HOSTS%
echo 0.0.0.0 ads.m-advert.com >> %HOSTS%
echo 0.0.0.0 ads.madadsmedia.com >> %HOSTS%
echo 0.0.0.0 ads.mads.com >> %HOSTS%
echo 0.0.0.0 ads.magnite.com >> %HOSTS%
echo 0.0.0.0 ads.marinsm.com >> %HOSTS%
echo 0.0.0.0 ads.media.net >> %HOSTS%
echo 0.0.0.0 ads.media-advertising.com >> %HOSTS%
echo 0.0.0.0 ads.mediabong.com >> %HOSTS%
echo 0.0.0.0 ads.mediarithmics.com >> %HOSTS%
echo 0.0.0.0 ads.mediavine.com >> %HOSTS%
echo 0.0.0.0 ads.medleyads.com >> %HOSTS%
echo 0.0.0.0 ads.mellowads.com >> %HOSTS%
echo 0.0.0.0 ads.metads.com >> %HOSTS%
echo 0.0.0.0 ads.microad.jp >> %HOSTS%
echo 0.0.0.0 ads.moatads.com >> %HOSTS%
echo 0.0.0.0 ads.mob fox.com >> %HOSTS%
echo 0.0.0.0 ads.monetizer.co >> %HOSTS%
echo 0.0.0.0 ads.myads.com >> %HOSTS%
echo 0.0.0.0 ads.native-ad.net >> %HOSTS%
echo 0.0.0.0 ads.native-ads.com >> %HOSTS%
echo 0.0.0.0 ads.nervads.com >> %HOSTS%
echo 0.0.0.0 ads.netseer.com >> %HOSTS%
echo 0.0.0.0 ads.nexage.com >> %HOSTS%
echo 0.0.0.0 ads.onebyaol.com >> %HOSTS%
echo 0.0.0.0 ads.openstat.net >> %HOSTS%
echo 0.0.0.0 ads.opta.net >> %HOSTS%
echo 0.0.0.0 ads.optimizely.com >> %HOSTS%
echo 0.0.0.0 ads.p-n.io >> %HOSTS%
echo 0.0.0.0 ads.p-show.com >> %HOSTS%
echo 0.0.0.0 ads.p-st.com >> %HOSTS%
echo 0.0.0.0 ads.parsely.com >> %HOSTS%
echo 0.0.0.0 ads.perfect audience.com >> %HOSTS%
echo 0.0.0.0 ads.permutive.com >> %HOSTS%
echo 0.0.0.0 ads.platform.io >> %HOSTS%
echo 0.0.0.0 ads.platinum-ad.com >> %HOSTS%
echo 0.0.0.0 ads.playwire.com >> %HOSTS%
echo 0.0.0.0 ads.pocketmath.com >> %HOSTS%
echo 0.0.0.0 ads.popads.net >> %HOSTS%
echo 0.0.0.0 ads.popin.cc >> %HOSTS%
echo 0.0.0.0 ads.popmyads.com >> %HOSTS%
echo 0.0.0.0 ads.pro-market.net >> %HOSTS%
echo 0.0.0.0 ads.pulsepoint.com >> %HOSTS%
echo 0.0.0.0 ads.quantcount.com >> %HOSTS%
echo 0.0.0.0 ads.rakuten.com >> %HOSTS%
echo 0.0.0.0 ads.realsrv.com >> %HOSTS%
echo 0.0.0.0 ads.reddit.com >> %HOSTS%
echo 0.0.0.0 ads.richrelevance.com >> %HOSTS%
echo 0.0.0.0 ads.rkdms.com >> %HOSTS%
echo 0.0.0.0 ads.rlcdn.com >> %HOSTS%
echo 0.0.0.0 ads.rtmark.net >> %HOSTS%
echo 0.0.0.0 ads.samba.tv >> %HOSTS%
echo 0.0.0.0 ads.saymedia.com >> %HOSTS%
echo 0.0.0.0 ads.sharethrough.com >> %HOSTS%
echo 0.0.0.0 ads.simpli.fi >> %HOSTS%
echo 0.0.0.0 ads.sitescout.com >> %HOSTS%
echo 0.0.0.0 ads.skimresources.com >> %HOSTS%
echo 0.0.0.0 ads.smartadserver.com >> %HOSTS%
echo 0.0.0.0 ads.smartclip.net >> %HOSTS%
echo 0.0.0.0 ads.smarthad.com >> %HOSTS%
echo 0.0.0.0 ads.smarter-click.com >> %HOSTS%
echo 0.0.0.0 ads.sovrn.com >> %HOSTS%
echo 0.0.0.0 ads.spotx.tv >> %HOSTS%
echo 0.0.0.0 ads.spotxchange.com >> %HOSTS%
echo 0.0.0.0 ads.steelhousemedia.com >> %HOSTS%
echo 0.0.0.0 ads.steepto.com >> %HOSTS%
echo 0.0.0.0 ads.storygize.net >> %HOSTS%
echo 0.0.0.0 ads.sumome.com >> %HOSTS%
echo 0.0.0.0 ads.suvads.com >> %HOSTS%
echo 0.0.0.0 ads.swelen.com >> %HOSTS%
echo 0.0.0.0 ads.tapad.com >> %HOSTS%
echo 0.0.0.0 ads.tapjoy.com >> %HOSTS%
echo 0.0.0.0 ads.targetspot.com >> %HOSTS%
echo 0.0.0.0 ads.teads.tv >> %HOSTS%
echo 0.0.0.0 ads.telemetry.com >> %HOSTS%
echo 0.0.0.0 ads.terra.com >> %HOSTS%
echo 0.0.0.0 ads.the-ozone-project.com >> %HOSTS%
echo 0.0.0.0 ads.thetradedesk.com >> %HOSTS%
echo 0.0.0.0 ads.topad.com >> %HOSTS%
echo 0.0.0.0 ads.trackersimulator.org >> %HOSTS%
echo 0.0.0.0 ads.trafficforce.com >> %HOSTS%
echo 0.0.0.0 ads.traffichaus.com >> %HOSTS%
echo 0.0.0.0 ads.traffichunt.com >> %HOSTS%
echo 0.0.0.0 ads.trafficstars.com >> %HOSTS%
echo 0.0.0.0 ads.travelaudience.com >> %HOSTS%
echo 0.0.0.0 ads.tremorhub.com >> %HOSTS%
echo 0.0.0.0 ads.tremormedia.com >> %HOSTS%
echo 0.0.0.0 ads.triplelift.com >> %HOSTS%
echo 0.0.0.0 ads.tubemogul.com >> %HOSTS%
echo 0.0.0.0 ads.turn.com >> %HOSTS%
echo 0.0.0.0 ads.u-ad.info >> %HOSTS%
echo 0.0.0.0 ads.undertone.com >> %HOSTS%
echo 0.0.0.0 ads.unity3d.com >> %HOSTS%
echo 0.0.0.0 ads.unrulymedia.com >> %HOSTS%
echo 0.0.0.0 ads.up-ads.com >> %HOSTS%
echo 0.0.0.0 ads.urbanairship.com >> %HOSTS%
echo 0.0.0.0 ads.v-do.com >> %HOSTS%
echo 0.0.0.0 ads.valueclick.com >> %HOSTS%
echo 0.0.0.0 ads.vibrantmedia.com >> %HOSTS%
echo 0.0.0.0 ads.videoamp.com >> %HOSTS%
echo 0.0.0.0 ads.videohub.tv >> %HOSTS%
echo 0.0.0.0 ads.vidoomy.com >> %HOSTS%
echo 0.0.0.0 ads.viewios.com >> %HOSTS%
echo 0.0.0.0 ads.vindicosuite.com >> %HOSTS%
echo 0.0.0.0 ads.vlyby.com >> %HOSTS%
echo 0.0.0.0 ads.voicefive.com >> %HOSTS%
echo 0.0.0.0 ads.voodoo-ads.com >> %HOSTS%
echo 0.0.0.0 ads.vox.com >> %HOSTS%
echo 0.0.0.0 ads.w55c.net >> %HOSTS%
echo 0.0.0.0 ads.walmart.com >> %HOSTS%
echo 0.0.0.0 ads.wemediate.com >> %HOSTS%
echo 0.0.0.0 ads.wideorbit.com >> %HOSTS%
echo 0.0.0.0 ads.woobi.com >> %HOSTS%
echo 0.0.0.0 ads.wp.com >> %HOSTS%
echo 0.0.0.0 ads.wpp.com >> %HOSTS%
echo 0.0.0.0 ads.wunderloop.net >> %HOSTS%
echo 0.0.0.0 ads.xads.com >> %HOSTS%
echo 0.0.0.0 ads.xaxis.com >> %HOSTS%
echo 0.0.0.0 ads.xertive.com >> %HOSTS%
echo 0.0.0.0 ads.yieldlab.net >> %HOSTS%
echo 0.0.0.0 ads.yieldmo.com >> %HOSTS%
echo 0.0.0.0 ads.yieldoptimizer.com >> %HOSTS%
echo 0.0.0.0 ads.yoc.com >> %HOSTS%
echo 0.0.0.0 ads.yolink.com >> %HOSTS%
echo 0.0.0.0 ads.yomedia.com >> %HOSTS%
echo 0.0.0.0 ads.yontoo.com >> %HOSTS%
echo 0.0.0.0 ads.zads.com >> %HOSTS%
echo 0.0.0.0 ads.zamora.com >> %HOSTS%
echo 0.0.0.0 ads.zedo.com >> %HOSTS%
echo 0.0.0.0 ads.zergnet.com >> %HOSTS%
echo 0.0.0.0 ads.ziffdavis.com >> %HOSTS%
echo 0.0.0.0 ads.zillow.com >> %HOSTS%
echo 0.0.0.0 ads.zu-ads.com >> %HOSTS%
echo 0.0.0.0 ads.zumobi.com >> %HOSTS%
echo 0.0.0.0 ads.zync.com >> %HOSTS%
echo 0.0.0.0 adservice.google.com >> %HOSTS%
echo 0.0.0.0 adservice.google.com.br >> %HOSTS%
echo 0.0.0.0 googleads.g.doubleclick.net >> %HOSTS%
echo 0.0.0.0 stats.g.doubleclick.net >> %HOSTS%
echo 0.0.0.0 ads.google.com >> %HOSTS%
echo 0.0.0.0 analytics.google.com >> %HOSTS%
echo 0.0.0.0 clickserve.dartsearch.net >> %HOSTS%
echo 0.0.0.0 pagead2.googlesyndication.com >> %HOSTS%
echo 0.0.0.0 tpc.googlesyndication.com >> %HOSTS%
echo 0.0.0.0 google-analytics.com >> %HOSTS%
echo 0.0.0.0 www.google-analytics.com >> %HOSTS%
echo 0.0.0.0 an.facebook.com >> %HOSTS%
echo 0.0.0.0 ads.facebook.com >> %HOSTS%
echo 0.0.0.0 analytics.facebook.com >> %HOSTS%
echo 0.0.0.0 stats.fb.com >> %HOSTS%
echo 0.0.0.0 pixel.facebook.com >> %HOSTS%
echo 0.0.0.0 tracking.facebook.com >> %HOSTS%
echo 0.0.0.0 analytics.instagram.com >> %HOSTS%
echo 0.0.0.0 stats.instagram.com >> %HOSTS%
echo 0.0.0.0 ads.yahoo.com >> %HOSTS%
echo 0.0.0.0 adserver.yahoo.com >> %HOSTS%
echo 0.0.0.0 analytics.yahoo.com >> %HOSTS%
echo 0.0.0.0 tracking.yahoo.com >> %HOSTS%
echo 0.0.0.0 gemini.yahoo.com >> %HOSTS%
echo 0.0.0.0 ups.analytics.yahoo.com >> %HOSTS%
echo 0.0.0.0 ads.twitter.com >> %HOSTS%
echo 0.0.0.0 analytics.twitter.com >> %HOSTS%
echo 0.0.0.0 ads-api.tiktok.com >> %HOSTS%
echo 0.0.0.0 analytics.tiktok.com >> %HOSTS%
echo 0.0.0.0 ads.reddit.com >> %HOSTS%
echo 0.0.0.0 out.reddit.com >> %HOSTS%
echo 0.0.0.0 events.reddit.com >> %HOSTS%
echo 0.0.0.0 telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 telemetry.vortex.microsoft.com >> %HOSTS%
echo 0.0.0.0 settings-win.data.microsoft.com >> %HOSTS%
echo 0.0.0.0 dc.services.visualstudio.com >> %HOSTS%
echo 0.0.0.0 watson.telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 b.scorecardresearch.com >> %HOSTS%
echo 0.0.0.0 edge.quantserve.com >> %HOSTS%
echo 0.0.0.0 pixel.quantserve.com >> %HOSTS%
echo 0.0.0.0 mc.yandex.ru >> %HOSTS%
echo 0.0.0.0 track.adform.net >> %HOSTS%
echo 0.0.0.0 trc.taboola.com >> %HOSTS%
echo 0.0.0.0 data.flurry.com >> %HOSTS%
echo 0.0.0.0 api.mixpanel.com >> %HOSTS%
echo 0.0.0.0 collect.clicky.com >> %HOSTS%
echo 0.0.0.0 logs.amplitude.com >> %HOSTS%
echo 0.0.0.0 beacon.krxd.net >> %HOSTS%
echo 0.0.0.0 track.hubspot.com >> %HOSTS%
echo 0.0.0.0 script.hotjar.com >> %HOSTS%
echo 0.0.0.0 vars.hotjar.com >> %HOSTS%
echo 0.0.0.0 static.hotjar.com >> %HOSTS%
echo 0.0.0.0 collect.newrelic.com >> %HOSTS%
echo 0.0.0.0 bam.nr-data.net >> %HOSTS%
echo 0.0.0.0 js-agent.newrelic.com >> %HOSTS%
echo 0.0.0.0 tracker.bluekai.com >> %HOSTS%
echo 0.0.0.0 sync.mathtag.com >> %HOSTS%
echo 0.0.0.0 pixel.mathtag.com >> %HOSTS%
echo 0.0.0.0 match.adsrvr.org >> %HOSTS%
echo 0.0.0.0 pixel.adsrvr.org >> %HOSTS%
echo 0.0.0.0 api.segment.io >> %HOSTS%
echo 0.0.0.0 tracker.outbrain.com >> %HOSTS%
echo 0.0.0.0 track.mparticle.com >> %HOSTS%
echo 0.0.0.0 tracking.redshell.io >> %HOSTS%
echo 0.0.0.0 stats.unity3d.com >> %HOSTS%
echo 0.0.0.0 cdp.cloud.unity3d.com >> %HOSTS%
echo 0.0.0.0 o2.mouseflow.com >> %HOSTS%
:: --- Telemetria Principal do Sistema ---
echo 0.0.0.0 telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 telemetry.vortex.microsoft.com >> %HOSTS%
echo 0.0.0.0 vortex-win.data.microsoft.com >> %HOSTS%
echo 0.0.0.0 settings-win.data.microsoft.com >> %HOSTS%
echo 0.0.0.0 dc.services.visualstudio.com >> %HOSTS%
echo 0.0.0.0 watson.telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 watson.ppe.telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 diagtrackswc.cloudapp.net >> %HOSTS%
echo 0.0.0.0 corp.sts.microsoft.com >> %HOSTS%
echo 0.0.0.0 compatexchange.microsoft.com >> %HOSTS%
echo 0.0.0.0 a-0001.a-msedge.net >> %HOSTS%
echo 0.0.0.0 statsfe2.ws.microsoft.com >> %HOSTS%
echo 0.0.0.0 sls.update.microsoft.com.akadns.net >> %HOSTS%
echo 0.0.0.0 fe2.update.microsoft.com.akadns.net >> %HOSTS%
echo 0.0.0.0 diagnostics.support.microsoft.com >> %HOSTS%
echo 0.0.0.0 i1.services.social.microsoft.com >> %HOSTS%
echo 0.0.0.0 oca.telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 oca.telemetry.microsoft.com.nsatc.net >> %HOSTS%
echo 0.0.0.0 pre.footprintpredict.com >> %HOSTS%
echo 0.0.0.0 reports.wes.df.telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 telemetry.appex.bing.com >> %HOSTS%
echo 0.0.0.0 telemetry.urs.microsoft.com >> %HOSTS%
echo 0.0.0.0 sqm.telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 sqm.telemetry.microsoft.com.nsatc.net >> %HOSTS%
:: --- Telemetria de Apps (Xbox, Office, Skype, OneDrive) ---
echo 0.0.0.0 xlog.p.prj.bing.com >> %HOSTS%
echo 0.0.0.0 xboxlive.com >> %HOSTS%
echo 0.0.0.0 user.vortex.weather.microsoft.com >> %HOSTS%
echo 0.0.0.0 settings-sandbox.data.microsoft.com >> %HOSTS%
echo 0.0.0.0 survey.watson.microsoft.com >> %HOSTS%
echo 0.0.0.0 officeclient.microsoft.com >> %HOSTS%
echo 0.0.0.0 nexus.officeapps.live.com >> %HOSTS%
echo 0.0.0.0 config.edge.skype.com >> %HOSTS%
echo 0.0.0.0 pipe.skype.com >> %HOSTS%
echo 0.0.0.0 feedback.skype.com >> %HOSTS%
echo 0.0.0.0 live.rads.msn.com >> %HOSTS%
echo 0.0.0.0 bingads.microsoft.com >> %HOSTS%
echo 0.0.0.0 msftncsi.com >> %HOSTS%
echo 0.0.0.0 www.msftncsi.com >> %HOSTS%
echo 0.0.0.0 v10.vortex-win.data.microsoft.com >> %HOSTS%
echo 0.0.0.0 v10.events.data.microsoft.com >> %HOSTS%
echo 0.0.0.0 v20.events.data.microsoft.com >> %HOSTS%
echo 0.0.0.0 browser.events.data.microsoft.com >> %HOSTS%
echo 0.0.0.0 client.events.data.microsoft.com >> %HOSTS%
:: --- Cortana e Busca do Windows ---
echo 0.0.0.0 cortana.it >> %HOSTS%
echo 0.0.0.0 search.msn.com >> %HOSTS%
echo 0.0.0.0 client-s.gateway.messenger.live.com >> %HOSTS%
echo 0.0.0.0 g.msn.com >> %HOSTS%
echo 0.0.0.0 a.ads1.msn.com >> %HOSTS%
echo 0.0.0.0 b.ads1.msn.com >> %HOSTS%
echo 0.0.0.0 ad.doubleclick.net >> %HOSTS%
echo 0.0.0.0 ads1.msads.net >> %HOSTS%
echo 0.0.0.0 ads1.msn.com >> %HOSTS%
echo 0.0.0.0 rad.msn.com >> %HOSTS%
echo 0.0.0.0 static.2cl.bing.com >> %HOSTS%
:: --- Outros Serviços de Coleta ---
echo 0.0.0.0 choice.microsoft.com >> %HOSTS%
echo 0.0.0.0 choice.microsoft.com.nsatc.net >> %HOSTS%
echo 0.0.0.0 df.telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 wes.df.telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 services.wes.df.telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 sqm.df.telemetry.microsoft.com >> %HOSTS%
echo 0.0.0.0 telemetry.microsoft.com.nsatc.net >> %HOSTS%

:: Lista de IPs: Mullvad, AdGuard, DNS.SB, OpenDNS, Cloudflare, Google
set "dns_ips=194.242.2.2 94.140.14.14 185.222.222.222 208.67.222.222 1.1.1.1 8.8.8.8"

set "min_ping=9999"
set "best_dns=1.1.1.1"

:: Identifica o nome da interface de rede ativa com gateway padrão
for /f "tokens=2 delims==" %%i in ('wmic niccfg where "IPEnabled=True" get SettingID /value 2^>nul') do (
    for /f "tokens=3* delims= " %%a in ('netsh interface show interface ^| findstr /c:"Connected" /c:"Conectado"') do (
        set "adapter_name=%%b"
    )
)

:: Loop de teste de latência (silencioso)
for %%a in (%dns_ips%) do (
    set "current_ip=%%a"
    for /f "tokens=4 delims==" %%p in ('ping -n 2 !current_ip! ^| findstr "Media Average" 2^>nul') do (
        set "val=%%p"
        set "val=!val:ms=!"
        set "val=!val: =!"
        set /a avg_ping=!val!
        
        if !avg_ping! LSS !min_ping! (
            set "min_ping=!avg_ping!"
            set "best_dns=!current_ip!"
        )
    )
)

:: Aplica o DNS apenas se uma interface ativa foi encontrada
if defined adapter_name (
    netsh interface ipv4 set dnsservers name="%adapter_name%" source=static address=%best_dns% validate=no >nul 2>&1
    ipconfig /flushdns >nul 2>&1
)

powershell -Command "Get-NetAdapterBinding -ComponentID ms_tcpip6 | Disable-NetAdapterBinding" >nul 2>&1

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v "DisabledComponents" /t REG_DWORD /d 255 /f >nul 2>&1

netsh interface ipv6 6to4 set state state=disabled >nul 2>&1
netsh interface ipv6 isatap set state state=disabled >nul 2>&1
netsh interface teredo set state disabled >nul 2>&1

powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol" >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces" /v "NetbiosOptions" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows NT\DNSClient" /v "EnableMulticast" /t REG_DWORD /d 0 /f >nul 2>&1
netsh interface teredo set state disabled >nul 2>&1
netsh interface ipv6 isatap set state disabled >nul 2>&1
netsh interface ipv4 set global igmplevel=none >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{Interface-ID}" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{Interface-ID}" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" /v "WpadOverride" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "fDisableCam" /t REG_DWORD /d 1 /f >nul 2>&1
sc stop iphlpsvc >nul 2>&1
sc config iphlpsvc start= disabled >nul 2>&1
sc stop Browser >nul 2>&1
sc config Browser start= disabled >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\LLTD" /v "AllowResponder" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Windows\LLTD" /v "AllowLLTDIO" /t REG_DWORD /d 0 /f >nul 2>&1

:: 1. Desativa o RSS (Receive Side Scaling) e NetDMA
:: Em algumas CPUs, o RSS causa picos de latência ao distribuir pacotes entre núcleos.
netsh int tcp set global rss=disabled >nul 2>&1
netsh int tcp set global netdma=disabled >nul 2>&1

:: 2. Desativa o Descarregamento de Chaminé TCP (Chimney Offload)
:: Evita que a placa de rede tente processar tarefas que a CPU faz melhor, reduzindo quedas de pacotes.
netsh int tcp set global chimney=disabled >nul 2>&1

:: 3. Otimiza o Gerenciamento de Congestionamento (CTCP)
:: Melhora a recuperação de pacotes perdidos em conexões de banda larga.
netsh int tcp set global congestionprovider=ctcp >nul 2>&1

:: 4. Desativa o ECN (Explicit Congestion Notification)
:: Alguns roteadores antigos lidam mal com ECN, causando quedas súbitas de conexão.
netsh int tcp set global ecncapability=disabled >nul 2>&1

:: 5. Desativa a Moderação de Interrupção (Interrupt Moderation) no Registro
:: Isso força a CPU a processar pacotes instantaneamente em vez de esperar e agrupá-los.
:: Nota: Aplicado de forma genérica para interfaces TCP/IP.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxFreeTcbs" /t REG_DWORD /d 65536 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxHashTableSize" /t REG_DWORD /d 4096 /f >nul 2>&1

:: 6. Desativa a Economia de Energia da Placa de Rede (PCI Express)
:: Impede que o Windows reduza a energia do barramento de rede durante o uso.
powercfg -setacvalueindex scheme_current sub_pciexpress aspm 0 >nul 2>&1
powercfg -setactive scheme_current >nul 2>&1

:: 7. Limpeza e Reinício da Pilha de Rede
netsh int ip reset >nul 2>&1
netsh winsock reset >nul 2>&1

reg add "HKLM\System\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 38 /f >nul 2>&1

:: Identifica o GUID do esquema de energia atual para aplicar as mudanças nele
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Default\PowerSchemes" /v "ActivePowerScheme"') do set "scheme=%%a"

:: 1. Desativa o Core Parking (Garante todos os núcleos ativos)
:: Define o mínimo de núcleos não estacionados para 100%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Default\PowerSchemes\%scheme%\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c30e-43da-923d-fc3539977382" /v "ACSettingIndex" /t REG_DWORD /d 0 /f >nul 2>&1

:: 2. Define Estado de Desempenho Mínimo para 100% (Clock sempre alto)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Default\PowerSchemes\%scheme%\54533251-82be-4824-96c1-47b60b740d00\893df05d-c4a1-44d3-b7a2-def56091097a" /v "ACSettingIndex" /t REG_DWORD /d 100 /f >nul 2>&1

:: 3. Define Estado de Desempenho Máximo para 100%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Default\PowerSchemes\%scheme%\54533251-82be-4824-96c1-47b60b740d00\bc5038f7-23e0-4960-96d3-3559351c2e30" /v "ACSettingIndex" /t REG_DWORD /d 100 /f >nul 2>&1

:: 4. Define a Política de Aumento de Desempenho para "Agressiva" (Prioridade total ao Turbo Boost)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Default\PowerSchemes\%scheme%\54533251-82be-4824-96c1-47b60b740d00\be337238-0d82-4146-a960-4f3749d470c7" /v "ACSettingIndex" /t REG_DWORD /d 2 /f >nul 2>&1

:: 5. Desativa a Suspensão Seletiva USB (Evita interrupções de periféricos)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Default\PowerSchemes\%scheme%\2a737441-1930-4402-8d77-b2bebba308a3\48352b59-5436-47ae-805c-c0590b0e3a9c" /v "ACSettingIndex" /t REG_DWORD /d 0 /f >nul 2>&1

:: 1. Ativa o Agendamento de GPU Acelerado por Hardware (HAGS)
:: Permite que a GPU gerencie sua própria memória, reduzindo a latência da CPU.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1

:: 2. Prioridade de GPU para Jogos (DWM e Processos)
:: Garante que o agendador do Windows dê fatias de tempo prioritárias para tarefas gráficas.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1

:: 3. Desativa a Economia de Energia do Barramento PCIe (ASPM)
:: Impede que o link entre a CPU e a GPU entre em modo de baixo consumo (L0s/L1).
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Default\PowerSchemes" /v "ActivePowerScheme"') do set "scheme=%%a"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Default\PowerSchemes\%scheme%\2e0eb17e-511d-4831-992a-211121081517\ee12f248-ad27-4ad0-ba07-273a54203444" /v "ACSettingIndex" /t REG_DWORD /d 0 /f >nul 2>&1

:: 4. Aumenta o TDR (Timeout Detection and Recovery)
:: Impede que o Windows reinicie o driver de vídeo ao notar uma carga de processamento muito longa.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f >nul 2>&1

:: 5. Desativa o limite de FPS do Game DVR e Power Throttling
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul 2>&1


:: 1. Otimiza o tamanho do buffer de I/O para o Cache do Sistema
:: Aumenta a eficiência de transferência entre a RAM e o Cache da CPU.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 16777216 /f >nul 2>&1

:: 3. Ajusta o Large System Cache
:: Faz com que o sistema operacional priorize o cache de arquivos do sistema para maior velocidade de resposta.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul 2>&1

:: 4. Desativa contadores de desempenho de rede que interrompem o cache
:: Esses contadores geram interrupções constantes para medir performance, o que "polui" o processamento do cache.
lodctr /d:PerfOS >nul 2>&1
lodctr /d:PerfProc >nul 2>&1
lodctr /d:Tcpip >nul 2>&1

:: 5. Otimiza o Pre-fetcher e o Superfetch para focar apenas no boot e apps críticos
:: Reduz a carga de fundo que tenta adivinhar o que você vai abrir, deixando o cache livre para o que já está rodando.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 3 /f >nul 2>&1

:: --- PRIVACIDADE E RASTREAMENTO ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

:: --- CORTANA E MICROSOFT COPILOT ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CanCortanaBeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Cached" /v "{30369E89-317E-448D-BB9D-70A64C9797A2} {00000000-0000-0000-0000-000000000000} 0xFFFF" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows AI" /v "DisableAIDataAnalysis" /t REG_DWORD /d 1 /f >nul 2>&1

:: --- MICROSOFT EDGE (CHROMIUM) ---
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "SearchSuggestEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "ShowHubsSidebar" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "EdgeShoppingAssistantEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\Software\Policies\Microsoft\Edge" /v "ComposeEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

:: --- WINDOWS EXPLORER E BARRA DE TAREFAS ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowRecent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f >nul 2>&1

:: --- LOCK SCREEN (TELA DE BLOQUEIO) ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f >nul 2>&1

:: --- SINCRONIZAÇÃO DE CONFIGURAÇÕES ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d 5 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1

:: --- APP PRIVACY (MICROFONE, CAMERA, ETC) ---
:: Exemplo para desativar acesso global (conforme as imagens)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f >nul 2>&1

:: --- DIVERSOS / MISCELLANEOUS ---
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f >nul 2>&1

:: Desativa o serviço de geolocalização e impede sua visualização
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Visibility" /t REG_DWORD /d 0 /f

:: Desativa o serviço de sensores
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorService" /v "Start" /t REG_DWORD /d 4 /f

:: Desativa o serviço de dados de sensores
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorsDataService" /v "Start" /t REG_DWORD /d 4 /f

:: Desativa o serviço de monitoramento de sensores
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SensorDataService" /v "Start" /t REG_DWORD /d 4 /f

:: Aplica restrição de política para que o usuário não consiga alterar manualmente
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d 1 /f

dism /online /disable-feature /featurename:Internet-Explorer-Optional-amd64 /norestart

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d 00000000 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d 00000000 /f

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /V "AppCaptureEnabled" /T REG_DWORD /D 0 /F
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /V "GameDVR_Enabled" /T REG_DWORD /D 0 /F
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /V "AllowgameDVR" /T REG_DWORD /D 0 /F
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /V "AllowAutoGameMode" /T REG_DWORD /D 0 /F
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /V "AutoGameModeEnabled" /T REG_DWORD /D 0 /F

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "EnableSmartScreen" /T REG_DWORD /D 0 /F
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /V "ShellSmartScreenLevel" /F

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "PreventIndexingOutlook" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "PreventIndexingEmailAttachments" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AutoIndexSharedFolders" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaConsent" /t REG_DWORD /d 0 /f

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f

reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d 506 /f
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response" /v "Flags" /t REG_SZ /d 122 /f
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys" /v "Flags" /t REG_SZ /d 58 /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v "SyncFavoritesBetweenIEAndMicrosoftEdge" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v "PreventLiveTileDataCollection" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" /v "AllowPrelaunch" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "PreventTabPreloading" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v "AllowTabPreloading" /t REG_DWORD /d 0 /f

Reg Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\0\2093230218" /v EnabledState /t REG_DWORD /d 2 /f
Reg Add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FeatureManagement\Overrides\0\2093230218" /v EnabledStateOptions /t REG_DWORD /d 0 /f

REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /V "GPU Priority" /T REG_DWORD /D 8 /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /V Priority /T REG_DWORD /D 6 /F
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /V "Scheduling Category" /T REG_SZ /D High /F

REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power\PowerThrottling" /V PowerThrottlingOff /T REG_DWORD /D 1 /F

Reg Add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled" /t REG_DWORD /d 1 /f
Reg Add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BackgroundAppGlobalToggle /t REG_DWORD /d 0 /f

REG delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}" /f
REG delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3936E9E4-D92C-4EEE-A85A-BC16D5EA0819}" /f
REG delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f
REG delete "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\HomeFolderDesktop\NameSpace\DelegateFolders\{3134ef9c-6b18-4996-ad04-ed5912e00eb5}" /f

REG ADD "HKEY_CURRENT_USER\Control Panel\Keyboard" /v PrintScreenKeyForSnippingEnabled /d 1 /t REG_DWORD /f

REG ADD "HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /d 1 /t REG_DWORD /f

REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v EnableDynamicContentInWSB /d 0 /t REG_DWORD /f

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization" /v Value /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v IsDeviceSearchHistoryEnabled /t REG_DWORD /d 0 /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v EnableDynamicContentInWSB /t REG_DWORD /d 0 /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\downloadsFolder" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureProgrammatic" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\graphicsCaptureWithoutBorder" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v Value /t REG_SZ /d Deny /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v Value /t REG_SZ /d Deny /f

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate" /v RemoveDesktopShortcutDefault /t REG_DWORD /d 1 /f

REG ADD "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /d 0 /t REG_DWORD /f

powershell -Command "Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol"

reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" /v Enabled /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" /v Enabled /t REG_DWORD /d 0 /f

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" /v "RestrictSendingNTLMTraffic" /t REG_DWORD /d 2 /f

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /f

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d 0 /f

netsh int tcp set global autotuninglevel=disabled
netsh int tcp set global heuristics=disabled
netsh int tcp set global chimney=disabled
netsh int tcp set global rss=disabled
netsh int tcp set global rsc=disabled
netsh int tcp set global ecncapability=disabled
netsh int tcp set global timestamps=enabled
netsh int tcp set global dca=disabled
netsh int tcp set global netdma=disabled

powershell -Command "Set-MpPreference -ScanAvgCPULoadFactor 15"
powershell -Command "Set-MpPreference -DisableArchiveScanning $true"
powershell -Command "Set-MpPreference -DisableScanningNetworkFiles $true"
powershell -Command "Set-MpPreference -DisableEmailScanning $true"

powershell -Command "Get-AppxPackage -AllUsers *bingweather* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers *bingnews* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers *windowsmaps* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers *getstarted* | Remove-AppxPackage"
powershell -Command "Get-AppxPackage -AllUsers *yourphone* | Remove-AppxPackage"

dism /online /cleanup-image /startcomponentcleanup /resetbase

taskkill /f /im msedge.exe
taskkill /f /im MicrosoftEdgeUpdate.exe
rd /s /q "C:\Program Files (x86)\Microsoft\Edge"
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate"
powershell -Command "Get-AppxPackage -AllUsers *MicrosoftEdge* | Remove-AppxPackage -AllUsers"
del /f /q "%Public%\Desktop\Microsoft Edge.lnk"
del /f /q "%UserProfile%\Desktop\Microsoft Edge.lnk"
reg add "HKLM\Software\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\89342227-0973-43b4-8274-1004613b3047" /v "Attributes" /t REG_DWORD /d 2 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\501a4d13-42af-4429-9fd1-a8219c268e20\ee12f248-ee4b-4748-85c0-891001746f8f" /v "Attributes" /t REG_DWORD /d 2 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 1 /f

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowIndexingEncryptedStoresOrItems" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchFiles" /t REG_DWORD /d 0 /f

