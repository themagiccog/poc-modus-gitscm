from flask import Flask, render_template, request, redirect, url_for
import os
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)

app = Flask(__name__)

todos = []

# Access the CUSTOM_MESSAGE environment variable
custom_message = os.getenv("CUSTOM_MESSAGE", "No custom message set.")
deploy_env = os.getenv("DEPLOY_ENV", "No deploy env set.")

logging.info(
    f"Starting Flask app with CUSTOM_MESSAGE='{custom_message}' "
    f"and DEPLOY_ENV='{deploy_env}'"
)


@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        todo = request.form.get("todo")
        if todo:
            todos.append(todo)
            logging.info(f"Added TODO: '{todo}' | Total Todos: {len(todos)}")
        else:
            logging.warning("Received empty TODO. Ignored.")
    return render_template(
        "index.html",
        todos=todos,
        custom_message=custom_message,
        deploy_env=deploy_env
    )


@app.route("/delete/<int:idx>")
def delete(idx):
    if 0 <= idx < len(todos):
        removed = todos.pop(idx)
        logging.info(f"Deleted TODO at index {idx}: '{removed}' | Total Todos: {len(todos)}")
    else:
        logging.warning(f"Attempted to delete invalid index: {idx}")
    return redirect(url_for('index'))


if __name__ == "__main__":
    logging.info("Running Flask app on http://0.0.0.0:5000")
    app.run(host="0.0.0.0", port=5000)
