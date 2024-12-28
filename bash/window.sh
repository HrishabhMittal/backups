#!/usr/bin/env bash
COLUMNS=$(tput cols)
LINES=$(tput lines)
if [[ "$#" -lt 4 ]]; then
    echo "Usage: $0 x y width height [text]"
    exit 1
fi
x="$1"         
y="$2"         
width="$3"     
height="$4"    
text="${*:5}"  
if [[ "$x" -ge "$COLUMNS" || "$x" -lt "0" ]]; then exit; fi
if [[ "$y" -ge "$LINES" || "$y" -lt "0" ]]; then exit; fi
mapfile -t lines < <(echo "$text" | fold -sw "$((width - 2))")
if [[ "${#lines[@]}" -gt $((height - 2)) ]]; then
    echo "Error: Text exceeds the designated area height."
    exit 1
fi
tput cup "$y" "$x"
v="$(printf "+%*s+" $((width - 2)) | tr ' ' '-')"
echo "$v"
for ((i = 0; i < height - 2; i++)); do
    tput cup $((y + i + 1)) "$x"
    if [[ $i -lt ${#lines[@]} ]]; then
        line="${lines[i]}"
        printf "|%-*s|" $((width - 2)) "$line"
    else
        printf "|%*s|" $((width - 2)) ""
    fi
done
tput cup $((y + height - 1)) "$x"
echo "$v"
