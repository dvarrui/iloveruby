#!/usr/bin/env bash

echo "==> setup: Installing geckodriver..."

GECKO_VERSION="v0.31.0"
TARFILE=geckodriver-$GECKO_VERSION-linux64.tar.gz
TEMP=temp
mkdir $TEMP
wget https://github.com/mozilla/geckodriver/releases/download/$GECKO_VERSION/$TARFILE
mv $TARFILE $TEMP
tar xvfz $TEMP/$TARFILE -C $TEMP

