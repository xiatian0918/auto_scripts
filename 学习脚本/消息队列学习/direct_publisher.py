#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian

import pika
import sys

credentials = pika.PlainCredentials('openstack', 'openstack')
connection = pika.BlockingConnection(pika.ConnectionParameters(
    '192.168.56.11',5672,'/',credentials))

channel = connection.channel()

channel.exchange_declare('direct_logs',
                         'direct')

severity = sys.argv[1] if len(sys.argv) > 1 else 'info'
message = ' '.join(sys.argv[2:]) or 'Hello World!'

channel.basic_publish(exchange='direct_logs',
                      routing_key=severity,
                      body=message)
print(" [x] Sent %r:%r" % (severity, message))
connection.close()