#! /bin/bash

function kf_start(){
    for i in hadoop102 hadoop103 hadoop104
    do
        ssh $i "/opt/module/kafka/bin/kafka-server-start.sh -daemon /opt/module/kafka/config/server.properties"
        echo " --------$i Kafka Started-------"
    done
}

function kf_stop(){
    for i in hadoop102 hadoop103 hadoop104
    do
        ssh $i "/opt/module/kafka/bin/kafka-server-stop.sh "
        echo " --------$i Kafka Stoped-------"

    done
}

function kf_status(){
    for i in hadoop102 hadoop103 hadoop104
    do
        echo " --------$i Kafka-------"
        ssh $i "nc -z localhost 9092 && echo '正常' || echo '异常' "
    done
}

function list(){
    kafka-topics.sh --bootstrap-server hadoop102:9092 --list
}

case $1 in

"start")
    kf_start
;;

"stop")
    kf_stop
;;

"list")
    list
;;

"status")
    kf_status
;;

"restart")
    kf_stop
    sleep 15
    kf_start
;;

"kc")
    if [ $2 ]
	then
	   kafka-console-consumer.sh --bootstrap-server hadoop102:9092,hadoop103:9092,hadoop104:9092 --topic $2
	else
          echo "Usage: kf.sh {start|stop|kc [topic]|kp [topic]}"
	fi
;;

"kp")
    if [ $2 ]
	then 
 	  kafka-console-producer.sh --broker-list hadoop102:9092,hadoop103:9092,hadoop104:9092 --topic $2
	else
	  echo "Usage: kf.sh {start|stop|kc [topic]|kp [topic]}"
	fi
;;


*)
    echo "Usage: kafka.sh start|start|stop|status|restart|kp TOPIC|kc TOPIC"
    ;;
esac
