#! /bin/sh
echo '# Generated by xtables-save v1.8.2 on Sun Jan 10 06:02:17 2021
*filter
:INPUT DROP [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
-A INPUT -p tcp -m tcp --dport 31724 -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
-A INPUT -p tcp -m tcp --dport 15239 -j ACCEPT
COMMIT
# Completed on Sun Jan 10 06:02:17 2021' > /etc/iptables.up.rules
echo '#!/bin/sh
/sbin/iptables-restore < /etc/iptables.up.rules' > /etc/network/if-pre-up.d/iptables
chmod +x /etc/network/if-pre-up.d/iptables
