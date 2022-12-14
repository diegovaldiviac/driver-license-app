from flask import Blueprint, request, make_response, jsonify
import json
from src import db



########
# POST #
########
persona = Blueprint('persona', __name__)

@persona.route('/apply', methods=['POST'])
def apply_new_lisence():

   try:
      # request.form to get form parameter
      if request.method == 'POST':
         firstName = request.form.get('first')
         middleName = request.form.get('middle')
         lastName = request.form.get('last')
         email = request.form.get('email')
         state = request.form.get('state')
         zipCode = request.form.get('zipCode')
         #restriction = request.form.get('restriction')

         cur = db.get_db().cursor()
         query = 'INSERT INTO `Person` ({firstName}, {middleName}, {lastName}, {email}, {state}, {zipCode}, B")'
         cur.execute(query)

      return "<h1>Submitted!</h1>"
   except Exception as e:
      return "<h1>Error</h1>"
      
@persona.route('/apply', methods=['POST'])
def Misc():

   try:
      # request.form to get form parameter
      if request.method == 'POST':
         organDonor = request.form.get('first')
         veteran = request.form.get('middle')
         driversID = request.form.get('last')
         #restriction = request.form.get('restriction')

         cur = db.get_db().cursor()
         query = 'INSERT INTO `Misc` ({organDonor}, {veteran}, {driversID})'
         cur.execute(query)

      return "<h1>Submitted!</h1>"
   except Exception as e:
      return "<h1>Error</h1>"

#######
# GET #
#######

# GET USER FIRST MIDDLE LAST NAME
@persona.route("/renew/name/<driversID>", methods=['GET'])
def get_user_name(driversID):

   cur = db.get_db().cursor()
   cur.execute('select firstName, middleName, lastName from Person where driversID = {0}'.format(driversID))
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)


# GET USER LICENSE EXPIRATION DATE
@persona.route("/renew/license/<driversID>", methods=['GET'])
def get_license_info(driversID):

   cur = db.get_db().cursor()
   cur.execute('select expirationDate from LicenseAssociatedInformation where driversID = {0}'.format(driversID))
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)

# GET USER LICENSE PLATE
@persona.route("/renew/licensePlate/<driversID>", methods=['GET'])
def get_license_plate(driversID):

   cur = db.get_db().cursor()
   cur.execute('select licensePlate from VehicleInformation where driversID = {0}'.format(driversID))
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)


# GET USER DRIVER STATUS
@persona.route("/renew/application/<driversID>", methods=['GET'])
def get_application(driversID):
   cur = db.get_db().cursor()
   cur.execute('select roadTestResult, statusOfLearnersPermit from PreValidationData where driversID = {0}'.format(driversID))
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)



# GET USER ADDRESS
@persona.route("/renew/address/<driversID>", methods=['GET'])
def get_address(driversID):

   cur = db.get_db().cursor()
   cur.execute('select state, zipCode from Person where driversID = {0}'.format(driversID))
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)







   #
   #cursor.execute('select * from ApplicationStatus where driversID = {0}'.format(driversID))
   #cursor.execute('select * from LicenseAssociatedInformation where driversID = {0}'.format(driversID))
   #row_headers = [x[0] for x in cursor.description]
   #json_data = []
   #theData = cursor.fetchall()
   #print(theData)
   #for row in theData:
   #   print(row_headers)
   #   print(row)
   #   json_data.append(dict(zip(row_headers, row)))
   #the_response = make_response(jsonify(json_data))
   #the_response.status_code = 200
   #the_response.mimetype = 'application/json'
   #return the_response
   #return f'<h2>Testing the specific persona: {driversID} id.'

    
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
