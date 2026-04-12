#!/bin/bash
# Open Markdown file with mo in cmux browser
file="$1"

mo "$file"

surf=$(cmux identify | jq -r '.caller.surface_ref')
cmux browser "$surf" tab new "http://127.0.0.1:6275/"
