#!/bin/bash

# Set your OpenAI API key
API_KEY="YOUR_API_KEY"

# Prompt the user for input
read -p "You: " input

# Call the OpenAI API to generate a response
response=$(curl -s -X POST -H "Content-Type: application/json" \
    -H "Authorization: Bearer $API_KEY" \
    -d '{"model": "text-davinci-002", "prompt": "'"$input"'", "temperature": 0.5, "max_tokens": 100}' \
    https://api.openai.com/v1/completions)

# Extract the response text from the API response
output=$(echo $response | jq -r '.choices[].text')

# Print the response
echo "ChatGPT: $output"
