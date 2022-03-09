import paho.mqtt.client as mqtt
import json
from datetime import datetime as dt
import random as rdm
from time import sleep


broker_address = "broker.hivemq.com"
client = mqtt.Client("debs_publisher", clean_session=False)
client.connect(broker_address)
while True:
    data = {
    "fin": "SNTU411STM9032259",
    "zeit": dt.now().strftime("%Y-%m-%d %H:%M:%S"),
    "geschwindigkeit":(rdm.randint(0,200)),
    "ort":rdm.randint(0,10)
    }
    data_str = json.dumps(data)
    client.publish("DataMgmt/FIN", data_str, qos=1)
    sleep(5)
