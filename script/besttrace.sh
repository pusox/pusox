IPs[0]=5g.shunicomtest.com
IPs[1]=speedtest4.sh.chinamobile.com
IPs[2]=4gsuzhou1.speedtest.jsinfo.net
IPs[3]=hz5gsp2.zj186.com
IPs[4]=122.229.136.10

NAMEs[0]='上海联通'
NAMEs[1]='上海移动'
NAMEs[2]='苏州电信'
NAMEs[3]='杭州联通'
NAMEs[4]='杭州电信'

wget "https://gitlab.byakko.icu/pusox/pusox/-/raw/main/bin/besttrace" -O /tmp/besttrace
chmod +x /tmp/besttrace

size=5
now=0
while(($now<$size))
do
    echo ${NAMEs[$now]}' '${IPs[$now]}
    /tmp/besttrace ${IPs[$now]}
    let "now++"
done
