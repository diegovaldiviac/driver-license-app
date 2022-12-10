from flask import Blueprint, request, make_response, jsonify
import json
from src import db

clerks = Blueprint('clerks', __name__)


# the @app.route("/") connects the hello_word function to the URL / 
@clerks.route('/clerks', methods=['GET'])
def root_url():
    return "<h1>Welcome to the root of the clerks url!</h1>"



# This route will handle the user going to /users/<some_id>
@clerks.route("/clerks/<idNumber>")
def handle_user_with_id(idNumber):
    return f'<h2>Testing the speicific clerk: {idNumber} id.'
