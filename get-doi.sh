#!/bin/bash

url="https://hub.docker.com/v2/namespaces/library/repositories"
page=1
size=100

while true; do
    # Make the HTTP request and retrieve the JSON response
    response=$(curl -s "$url?page=$page&size=$size")

    # Check if there are results in the response
    if [[ $(echo "$response" | jq '.results | length') -eq 0 ]]; then
        break  # No more results, exit the loop
    fi

    # Process the results (you can modify this part based on your needs)
    names=($(echo "$response" | jq -r '.results[].name'))
    for name in "${names[@]}"; do
        echo "$name" >> doi.txt
    done

    # Increment the page for the next request
    ((page++))
done
