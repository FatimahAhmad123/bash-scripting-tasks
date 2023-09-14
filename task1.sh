#!/bin/bash

echo "Hello ${USER^}!"

echo "This script will enable you to backup files in your present working directory."

echo "Please enter the full path of the directory you want to backup."

read pathlocation

cd $pathlocation

tar -cf backup-on-$(date +%d-%m-%Y)-at-$(date +%I-%M_%p).tar $pathlocation
echo "Backup successfully completed."

exit 0