FROM python:3.9-slim

# Créer le dossier de travail et installer les dépendances
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le contenu de l'application
COPY service/ ./service/

# Passer à un utilisateur non-root
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Exécuter le service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]