from flask import Blueprint, request, make_response, jsonify
import json
from src import db


persona = Blueprint('persona', __name__)


########
# POST ############################################################################
########
@persona.route('/apply/persona', methods=['POST'])
def apply_new_lisence():

   try:
      cur = db.get_db().cursor()
      f = request.form.get('firstName')
      m = request.form.get('middleName')
      l = request.form.get('lastName')
      e = request.form.get('email')
      s = request.form.get('state')
      z = request.form.get('zipCode')
      cur.execute(f"""
      INSERT INTO 
      `Person` (
         firstName,
         middleName,
         lastName,
         email,
         state,
         zipCode,
         driversID)
      VALUES (%s,%s,%s,%s,%s,%s,%s)""", (f,m,l,e,s,z, 3000))
      cur.connection.commit()
      
      return "<h1>Submitted!</h1>"
   except Exception as e:
      print(e)

      return "<h1>Error</h1>"
   

@persona.route('/renew/email/<driversID>', methods=['POST'])
def update_email(driversID):

   # request.form to get form parameter
   if request.method == 'POST':
      email = format(request.form.get('email'))
      cur = db.get_db().cursor()
      query = f'update `Person` set email = "{email}" where driversID = {0}'.format(driversID)
      cur.execute(query)
      cur.connection.commit()
      return "<h1>Submitted!</h1>"


@persona.route('/renew/misc/<driversID>', methods=['POST'])
def update_misc(driversID):   

   try:
      # request.form to get form parameter
      if request.method == 'POST':
         organDonor = request.form.get('organ')
         veteran = request.form.get('veteran')
         cur = db.get_db().cursor()
         query = f'update `Misc` set organDonor = "{organDonor}", veteran = "{veteran}" where driversID = {0}'.format(driversID)
         cur.execute(query)
         cur.connection.commit()

      return "<h1>Submitted!</h1>"
   except Exception as e:
      return "<h1>Error</h1>"



#######
# GET #######################################################################################
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
