"""
Hakee yhden tuotteen tietokannasta:
    http-GET -> funktio -> json

entrypoint: get_single_item
runtime: python39
"""


import psycopg2
import logging
import json
import os


#Haetaan login-tiedot ympäristömuuttujista <- Secret Manager
db_name = os.environ.get('database_name', 'Specified environment variable is not set.')
db_user_name = os.environ.get('database_user', 'Specified environment variable is not set.')
db_passwd = os.environ.get('database_pw', 'Specified environment variable is not set.')
db_host = os.environ.get('database_host', 'Specified environment variable is not set.')



def get_single_item(request):

    request_json = request.get_json()

    if request_json and 'tuote_id' in request_json:
        tuote_id = request_json['tuote_id']

    else:
        return "Not a valid request!"

    con = None

    try:
        con = psycopg2.connect(database = db_name, user = db_user_name, password = db_passwd, host = db_host)
        cursor = con.cursor()
        cursor.execute("SELECT * FROM tuote WHERE id = %s", (tuote_id,))
        results = cursor.fetchone()
        cursor.close()
        
        results_json = json.dumps(results)

        return results_json
        
    except (Exception, psycopg2.DatabaseError) as e:
        logging.error(e)

    finally:
        if con is not None:
            con.close()


# request = {"tuote_id" : 1}
# json_object = json.dumps(request, indent = 2)
# get_single_item(json_object)
