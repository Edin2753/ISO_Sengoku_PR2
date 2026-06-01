from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)

DB_CONFIG = {
    "host": os.getenv("DB_HOST", "db"),
    "database": os.getenv("DB_NAME", "sengoku"),
    "user": os.getenv("DB_USER", "postgres"),
    "password": os.getenv("DB_PASSWORD", "postgres"),
    "port": 5432
}

def get_db_connection():
    """Create a new database connection"""
    return psycopg2.connect(**DB_CONFIG)

@app.route("/")
def index():
    return jsonify({
        "status": "backend running",
        "database": "PostgreSQL connected"
    })

@app.route("/clan/<name>")
def clan_page(name):
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute("""
            SELECT name, leader, region, description, str1, str2, str3, legacy, image 
            FROM clans 
            WHERE LOWER(name) LIKE LOWER(%s)
            LIMIT 1
        """, (f"%{name}%",))

        row = cur.fetchone()

        if row is None:
            return jsonify({"error": "Clan not found"}), 404

        clan = {
            "name": row[0],
            "leader": row[1],
            "region": row[2],
            "description": row[3],
            "str1": row[4],
            "str2": row[5],
            "str3": row[6],
            "legacy": row[7],
            "image": row[8]
        }

        cur.close()
        conn.close()

        return jsonify(clan)

    except psycopg2.Error as db_error:
        print("Database error:", db_error)
        return jsonify({"error": "Database connection failed"}), 500
    except Exception as e:
        print("Unexpected error:", e)
        return jsonify({"error": "Internal server error"}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)