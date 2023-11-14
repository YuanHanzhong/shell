#!/bin/bash
Flume_102_103.sh stop &&
Kafka.sh stop &&
ZooKeeper.sh stop &&
Hadoop.sh stop &&
Flume_104.sh stop &&
Maxwell.sh stop
