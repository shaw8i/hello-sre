from flask import Flask,request
from prometheus_flask_exporter import PrometheusMetrics
import os

messsage = os.environ.get("MESSAGE", "Hello, SRE!")
defaultMetrics= os.environ.get("ENABLE_DEFAULT_METRICS",False)

app = Flask(__name__)

metrics = PrometheusMetrics(app,export_defaults=defaultMetrics)
path_counter = metrics.counter(
    'path_counter_total', 'Request count by request paths',
    labels={'path': lambda: request.path}
)

@app.route('/', methods=['GET'])
@path_counter
def info():
    return messsage

if __name__ == '__main__':
    app.run()

    