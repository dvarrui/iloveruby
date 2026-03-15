#!/usr/bin/env bash

echo "==> Docker: Container begin"
echo "==> Docker: Installing gems..."
bundle install

echo "==> Docker: Installing requirements..."
cp temp/geckodriver /usr/local/bin
apt update -y
apt install -y firefox-esr

echo "==> Docker: Running script..."
ruby $1
echo "==> Docker: Container end"

