from flask import Blueprint

clerks_blueprint = Blueprint('/clerks_blueprint', __name__)


# the @app.route("/") connects the hello_word function to the URL / 
@clerks_blueprint.route('/')
def root_url():
    return "<h1>Welcome to the root of the clerks url!</h1>"


@clerks_blueprint.route('/clerks')
def get_all_clerks():
    return f'<h1> Chupala Mateo. </h1>'


# This route will handle the user going to /users/<some_id>
@clerks_blueprint.route("/clerks/<idNumber>")
def handle_user_with_id(idNumber):
    return f'<h2>A Mateo le gusta: {idNumber} id.'
