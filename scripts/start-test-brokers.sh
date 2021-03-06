#!/bin/bash -e

THIS_DIR="$(dirname $(readlink -f $0))"

cd $THIS_DIR/../deps/brod/docker

## maybe rebuild
sudo docker-compose -f docker-compose-basic.yml build

## stop everything first
sudo docker-compose -f docker-compose-kafka-2.yml down || true

## start the cluster
sudo docker-compose -f docker-compose-kafka-2.yml up -d

## wait 4 secons for kafka to be ready
n=0
while [ "$(sudo docker exec kafka_1 bash -c '/opt/kafka/bin/kafka-topics.sh --zookeeper zookeeper --list')" != '' ]; do
  if [ $n -gt 4 ]; then
    echo "timedout waiting for kafka"
    exit 1
  fi
  n=$(( n + 1 ))
  sleep 1
done

sudo docker exec kafka_1 bash -c "/opt/kafka/bin/kafka-topics.sh --zookeeper zookeeper --create --partitions 3 --replication-factor 2 --topic kastle-3-2"
sudo docker exec kafka_1 bash -c "/opt/kafka/bin/kafka-topics.sh --zookeeper zookeeper --create --partitions 1 --replication-factor 1 --topic test-topic"

