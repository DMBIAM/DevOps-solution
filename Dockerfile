# Etapa de construcción
FROM python:3.11.3 AS builder

# Custom label
LABEL autor="David Martinez B"
LABEL version=1.0

# ARG 
ARG PORT=8000
ARG USER=hulk
ARG REPO=https://bitbucket.org/devsu/demo-devops-python.git

# ENV
ENV APP_ADDRESS_PORT 0.0.0.0:8000

# Install git for clone repo
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean

# Add new user  
RUN useradd -m $USER

# Install pylint and coverage
RUN pip install --no-input pylint coverage pytest bandit

# SET /app default dir
WORKDIR /app

# Clone the repository where the code is located
RUN git clone $REPO .

# Install dependencies.
RUN pip3 install --no-cache-dir -r requirements.txt

# Migrate database
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate

# Expose port for app
EXPOSE $PORT

# Change the owner of the working directory to the $USER
RUN chown -R $USER:$USER /app

# Set the appropriate permissions for the $USER
RUN chmod -R 755 /app

# Switch to the $USER to run the application
USER $USER

# Healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl --fail http://localhost:$PORT/ || exit 1

# Run project
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]