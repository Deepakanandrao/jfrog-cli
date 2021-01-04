#!/bin/sh

#Starting shell scripts with set -e is considered a best practice,
#since it is usually safer to abort the script if some error occurs. 
#If a command may fail harmlessly,

set -e


# $INPUT_SERVER_ID:

# $INPUT_SERVER_URL:

# $INPUT_DISTRIBUTION_URL:

# $INPUT_ACCESS_TYPE:

# $INPUT_USERNAME:

# $INPUT_PASSWORD:

# $INPUT_ACCESS_TOKEN:

# $INPUT_API_KEY:

# $INPUT_CLI_CMD:
   

# sudo apt install -y jfrog-cli
if ! [$server_id]
    then
        $server_id = "JFrog Artifactory Server"
fi

if [$server_url && $access_type && (($username && $password) || $access_token)] 
then
    if [$access_type = 'username-password']
    then 
       sh -c "jfrog rt c $server_id --interactive=false --basic-auth-only=true --url=$server_url --user=$username --password=$password"
     elif [$access_type == 'api-key']
     then
       sh -c "jfrog rt c $server_id --interactive=false --basic-auth-only=true --url=$server_url --apikey=$api_key"
    elif [$access_type = 'access-token']
    then 
       sh -c "jfrog rt c $server_id --interactive=false --basic-auth-only=true --url=$server_url --access-token=$api_key"
    fi
else
    echo "Please enter required parameters"
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
