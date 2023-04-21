#!/bin/bash
while read -r PROMPT; do
    OUT=$(curl -s https://api.openai.com/v1/completions -H "Content-Type: application/json" -H "Authorization: Bearer SEU-TOKEN-AQUI" -d "{\"model\": \"text-davinci-003\", \"prompt\": \"${PROMPT}\", \"temperature\": 1, \"max_tokens\": 500}" | python -c "import sys, json; print(json.load(sys.stdin)['choices'][0]['text'].strip())" | sed 's/^[^A-Za-z]*//' | sed -e 's/^[ \t]*//' -e 's/[ \t]*$//')
    echo ""
    echo -e "\033[0;32m${OUT}\033[0m"
    echo ""
done