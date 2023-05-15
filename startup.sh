#!/bin/bash

set -x
set -e

echo "Preparing container..."

echo "DISABLE_AUDIO_CACHE=$DISABLE_AUDIO_CACHE"
echo "SPOTIFY_NAME=$SPOTIFY_NAME"
echo "BACKEND_NAME=$BACKEND_NAME"
echo "DEVICE_NAME=$DEVICE_NAME"
echo "INITIAL_VOLUME=$INITIAL_VOLUME"

DEVICE=""
BACKEND=""
VERB=""
INIT_VOL=""
DISABLE_ACACHE=""

if [ "$DISABLE_AUDIO_CACHE" == "true" ]; then
  DISABLE_ACACHE="--disable-audio-cache"
fi

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

if [ "$INITIAL_VOLUME" != "" ]; then
  INIT_VOL="--initial-volume $INITIAL_VOLUME"
fi

echo "/etc/asound.conf"
cat /etc/asound.conf
echo ''

if [ "$EQUALIZATION" != "" ]; then
  echo "Applying equalization $EQUALIZATION"
  /equalizer.sh "$EQUALIZATION"
fi

set +e
if [ "$ALSA_SOUND_LEVEL" != "" ]; then
  echo "Applying sound level to $ALSA_SOUND_LEVEL"
  #TODO: enhance this logic
  amixer cset numid=1 "$ALSA_SOUND_LEVEL"
  amixer cset numid=2 "$ALSA_SOUND_LEVEL"
  amixer cset numid=3 "$ALSA_SOUND_LEVEL"
  amixer cset numid=4 "$ALSA_SOUND_LEVEL"
  amixer cset numid=5 "$ALSA_SOUND_LEVEL"
  amixer cset numid=6 "$ALSA_SOUND_LEVEL"
  amixer cset numid=7 "$ALSA_SOUND_LEVEL"
  amixer cset numid=8 "$ALSA_SOUND_LEVEL"
fi
set -e

echo "Starting Raspotify..."
librespot $VERB --name "$SPOTIFY_NAME" $BACKEND $DEVICE --bitrate 320 $DISABLE_ACACHE --enable-volume-normalisation $INIT_VOL

