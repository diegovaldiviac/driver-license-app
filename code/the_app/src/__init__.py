# import the Flask framework
from flask import Flask, jsonify
from flaskext.mysql import MySQL

# create a MySQL object that we will use in other parts of the API
db = MySQL()

def create_app():
    # create a flask object
    app = Flask(__name__)

    # add  db config variables to the pp object
    app.config['MYSQL_DATABASE_HOST'] = 'db'
    app.config['MYSQL_DATABASE_PORT'] = 3306
    app.config['MYSQL_DATABASE_USER'] = 'webapp'
    app.config['MYSQL_DATABASE_PASSWORD'] = 'iker123'
    app.config['MYSQL_DATABASE_DB'] = 'dlars_db'


    db.init_app(app)

    from src.clerks_api.clerks import clerks
    from src.persona_api.persona import persona

    # Register blueprints with flask app object.
    app.register_blueprint(clerks, url_prefix='/clerks')
    app.register_blueprint(persona, url_prefix='/persona')

    return app