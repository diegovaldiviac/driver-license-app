
# import the Flask framework
from flask import Flask

# create a flask object
app = Flask(__name__)

# Create a function named hello world that 
# returns a simple html string 
# the @app.route("/") connects the hello_word function to 
# the URL / 
@app.route("/")
def hello_world():
    return "Hello, World!"

# this route will handle the user going to /bigHello
# It returns a different string and with the H1 html tag
@app.route("/bigHello")
def big_hello_world():
    return "<h1>A Big Hello to you!!!!</h1>"

# This route will handle the user going to /users/<some_id>
@app.route("/users/<idNumber>")
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