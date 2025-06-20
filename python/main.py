from flask import Flask, request, jsonify
import redis
import psycopg2
import os

app = Flask(__name__)

# Redis connection
redis_host = os.getenv("REDIS_HOST", "localhost")
r = redis.Redis(host=redis_host, port=6379, decode_responses=True)

# PostgreSQL connection
db_conn = psycopg2.connect(
    dbname=os.getenv("POSTGRES_DB"),
    user=os.getenv("POSTGRES_USER"),
    password=os.getenv("POSTGRES_PASSWORD"),
    host="db",  # matches service name in docker-compose
    port=5432
)
cursor = db_conn.cursor()

# Create table if not exists
cursor.execute("""
    CREATE TABLE IF NOT EXISTS greetings (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL
    );
""")
db_conn.commit()

@app.route("/")
def index():
    count = r.incr("hits")
    return f"Hello! You've visited {count} times."

@app.route("/greet", methods=["GET"])
def greet():
    name = request.args.get("name", "World")
    cursor.execute("INSERT INTO greetings (name) VALUES (%s);", (name,))
    db_conn.commit()
    return jsonify({"message": f"Hello, {name}!"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
