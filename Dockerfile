FROM python:3.9

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8081

CMD [ "python", "app.py" ]  # This command will run the app.py file when the container starts
