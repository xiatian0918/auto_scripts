#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import pika
import sys

credentials = pika.PlainCredentials('toprs', 'toprs')
connection = pika.BlockingConnection(pika.ConnectionParameters(
    '192.168.0.58',5672,'/',credentials))

channel = connection.channel()

channel.exchange_declare(
                        'direct_logs',
                         'direct')

result = channel.queue_declare(queue='hello2',exclusive=True)
queue_name = result.method.queue

severities = sys.argv[1:]
if not severities:
    sys.stderr.write("Usage: %s [info] [warning] [error]\n" % sys.argv[0])
    sys.exit(1)

print(severities)
for severity in severities:
    channel.queue_bind(exchange='direct_logs',
                       queue=queue_name,
                       routing_key=severity)

print(' [*] Waiting for logs. To exit press CTRL+C')


def callback(ch, method, properties, body):
    print(" [x] %r:%r" % (method.routing_key, body))


channel.basic_consume(callback,
                      queue=queue_name,
                      no_ack=True)

channel.start_consuming()