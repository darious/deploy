# Update all the docker containers to the latest version

# Pull all the latest images
docker compose pull

# Fire them all up
docker compose up -d

# finally clean up anything left behind
docker system prune -af --volumes
