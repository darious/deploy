# Update all the docker containers to the latest version

# Pull all the latest images
docker compose pull

# Fire them all up
docker compose up -d

# Install ssh in the sonarr container so that the post processing script will work
docker exec -it sonarr apt install ssh -y

# grab the ssh key for the plex server so that we can connect
docker exec -it sonarr sh -c 'mkdir -p $HOME/.ssh'
docker exec -it sonarr sh -c 'ssh-keyscan 192.168.0.232 >> $HOME/.ssh/known_hosts'


# make radarr ssh work
docker exec -it radarr_all apk update
docker exec -it radarr_all apk --no-cache add openssh-client
#docker exec -it radarr_all sh -c 'ssh-keyscan 192.168.0.232 >> /config/.ssh/known_hosts'

# finally clean up anything left behind
docker system prune -af --volumes
