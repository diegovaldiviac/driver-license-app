

from src import create_app
from src import db
app = create_app()

# the @app.route("/") connects the hello_word function to the URL / 
@app.route("/")
def root_url():
    return "Welcome to the root url!"

if __name__ == '__main__': 
    app.run(debug = True, host = '0.0.0.0', port = 4000)
