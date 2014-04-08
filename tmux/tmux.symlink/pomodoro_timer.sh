#!/bin/bash

minute=$(date +"%M")
past_the_half_hour=$(($minute % 30))
if [ "$past_the_half_hour" -ge 25 ]; then
  echo 'breaktime!'
fi
