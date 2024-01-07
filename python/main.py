from flask import Flask, render_template

import os
import socket

app = Flask(__name__)

def fetchEnv():
    hostname = socket.gethostname()
    host_ip = socket.gethostbyname(hostname)
    link = os.environ.get("LINK")
    password = os.environ.get("PASSWORD")

    return str(hostname), str(host_ip), str(link), str(password)

@app.route("/")
def details():
    hostname, ip, link, password = fetchEnv()
    return render_template(
        'index.html',
        HOSTNAME=hostname,
        IP=ip,
        LINK=link,
        PASSWORD=password,
    )

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)