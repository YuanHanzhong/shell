#!/bin/bash
Hadoop.sh start 
ZooKeeper.sh start && Kafka.sh start 
Maxwell.realtime.sh start 
