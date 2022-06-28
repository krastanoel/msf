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
Loaded 2 modules:
    1 auxiliary modules
    1 exploit modules
msf6 >
```

# Modules
* [Zoneminder Lang Exec](exploits/unix/webapp/zoneminder_lang_exec.rb)
* [FreeSwitch Login Scanner](auxiliary/scanner/misc/freeswitch_event_socket_login.rb)
