#!/bin/bash

PIPE=/dockerpipe

# Create the named pipe if it doesn't exist
if [[ ! -p $PIPE ]]; then
    rm -f $PIPE # Remove any existing file or directory with the same name
    mkfifo $PIPE
fi

# Log the script activity
echo "$(date): Starting dockerpipe script" >> /tmp/dockerpipe.log

# Continuously read from the named pipe and evaluate commands
while true; do
    if read line < $PIPE; then
        echo "$(date): Received command: $line" >> /tmp/dockerpipe.log
        eval "$line"
    else
        echo "$(date): Read error: $? - $line" >> /tmp/dockerpipe.log
    fi
done
