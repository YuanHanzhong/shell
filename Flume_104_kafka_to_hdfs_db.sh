#!/bin/bash
FLUME_HOME=/opt/module/flume
APP_HOME=/opt/module/applog
function f2_start(){
  for host in hadoop104
  do
    ssh $host "nohup $FLUME_HOME/bin/flume-ng agent -n a1 -c $FLUME_HOME/conf -f /opt/module/flume/job/kafka_to_hdfs_db.conf -Dflume.root.logger=INFO,console 1>/opt/module/flume/f2.log 2>&1 &"
  done
}

function f2_stop(){
  for host in hadoop104
  do
    ssh $host "ps -ef | grep kafka_to_hdfs_db | grep -v grep | awk '{print \$2}' | xargs -n1 kill"
  done
}

function f2_status(){
  for host in hadoop104
  do
    echo "==========  $host  ==========="
    ssh $host "[ \$(ps -ef | grep kafka_to_hdfs_db | grep -v grep |wc -l) -eq 1 ] && echo ok || echo error"
  done
}

case $1 in
"start")
  f2_start
  ;;
"stop")
  f2_stop
  ;;
"status")
  f2_status
  ;;
"restart")
  f2_stop
  sleep 5
  f2_start
  ;;
*)
  echo "Usage: f2.sh start|stop|status|restart"
  ;;
esac