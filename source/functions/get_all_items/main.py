# coding=utf-8
"""
Hakee kaikki tuotteet tietokannasta:
http-GET -> funktio -> json

entrypoint: get_all_items
runtime: python39
"""


import psycopg2
import logging
import requests
import json
import os


# Haetaan login-tiedot ympäristömuuttujista <- Secret Manager
db_name = os.environ.get('database_name', 'Specified environment variable is not set.')
db_user_name = os.environ.get('database_user', 'Specified environment variable is not set.')
db_passwd = os.environ.get('database_pw', 'Specified environment variable is not set.')
db_host = os.environ.get('database_host', 'Specified environment variable is not set.')


def get_all_items(request):
    
    con = None

    try:
        con = psycopg2.connect(database = db_name, user = db_user_name, password = db_passwd, host = db_host)
        cursor = con.cursor()

        SQL = 'select tuote.id, tuote.product_name, tuote.product_description, varasto.product_amount, tuote.product_price from tuote, varasto where tuote.id = varasto.product_id;'
        cursor.execute(SQL)
        
        results = cursor.fetchall()
        cursor.close()
        
        results_json = json.dumps(results)
        print(results_json.encode('UTF-8'))

        return results_json.encode('UTF-8')
        

    # TODO: poikkeusten käsittely + loggaushommat
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

    finally:
        if con is not None:
            con.close()