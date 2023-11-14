
#!/bin/bash

if [ $# -lt 1 ]
then
    echo "No Args Input..."
    exit ;
fi

function start(){
    echo " =================== 启动 hadoop集群 ==================="
    echo " --------------- 启动 hdfs ---------------"
    ssh hadoop102 "/opt/module/hadoop-3.1.3/sbin/start-dfs.sh"
    echo " --------------- 启动 yarn ---------------"
    ssh hadoop103 "/opt/module/hadoop-3.1.3/sbin/start-yarn.sh"
    echo " --------------- 启动 historyserver ---------------"
    ssh hadoop102 "/opt/module/hadoop-3.1.3/bin/mapred --daemon start historyserver"
}

function stop(){
    echo " =================== 关闭 hadoop集群 ==================="
    echo " --------------- 关闭 historyserver ---------------"
    ssh hadoop102 "/opt/module/hadoop-3.1.3/bin/mapred --daemon stop historyserver"
    echo " --------------- 关闭 yarn ---------------"
    ssh hadoop103 "/opt/module/hadoop-3.1.3/sbin/stop-yarn.sh"
    echo " --------------- 关闭 hdfs ---------------"
    ssh hadoop102 "/opt/module/hadoop-3.1.3/sbin/stop-dfs.sh"
}

case $1 in
"start")
	start
;;

"stop")
	stop
;;


"restart")
	stop
	sleep 2
	start
;;

*)
    echo "Input Args Error..."
;;
esac
