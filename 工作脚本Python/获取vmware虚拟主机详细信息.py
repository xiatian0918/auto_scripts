#!/usr/bin/env python
#-*- coding:utf-8 -*-
# author: xiatian


import requests
import urllib3
from vmware.vapi.vsphere.client import create_vsphere_client


session = requests.session()
session.verify = False

# Disable the secure connection warning for demo purpose.
# This is not recommended in a production environment.
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Connect to a vCenter Server using username and password
vsphere_client = create_vsphere_client(server='192.168.0.24', username='administrator@vsphere.local', \
                                       password='Toprs!@#123', session=session)

# List all VMs inside the vCenter Server
print(vsphere_client.vcenter.VM.list())