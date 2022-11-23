from flask import Blueprint
from flask import request

persona_blueprint = Blueprint('/persona_blueprint', __name__)

@persona_blueprint.route('/persona')
def get_persona():
    return f'<h1> TESTING. </h1>'
    
@persona_blueprint.route('/persona')
def post_test():
    return ''

"""
@app.route("/form", methods = ['POST'])
def post_form():
   first_name = request.form['first']
   last_name = request.form['last']
   return f'<h1>Hello {first_name} {last_name}.</h1>

"""