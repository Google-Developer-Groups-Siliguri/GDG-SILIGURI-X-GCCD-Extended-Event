from cerberus import Validator
from flask import Flask, request, jsonify

app = Flask(__name__)

ADD_NUMBERS_SCHEMA = {
    'num1': {'type': 'number', 'required': True},
    'num2': {'type': 'number', 'required': True}
}


@app.route('/')
def hello_world():
    return 'Hello, World!'


@app.route('/add', methods=['POST'])
def add_numbers():
    # Get the JSON data from the request
    data = request.get_json()

    # Validate that data contains num1 and num2 and they are numbers
    validator = Validator(ADD_NUMBERS_SCHEMA)
    if not validator.validate(data):
        return jsonify({'error': validator.errors}), 400

    # Perform the addition
    num1 = data['num1']
    num2 = data['num2']
    result = num1 + num2

    return jsonify({'result': result})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
