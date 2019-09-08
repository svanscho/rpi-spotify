#!/bin/bash

set -x
set -e

echo "Preparing container..."

echo "SPOTIFY_NAME=$SPOTIFY_NAME"
echo "BACKEND_NAME=$BACKEND_NAME"
echo "DEVICE_NAME=$DEVICE_NAME"

DEVICE=""
BACKEND=""
VERB=""

if [ "$VERBOSE" == "true" ]; then
  VERB="-v"
fi

if [ "$BACKEND_NAME" != "" ]; then
  BACKEND="--backend $BACKEND_NAME"
fi

if [ "$DEVICE_NAME" != "" ]; then
  DEVICE="--device $DEVICE_NAME"
fi

if [ "$DEVICE_NAME" == "equal" ]; then
  if [ "$ALSA_SLAVE_PCM" == "" ]; then
    echo "ALSA_SLAVE_PCM must be defined. eg. use 'plughw:0,0' for device at card 0, sub 0"
    exit 1
  fi
fi

echo "/etc/asound.conf"
envsubst < /etc/asound.conf > /etc/asound.conf
echo /etc/asound.conf
echo ''

if [ "$EQUALIZATION" != "" ]; then
  echo "Applying equalization $EQUALIZATION"
  /equalizer.sh "$EQUALIZATION"
fi

echo "Starting Raspotify..."
/usr/bin/librespot $VERB --name "$SPOTIFY_NAME" $BACKEND $DEVICE --bitrate 320 --disable-audio-cache --enable-volume-normalisation

