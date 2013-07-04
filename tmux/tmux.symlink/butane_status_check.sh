#!/bin/bash

status=$(/home/matt/butane/butane status)
if [[ $status =~ "no instances running" ]]; then
  echo 'butane is not running'
fi
