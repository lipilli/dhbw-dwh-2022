import paho.mqtt.client as mqtt
import psycopg2 # PostgreSQL database adapter
import json

broker_address = "broker.hivemq.com"

def on_message(client, userdata, message):
    print("message read: ", str(message.payload.decode("utf-8")))
    # Get the message
    message_str = str(message.payload.decode("utf-8"))
    message = json.loads(message_str)
    fin = message["fin"]
    zeit = message["zeit"]
    #source: https://www.postgresqltutorial.com/postgresql-python/insert/
    try: 
        #connect to the database
        conn = psycopg2.connect(dbname='postgres', user='postgres', password='###', port='5432')
        cur = conn.cursor()

        # insert data into db
        sql_command = f"insert into staging.messung (payload, erstellt_am, quelle) values ('{message_str}','{zeit}', '{fin}');"
        #print(sql_command)
        #     "insert into staging.messung (messung_id, payload, erstellt_am, quelle) \
        # values (%s, %s, %s, %s);" %(measurement_id, message, zeit, fin)
        cur.execute(sql_command)

        #end
        conn.commit()
        cur.close()
        conn.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
    




client = mqtt.Client("debs_subscriber", clean_session=False)
client.on_message = on_message
client.connect(broker_address)
client.subscribe("DataMgmt/FIN", qos=1)
client.loop_forever()
