
# import the Flask framework
from flask import Flask, jsonify
from flasketx.mysql import MySQL

# import blueprints
from clerks_api.clerks import clerks_blueprint
from persona_api.persona import persona_blueprint


# create a flask object
app = Flask(__name__)

# add  db config variables to the pp object
app.config['MYSQL_DATABASE_HOST'] = 'db'
app.config['MYSQL_DATABASE_PORT'] = 3306
app.config['MYSQL_DATABASE_USER'] = 'webapp'
app.config['MYSQL_DATABASE_PASSWORD'] = 'iker123'
app.config['MYSQL_DATABASE_DB'] = 'dlars_db'


# Create mysql object and connect it to flask app object
db_connection = MySQL()
db_connection.init_app(app)


# Register blueprints with flask app object.
app.register_blueprint(clerks_blueprint, url_prefix='/clrk')
app.register_blueprint(persona_blueprint, url_prefix='/pers')

# the @app.route("/") connects the hello_word function to the URL / 
@app.route("/")
def hello_world():
    return "I am a function appended to the root url!"

# this route will handle the user going to /bigHello
# It returns a different string and with the H1 html tag
@app.route("/bigHello")
def big_hello_world():
    return "<h1>A Big Hello to you!!!!</h1>"

# This route will handle the user going to /users/<some_id>
@app.route("/clrk/<idNumber>")
def handle_user_with_id(idNumber):
    return f'<h2>You asked for {idNumber} id.'


# If this file is being run directly, then run the application 
# via the app object. 
# debug = True will provide helpful debugging information and 
#   allow hot reloading of the source code as you make edits and 
#   save the files. 
# 
if __name__ == '__main__': 
    app.run(debug = True, host = '0.0.0.0', port = 4000)
