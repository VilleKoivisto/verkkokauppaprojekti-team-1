# coding=utf-8

"""
Hakee kaikki tuotteet ostoskorista
    http-GET -> funktio -> json

entrypoint: get_cart
runtime: python39
"""


import psycopg2
import logging
import requests
import json
import os


db_name = os.environ.get('database_name', 'Specified environment variable is not set.')
db_user_name = os.environ.get('database_user', 'Specified environment variable is not set.')
db_passwd = os.environ.get('database_pw', 'Specified environment variable is not set.')
db_host = os.environ.get('database_host', 'Specified environment variable is not set.')


def get_cart(request):

    request_json = request.get_json()

    if request.args and 'cart_id' in request.args:
        cart = int(request.args.get('cart_id'))
    else:
        cart = 0
    
    con = None

    try:
        con = psycopg2.connect(database = db_name, user = db_user_name, password = db_passwd, host = db_host)
        cursor = con.cursor()

        SQL = 'SELECT tuote.product_name AS product_name, tuote.product_price AS unit_price, ostoskori.product_amount AS amount, ostoskori.product_price AS total_price FROM ostoskori INNER JOIN tuote ON ostoskori.product_id = tuote.id WHERE bucket_id = %s; '
        record_to_insert=(cart,)
        cursor.execute(SQL, record_to_insert)

        results = cursor.fetchall()
    
        results_json = json.dumps(results)
        print(results_json)

        return results_json
        

    # TODO: poikkeusten käsittely + loggaushommat
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

    finally:
        if con is not None:
            con.close()


 
