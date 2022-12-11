from flask import Blueprint, request, make_response, jsonify
import json
from src import db

persona = Blueprint('persona', __name__)


@persona.route('/apply', methods=['POST'])
def apply_new_lisence():

   try:

      # request.form to get form parameter
      if request.method == 'POST':
         firstName = request.form.get('first')
         middleName = request.form.get('middle')
         lastName = request.form.get('last')
         state = request.form.get('state')
         zipCode = request.form.get('zipCode')
         restriction = request.form.get('restriction')

         cur = db.get_db().cursor()
         query = 'INSERT INTO `Person` ({firstName}, {middleName}, {lastName}, {email}, {state}, {zipCode}, {restriction})'
         cur.execute(query)

      return "<h1>Submitted!</h1>"
   except Exception as e:
      return "<h1>Error</h1>"




"""
GET call to populate view with existing user infromation
POST call to update/add user information
"""

@persona.route('/renew', methods=['GET', 'POST'])
def get_persona(driverID):
   cursor = db.get_db().cursor()
   cursor.execute('select * from Persona where driverLisence = {0}'.format(driverID))
   
   row_headers = [x[0] for x in cursor.description]
   json_data = []
   theData = cursor.fetchall()
   for row in theData:
      json_data.append(dict(zip(row_headers, row)))
   the_response = make_response(jsonify(json_data))
   the_response.status_code = 200
   the_response.mimetype = 'application/json'

   return the_response


@persona.route('/renew', methods=['GET', 'POST'])
def renew_lisence():
   try:

      # request.form to get form parameter
      if request.method == 'POST':
         firstName = request.form.get('first')
         middleName = request.form.get('middle')
         lastName = request.form.get('last')
         state = request.form.get('state')
         zipCode = request.form.get('zipCode')
         restriction = request.form.get('restriction')

         cur = db.get_db().cursor()
         query = 'INSERT INTO `Person` ({firstName}, {middleName}, {lastName}, {email}, {state}, {zipCode}, {restriction})'
         cur.execute(query)

      return "<h1>Submitted!</h1>"
   except Exception as e:
      return "<h1>Error</h1>"



    
#@.route('/persona2')
#def post_test():
#    return 'Hello'

"""
@app.route("/form", methods = ['POST'])
def post_form():
   first_name = request.form['first']
   last_name = request.form['last']
   return f'<h1>Hello {first_name} {last_name}.</h1>

"""