# Base image
FROM python:3.12-alpine

# Use a non-root user 
RUN adduser -D gunicorn
USER gunicorn

# Set the working directory
WORKDIR /home/gunicorn/app
COPY --chown=gunicorn:gunicorn app.py requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --user -r requirements.txt

# Make port 5000 available for the app
EXPOSE 5000

# Add binary to the PATH env
ENV PATH="/home/gunicorn/.local/bin:${PATH}"

ENTRYPOINT ["gunicorn","--bind=0.0.0.0:5000","app:app","--access-logfile=-","--access-logformat", "{\"remote_ip\":\"%(h)s\",\"response_code\":\"%(s)s\",\"request_method\":\"%(m)s\",\"request_path\":\"%(U)s\",\"duration\":\"%(M)s\",\"response_length\":\"%(B)s\"}"]
