FROM python:3.11-alpine

WORKDIR /usr/usr/app

COPY python/ .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD [ "python", "main.py" ]
