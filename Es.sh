#!/bin/bash 
es_home=/opt/module/elasticsearch-7.8.0 
kibana_home=/opt/module/kibana7
if [ $# -lt 1 ]
then
	echo "USAGE:es.sh {start|stop}"
	exit
fi	
case $1  in
"start") 
  #启动ES
  for i in hadoop102 hadoop103 hadoop104
  do
    	ssh $i  "source /etc/profile;nohup ${es_home}/bin/elasticsearch >/dev/null 2>&1 &"
  done
  ssh hadoop102 "nohup ${kibana_home}/bin/kibana > ${kibana_home}/logs/kibana.log 2>&1 &"
;;
"stop") 
  #停止ES
  for i in hadoop102 hadoop103 hadoop104
  do
      ssh $i "ps -ef|grep $es_home |grep -v grep|awk '{print \$2}'|xargs kill" >/dev/null 2>&1
  done
  ssh hadoop102 "sudo netstat -nltp | grep 5601 |grep -v tcp|awk '{print $7}' | awk -F /  '{print \$1}'| xargs kill" 
;;
*)
	echo "USAGE:es.sh {start|stop}"
	exit
;;
esac
