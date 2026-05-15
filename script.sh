#!/bin/bash

#declare variable
Name="kaushal"
date=$(date +%Y-%m-%d)

# read user input
echo "Enter your favourite color"
read COLOR

#Use the variable
echo "Hello $Name!"
echo "today is date: $date"
echo "your favourite color is: $COLOR"
echo "you are logged in as: $USER"
echo "your home directory is $HOME"

