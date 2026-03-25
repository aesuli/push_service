FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

COPY . /app
RUN pip install --no-cache-dir /app

EXPOSE 8000
VOLUME ["/data"]

ENTRYPOINT ["push_service"]
CMD ["--host", "0.0.0.0", "--port", "8000", "--db_url", "sqlite:////data/channels.db", "--encryption_password_file", "/data/channel_db_encryption_password", "--log_dir", "/data/logs", "--otp_secret_file", "/data/otp_secret", "--admin_password_file", "/data/admin_password", "--show_home", "--enable_channel_creation", "webui"]