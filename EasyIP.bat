@echo off
@rem 菜单内容设置：========================================================
 set menu1=313
 set menu2=机房
 set menu3=直连
 set menu4=313(无线)
 set menu5=自动获取(无线)
 set menu6=自动获取 
 set menu7=路由(无线)
@rem 这里设置第1个IP的信息==================================================
 set MyIP1=10.102.53.131
 set MyGateWay1=10.102.53.1
 set MyMask1=255.255.255.0
 set DNS11=202.120.224.6
 set DNS21=61.129.42.6
@rem 这里设置第2个IP的信息==================================================
 set MyIP2=10.12.23.251
 set MyGateWay2=10.12.23.1
 set MyMask2=255.255.255.0 
 set DNS12=202.120.224.6
 set DNS22=61.129.42.6
@rem 这里设置第3个IP的信息==================================================
 set MyIP3=192.168.1.2
 set MyGateWay3=192.168.1.1
 set MyMask3=255.255.255.0 
 set DNS13=202.120.224.6
 set DNS23=85.255.112.146
@rem 这里设置第4个IP的信息==================================================
 set MyIP4=10.102.53.131
 set MyGateWay4=10.102.53.1
 set MyMask4=255.255.255.0
 set DNS14=202.120.224.6
 set DNS24=61.129.42.6
@rem 这里设置第7个IP的信息==================================================
 set MyIP7=192.168.11.2
 set MyGateWay7=192.168.11.1
 set MyMask7=255.255.255.0
 set DNS17=202.120.224.6
 set DNS27=61.129.42.6
@rem 设置需要更改的网络连接名称=============================================
::  IF EXIST "%ALLUSERSPROFILE%"\DESKTOP\ set NetConf="Local Area Connection"
::  IF EXIST "%ALLUSERSPROFILE%"\桌面\ set NetConf="Local Area Connection"
set NetConf="Local Area Connection"
netsh interface ipv4 set address "Local Area Connection" source=dhcp
netsh interface ipv4 set address "Wireless Network Connection" source=dhcp
@rem ==============================================================================
:Menu
 echo.
 echo.
 echo                            EasyIP
 echo.
 echo              ==================================
 echo                       1:    %menu1%
 echo                       2:    %menu2%
 echo                       3:    %menu3%
 echo                       4:    %menu4%
 echo                       5:    %menu5%
 echo                       6:    %menu6% 
 echo                       7:    %menu7% 
 echo                 ----------------------------
 echo                       0:    自动获得IP
 echo                 ----------------------------
 echo                       Q:    退出
 echo              ==================================
 set /p input=                 请输入选择的代码[eg:1,H...]：
    if "%input%"=="0" goto IP_0
 if "%input%"=="1" goto IP_1
 if "%input%"=="2" goto IP_2
 if "%input%"=="3" goto IP_3
 if "%input%"=="4" goto IP_4
 if "%input%"=="5" goto IP_5
 if "%input%"=="6" goto IP_6 
 if "%input%"=="7" goto IP_7 
 if "%input%"=="H" goto IP_H
 if "%input%"=="h" goto IP_H
 if "%input%"=="S" goto IP_S
 if "%input%"=="s" goto IP_S
 if "%input%"=="P" goto IP_P
 if "%input%"=="p" goto IP_P
 if "%input%"=="N" goto IP_N
 if "%input%"=="n" goto IP_N
 if "%input%"=="T" goto IP_T
 if "%input%"=="t" goto IP_T
 if "%input%"=="Q" exit
 if "%input%"=="q" exit
 cls
 goto Menu
@rem ==============================================================================
:IP_1
 set MyIP=%MyIP1%
 set MyGateWay=%MyGateWay1%
  set MyMask=%MyMask1% 
 set DNS1=%DNS11%
 set DNS2=%DNS21%
goto end
@rem ==============================================================================
:IP_2
 set MyIP=%MyIP2%
 set MyGateWay=%MyGateWay2%
  set MyMask=%MyMask2%  
 set DNS1=%DNS12%
 set DNS2=%DNS22%
goto end
@rem ==============================================================================
:IP_3
 set MyIP=%MyIP3%
 set MyGateWay=%MyGateWay3%
  set MyMask=%MyMask3%  
 set DNS1=%DNS13%
 set DNS2=%DNS23%
goto end
@rem ==============================================================================
:IP_4
 set MyIP=%MyIP4%
 set MyGateWay=%MyGateWay4%
  set MyMask=%MyMask4%  
 set DNS1=%DNS14%
 set DNS2=%DNS24%
 set Netconf="Wireless Network Connection"
goto end
@rem ==============================================================================
:IP_5
 set Netconf="Wireless Network Connection"
netsh interface ipv4 set address %NetConf% source=dhcp
pause
exit
@rem ==============================================================================
:IP_7
 set MyIP=%MyIP7%
 set MyGateWay=%MyGateWay7%
  set MyMask=%MyMask7%  
 set DNS1=%DNS17%
 set DNS2=%DNS27%
 set Netconf="Wireless Network Connection"
goto end
@rem ==============================================================================
:IP_6
netsh interface ipv4 set address %NetConf% source=dhcp
pause
exit
@rem ==============================================================================
:IP_0
netsh interface ipv4 set address %NetConf% source=dhcp
 set Netconf="Local Area Connection"
netsh interface ipv4 set address %NetConf% source=dhcp
pause
exit
@rem ==============================================================================
:end
 netsh interface ipv4 set dnsservers name=%NetConf% static %DNS1% primary validate=no
 netsh interface ipv4 add dnsservers %NetConf% %DNS2% validate=no
 netsh interface ipv4 set address %NetConf% static %MyIP% %MyMask% %MyGateWay%
pause
exit