FROM python:3
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN apt-get update && apt-get install -y python3-venv
COPY . .
RUN python3 -m venv venv
ENV PATH="venv/bin:$PATH"
RUN pip install --no-cache-dir django==3.2
RUN venv/bin/python3 manage.py migrate
CMD ["venv/bin/python3", "manage.py", "runserver", "0.0.0.0:8000"]
