#!/bin/sh -e

# rs-enable-array.sh <array> 

[ ! "$1" ] && echo 'No array ID provided.' && exit 1

. "$HOME/.rightscale/rs_api_config.sh"
. "$HOME/.rightscale/rs_api_creds.sh"

url="https://my.rightscale.com/api/acct/$rs_api_account_id/server_arrays/$1"

#curl -w "Result %{response_code}\n" -b <./mySavedCookies> -X PUT -H 'X-API-VERSION:1.0' 
#-d 'server_array[active]=true' "https://my.rightscale.com/api/acct/1/server_arrays/1234"

echo "PUT: $url"
api_result=$(curl -s -H "X_API_VERSION: $rs_api_version" -X PUT -b "$rs_api_cookie" \
   -d 'server_array[active]=true' "$url")

echo "$api_result"

