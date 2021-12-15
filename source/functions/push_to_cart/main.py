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


def insert_to_cart(request):

    request_json = request.get_json()

    # haetaan POSTin tuuppaamasta jsonista: korin id, tuote-id ja määrä
    # hinta haetaan tuote-id:n perusteella eri haulla tietokannasta
    if request_json and 'cart_id' in request_json:
        cart = request_json['cart_id']
        product_id = request_json['product_id']
        buy_amount = request_json['amount']

    else:
        return "Not a valid request!"
    
    con = None

    try:
        con = psycopg2.connect(database = db_name, user = db_user_name, password = db_passwd, host = db_host)

        # haetaan hinta
        # ---------------------------------------------------------------------------------------------------
        cursor_get_price = con.cursor()
        
        SQL = f"select product_price from tuote where id = {product_id};"
        cursor_get_price.execute(SQL)
        
        price = cursor_get_price.fetchone()
        cursor_get_price.close()
        
        
        # lisätään tuote ostoskoriin
        # ---------------------------------------------------------------------------------------------------
        cursor_insert_db = con.cursor()

        SQL = f"INSERT INTO ostoskori (bucket_id, product_amount, product_price, product_id) VALUES(%s,%s,%s,%s);"
        values = (cart, buy_amount, price, product_id)

        cursor_insert_db.execute(SQL, values)
        con.commit()
        
        cursor_get_price.close()
        
        return "Tuote lisätty ostoskoriin"
        

    # TODO: poikkeusten käsittely + loggaushommat
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

    finally:
        if con is not None:
            con.close()
