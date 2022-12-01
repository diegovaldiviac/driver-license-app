
# import the Flask framework
from flask import Flask, jsonify
from flaskext.mysql import MySQL

# import blueprints
from clerks_api.clerks import clerks_blueprint
from persona_api.persona import persona_blueprint


# create a flask object
app = Flask(__name__)

# Register blueprints with flask app object.
app.register_blueprint(clerks_blueprint, url_prefix='/clrk')
app.register_blueprint(persona_blueprint, url_prefix='/pers')


# add  db config variables to the pp object
app.config['MYSQL_DATABASE_HOST'] = 'db'
app.config['MYSQL_DATABASE_PORT'] = 3306
app.config['MYSQL_DATABASE_USER'] = 'webapp'
app.config['MYSQL_DATABASE_PASSWORD'] = 'iker123'
app.config['MYSQL_DATABASE_DB'] = 'dlars_db'


# Create mysql object and connect it to flask app object
db_connection = MySQL()
db_connection.init_app(app)



# the @app.route("/") connects the hello_word function to the URL / 
@app.route("/")
def root_url():
    return "Welcome to the root url!"


@app.route('/db_test')
def db_testing():
   cur = db_connection.get_db().cursor()
   cur.execute('select * from PERSON')
   row_headers = [x[0] for x in cur.description]
   json_data = []
   theData = cur.fetchall()
   for row in theData:
       json_data.append(dict(zip(row_headers, row)))
   return jsonify(json_data)


# If this file is being run directly, then run the application 
# via the app object. 
# debug = True will provide helpful debugging information and 
#   allow hot reloading of the source code as you make edits and 
#   save the files. 
# 
if __name__ == '__main__': 
    app.run(debug = True, host = '0.0.0.0', port = 4000)
