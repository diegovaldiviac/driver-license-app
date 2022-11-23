from flask import Blueprint

persona_blueprint = Blueprint('/persona_blueprint', __name__)

@persona_blueprint.route('/persona')
def get_persona():
    return f'<h1> TESTING. </h1>'
    
@persona_blueprint.route('/persona')
def post_test():
    return ''
