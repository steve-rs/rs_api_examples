#!/bin/bash -e

# rs-terminate-all-array.sh <array_id>

. "$HOME/.rightscale/rs_api_config.sh"
. "$HOME/.rightscale/rs_api_creds.sh"

[[ ! $1 ]] && echo 'No array ID provided, exiting.' && exit 1
array_id="$1"

#POST /api/acct/1/server_arrays/1/terminate_all

terminate_all_array() {
	url="https://my.rightscale.com/api/acct/"$rs_api_account_id"/server_arrays/"$array_id"/terminate_all"
	echo "POST: $url"
    terminate_all_result=$(curl -d api_version="$rs_api_version" -b "$rs_api_cookie" -X POST -sL -w "\\n%{http_code} %{url_effective}" "$url")
	terminate_all_code=$(tail -n1 <<< "$terminate_all_result" | awk '{print $1}')
	if [ ! "$terminate_all_code" = "201" ]; then
		echo "response: $terminate_all_result"
		echo 'Failed to stop array.'
		exit 1
	fi
}

# terminate the array
terminate_all_array

