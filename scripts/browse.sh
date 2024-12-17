#!/usr/bin/env bash

# ______  _______ _______         _______ _______ 
#(  ___ \(  ____ |  ___  )\     /(  ____ (  ____ \
#| (   ) ) (    )| (   ) | )   ( | (    \/ (    \/
#| (__/ /| (____)| |   | | | _ | | (_____| (__    
#|  __ ( |     __) |   | | |( )| (_____  )  __)   
#| (  \ \| (\ (  | |   | | || || |     ) | (      
#| )___) ) ) \ \_| (___) | () () /\____) | (____/\
#|/ \___/|/   \__(_______|_______)_______|_______/
#                                              

MY_BROWSER="firefox"

# Dictionary of directions
declare -A directions=(
    ["perplexity"]="https://www.perplexity.ai/"
    ["google"]="https://www.google.com/"
    ["copilot"]="https://copilot.microsoft.com/"
    ["gemini"]="https://gemini.google.com/"
    ["qwen"]="https://huggingface.co/spaces/Qwen/Qwen2.5-Coder-demo"
    ["claude"]="https://claude.ai/new"
    ["poe"]="https://poe.com/"
    ["notdiamond"]="https://chat.notdiamond.ai/"
    ["bankinter"]="https://www.bankinter.com/banca/en/home"    
)

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Please provide a direction argument: perplexity, google, copilot, gemini, qwen, claude, poe, notdiamond, bankinter"
    exit 1
fi

# Get the direction from the argument
direction=${1,,}  # Convert to lowercase

echo ${directions[$direction]}

# Check if the direction exists in the dictionary
if [ -n "${directions[$direction]}" ]; then
    # Open the browser with the specified URL
    $MY_BROWSER "--new-tab" ${directions[$direction]}
else
    echo "Invalid direction. Available options are: ${!directions[@]}"
    exit 1
fi

