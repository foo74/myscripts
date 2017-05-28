#!/bin/sh
# https://www.cyberciti.biz/tips/linux-iptables-4-block-all-incoming-traffic-but-allow-ssh.html
# My system IP/set ip address of server
SERVER_IP="192.168.0.242"
# Flushing all rules
iptables -F
iptables -X
# Setting default filter policy
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
