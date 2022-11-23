from flask import Blueprint

clerks_blueprint = Blueprint('/clerks_blueprint', __name__)

@clerks_blueprint.route('/clerks')
def get_all_clerks():
    return f'<h1> TESTING. </h1>'
