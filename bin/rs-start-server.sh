#!/bin/bash -e

# rs-start-server.sh <server_id>

. "$HOME/.rightscale/rs_api_config.sh"
. "$HOME/.rightscale/rs_api_creds.sh"

[[ ! $1 ]] && echo 'No server ID provided, exiting.' && exit 1
server_id="$1"

start_server() {
	url="https://my.rightscale.com/api/acct/"$rs_api_account_id"/servers/"$server_id"/start"
	echo "GET: $url"
    start_result=$(curl -d api_version="$rs_api_version" -b "$rs_api_cookie" -sL -w "\\n%{http_code} %{url_effective}" "$url")
	start_code=$(tail -n1 <<< $start_result | awk '{print $1}')
	if [[ "$start_result" = *denied* ]] || [ ! "$start_code" = "201" ]; then
		echo "response: $start_result"
		echo 'Failed to start server.'
		exit 1
	fi
}

# start the server
start_server
