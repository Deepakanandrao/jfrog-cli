#!/bin/sh
set -e


if [$access_type = "username-password"];
then 
    sh -c "jfrog rt c $server_id --interactive=false --basic-auth-only=true --url=$server_url --user=$username --password=$password"
fi
if [$access_type == 'api-key'];
     then
       sh -c "jfrog rt c $server_id --interactive=false --basic-auth-only=true --url=$server_url --apikey=$api_key"
fi
if [$access_type = 'access-token'];
    then 
       sh -c "jfrog rt c $server_id --interactive=false --basic-auth-only=true --url=$server_url --access-token=$api_key"
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
