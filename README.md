# wheater-station-lite
## Beschreibung
Leichtgewichtige Anwendung, die Temperaturdaten unter /metrics herausgibt, die von einem Sensor (bme280) abgegriffen worden sind.

## Inbetriebnahme
### Benötigte Abhängigkeiten
Folgende Software-Komponenten müssen installiert sein:
* Docker (https://get.docker.com)

Folgende Hardware-Komponenten werden benötigt:
* Raspberry Pi (beliebiges Modell, wichtig ist der Header/Pins)
* BME280 Sensor
* Jumper-Kabel

### Installation
#### Hardware
Auf dem eingerichteten Raspberry Pi muss die I2C-Schnittstelle aktiviert werden. Die Jumper-Kabel werden an den Sensor gelötet, sodass ein Abstand zwischen Sensor und Raspberry Pi besteht. Das verhindert fehlerhafte Ergebnisse aufgrund der Abwärme. Die Verbindung zwischen dem Pi und dem Sensor sieht folgendermaßen aus:

| RPi Pin       | RPi Bedeutung  | Sensor |
|:-------------:|:--------------:|:------:|
| PIN 1         | 3.3V           | VCC    |
| PIN 6         | GND            | GND    |
| PIN 5         | GPIO3 (SCL I2C)| SCL    |
| PIN 3         | GPIO2 (SDA I2C)| SDA    |

#### Software
Zuvor muss weitere Software installiert werden, um den Sensor in Betrieb nehmen zu können. Nach der Installation sollte der BME-280 Sensor korrekt erkannt werden. Folgende Befehle müssen dafür ausgeführt werden:
```
sudo apt install i2c-tools
&& i2cdetect -y 1
```
Die Ausgabe sollte bei erfolgreicher Einrichtung des Sensors so aussehen:
```
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- 76 -- 
```

Zur Installation muss dieses Repository in ein Verzeichnis beliebiger Wahl geklont werden. Anschließend muss das Skript "build_and_run.sh" ausgeführt werden. Zuvor müssen die Ausführungsrechte gesetzt werden wenn nicht schon erfolgt. Dafür kann folgender Befehl verwendet werden:
```
chmod +x build_and_run.sh
```

### Ausführen bei Systemstart
Soll die Wetterstation beim Hochfahren des Raspberry Pis gestartet werden, so kann dafür ein Cronjob eingerichtet werden. Dafür wird die Datei /etc/crontab um folgende Zeile erweitert:
```
@reboot root /beliebiges/verzeichnis/run_wheater_station.sh
```

Der Inhalt des Skripts ist wie folgt:
```
#!/bin/bash
sudo docker run -d --rm --name wheater-container-lite --device /dev/i2c-1 -p 80:5000 wheater-station-lite
```