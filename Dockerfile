# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.10-slim

EXPOSE 8000

# Install Tesseract dependencies
RUN apt-get update

RUN apt-get install g++ gcc make curl wget -y
RUN apt-get install autoconf automake libtool -y
RUN apt-get install pkg-config -y
RUN apt-get install libpng-dev -y
# RUN apt-get install libjpeg8-dev -y
RUN apt-get install libtiff5-dev -y
RUN apt-get install zlib1g-dev -y
RUN apt-get install libwebpdemux2 libwebp-dev -y
RUN apt-get install libopenjp2-7-dev -y
RUN apt-get install libgif-dev -y
RUN apt-get install libarchive-dev libcurl4-openssl-dev -y

RUN apt-get install libicu-dev -y
RUN apt-get install libpango1.0-dev -y
RUN apt-get install libcairo2-dev -y

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
COPY requirements.txt .
RUN python -m pip install -r requirements.txt

WORKDIR /app
COPY . /app

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "-k", "uvicorn.workers.UvicornWorker", "run:app"]
