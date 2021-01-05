#!/bin/sh
set -e

if ["$ACCESS_TYPE" = "username-password"]
then 
    sh -c 'jfrog rt c "$SERVER_ID" --interactive=false --basic-auth-only=true --url="$SERVER_URL" --user="$USERNAME" --password="$PASSWORD"'
fi
if ["$ACCESS_TYPE" == "api-key"];
then
       sh -c 'jfrog rt c "$SERVER_ID" --interactive=false --basic-auth-only=true --url="$SERVER_URL" --apikey="$API_KEY"'
fi
if ["$access_type" = "access-token"]
then 
       sh -c 'jfrog rt c "$SERVER_ID" --interactive=false --basic-auth-only=true --url="$SERVER_URL" --access-token="$API_KEY"'
fi
    
for cmd in "$@"; do
    echo "Running: '$cmd'"
    if sh -c "$cmd"; then
        echo "Success!"
    else
        exit_code=$?
        echo "Failure: '$cmd' exited with $exit_code"
        exit $exit_code
    fi
done
