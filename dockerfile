# Dockerfile
FROM python:3.9

# Install OpenSSH server and create required directories
RUN apt-get update && \
    apt-get install -y openssh-server && \
    mkdir /run/sshd

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app/

# SSH daemon runs on port 22
EXPOSE 22

# Start the SSH server
CMD ["/usr/sbin/sshd", "-D"]