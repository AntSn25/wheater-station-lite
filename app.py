from flask import Flask
import temp_bme280

app = Flask(__name__)

bme280 = temp_bme280.Temp_bme280()

@app.route('/metrics')
def metrics():
    data = bme280.get_data()
    return "temperature {}\nhumidity {}\npressure {}".format(str(data.temperature), str(data.humidity), str(data.pressure))

if __name__ == '__main__':
    app.run(host='0.0.0.0')
