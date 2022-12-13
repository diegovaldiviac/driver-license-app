from flask import Blueprint, request, make_response, jsonify
import json
from src import db

login = Blueprint('login', __name__)
# Login get instruction (for the submit button)
@login.route('/login', methods=['GET'])
def get_customer():
    cursor = db.get_db().cursor()
    query = 'select * from UserCredential where nickname = {0} and password = {1}'.format(request.form['username'],request.form['password'])
    try: 
        cursor.execute(query)
    except: 
        query = 'select * from AccessCredentials where nickname = {0} and password = {1}'.format(request.form['username'],request.form['password'])
        cursor.execute(query)

    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


@login.route('/test', methods=['GET'])
def test():
    json_data = []
    json_data.append(dict(zip("Key", "Value")))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


