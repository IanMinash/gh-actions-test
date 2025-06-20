from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route("/")
def home():
    return "Hello from Flask!"


@app.route("/greet", methods=["GET"])
def greet():
    name = request.args.get("name", "World")
    return jsonify({"message": f"Hello, {name}!"})


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
