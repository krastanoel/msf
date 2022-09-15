# README
The initial purpose of this repository is to share exploits and auxiliary modules for the community.

# Usage
1. Clone this repository
```
:~# git clone https://github.com/krastanoel/msf
Cloning into 'msf'...
remote: Enumerating objects: 19, done.
remote: Counting objects: 100% (19/19), done.
remote: Compressing objects: 100% (10/10), done.
remote: Total 19 (delta 0), reused 16 (delta 0), pack-reused 0
Receiving objects: 100% (19/19), 4.38 KiB | 0 bytes/s, done.
```
2. open metasploit `msfconsole`
```
:~# msfconsole
[*] Starting the Metasploit FrameworK console...|/
...
       =[ metasploit v6.0.45-dev                          ]
+ -- --=[ 2134 exploits - 1139 auxiliary - 364 post       ]
+ -- --=[ 592 payloads - 45 encoders - 10 nops            ]
+ -- --=[ 8 evasion                                       ]
...

msf6 >
```
3. Load this modules using `loadpath` command
```
msf6 > loadpath ~/msf/boot ~/msf
Loaded 4 modules:
    2 auxiliary modules
    2 exploit modules
msf6 > reload_all
[*] Reloading modules from all module paths...
msf6 > search author:krastanoel

Matching Modules
================

#  Name                                                  Disclosure Date  Rank       Check  Description
-  ----                                                  ---------------  ----       -----  -----------
0  auxiliary/scanner/http/cassandra_web_file_read                         normal     Yes    Cassandra Web File Read Vulnerability
1  auxiliary/scanner/misc/freeswitch_event_socket_login                   normal     Yes    FreeSWITCH Event Socket Login
2  exploit/unix/webapp/gitea_git_fetch_rce               2022-05-16       excellent  Yes    Gitea Git Fetch Remote Code Execution
3  exploit/unix/webapp/zoneminder_lang_exec              2022-04-27       excellent  Yes    ZoneMinder Language Settings Remote Code Execution
```

# Modules
* [Zoneminder Lang Exec](exploits/unix/webapp/zoneminder_lang_exec.rb)
* [FreeSwitch Login Scanner](auxiliary/scanner/misc/freeswitch_event_socket_login.rb)
* [Cassandra Web File Read](auxiliary/scanner/http/cassandra_web_file_read)
