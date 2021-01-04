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

if ! ["$INPUT_SERVER_ID"] 
    then
        $INPUT_SERVER_ID = "JFrog Artifactory Server"
fi

if ["$INPUT_SERVER_URL" && "$INPUT_ACCESS_TYPE" && (("$INPUT_USERNAME" && "$INPUT_PASSWORD") || "$INPUT_ACCESS_TOKEN")] 
then
    if ["$INPUT_ACCESS_TYPE" == 'username-password']
    then 
       sh -c "jfrog rt c $INPUT_SERVER_ID --interactive=false --basic-auth-only=true --url=$INPUT_SERVER_URL --user=$INPUT_USERNAME --password=$INPUT_PASSWORD"
#     elif [$INPUT_ACCESS_TYPE == 'api-key']
#     then
#         jfrog rt c "$INPUT_SERVER_ID" --interactive=false --basic-auth-only=true --url="$INPUT_SERVER_URL" --apikey="$INPUT_API_KEY"
    elif ["$INPUT_ACCESS_TYPE" == 'access-token']
    then 
       sh -c "jfrog rt c $INPUT_SERVER_ID --interactive=false --basic-auth-only=true --url=$INPUT_SERVER_URL --access-token=$INPUT_API_KEY"
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
