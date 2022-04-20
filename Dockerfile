FROM debian:stretch-slim

WORKDIR /usr/src/app
ENV TZ Europe/Berlin

RUN apt update && apt -y dist-upgrade
RUN apt -y install build-essential libssl-dev libffi-dev python3.5 libblas3 libc6 liblapack3 gcc python3-dev python3-pip cython3

COPY requirements.txt ./

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python3", "./app.py" ]