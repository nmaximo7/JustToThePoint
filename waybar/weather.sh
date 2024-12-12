#!/bin/bash

weather=$(curl -s "wttr.in/Málaga?format=%c+%t")
echo "$weather"
