#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Migrate database changes
echo "Running database migrations..."
python manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Start the application
echo "Starting Gunicorn server..."
exec gunicorn mysite.wsgi:application --bind 0.0.0.0:$PORT --workers 3
