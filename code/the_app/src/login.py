from flask import Blueprint, request, make_response, jsonify
import json
from src import db

login = Blueprint('login', __name__)


"""
Get drivers ID from user login credentials.
"""
@login.route('/persona', methods=['GET'])
def getPersonaDriverID():
    cur = db.get_db().cursor()
    cur.execute('select driversID from UserCredential where nickname = "{0}" and password = {1}'.format(request.form.get('username'), request.form.get('password')))
    row_headers = [x[0] for x in cur.description]
    json_data = []
    theData = cur.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)




"""
Get drivers ID from clerk login credentials.
"""
@login.route('/persona', methods=['GET'])
def getClerksEmployID():
    cur = db.get_db().cursor()
    cur.execute('select EmployeeID from AccessCredentials where NickName = "{0}" and Password = {1}'.format(request.form.get('username'), request.form.get('password')))
    row_headers = [x[0] for x in cur.description]
    json_data = []
    theData = cur.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    return jsonify(json_data)


