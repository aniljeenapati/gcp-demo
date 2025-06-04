# from werkzeug.urls import url_quote
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'App is Working'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
