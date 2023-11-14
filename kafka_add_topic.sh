#!/bin/bash

if [ $# -lt 1 ]
then 
   echo "Usage: kf.sh {start|stop|kc [topic]|kp [topic]}"
   exit:
fi
case $1 in 
start)
	for i in hadoop102 hadoop103 hadoop104
	do
      echo "====================> START $i KF <===================="
      ssh $i kafka-server-start.sh  -daemon /opt/module/kafka_2.11-2.4.1/config/server.properties 
	done
;;

stop)
	for i in hadoop102 hadoop103 hadoop104
	do
      echo "====================> STOP $i KF <===================="
      ssh $i kafka-server-stop.sh
	done
;;
kc)
	if [ $2 ]
	then
	   kafka-console-consumer.sh --bootstrap-server hadoop102:9092,hadoop103:9092,hadoop104:9092 --topic $2
	else
          echo "Usage: kf.sh {start|stop|kc [topic]|kp [topic]}"
	fi
;;
kp)
	if [ $2 ]
	then 
 	  kafka-console-producer.sh --broker-list hadoop102:9092,hadoop103:9092,hadoop104:9092 --topic $2
	else
	  echo "Usage: kf.sh {start|stop|kc [topic]|kp [topic]}"
	fi
;;

*)
   echo "Usage: kf.sh {start|stop|kp|kc}"
   exit
;;
esac
