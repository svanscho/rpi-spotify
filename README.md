This container runs a headless [Spotify](https://www.spotify.com/us/) player that can be remote-controlled by any Spotify app. Audio is output to /dev/snd, so you need to make sure the docker container has access to it (see examples). This allows the host system to play back the audio using [alsa](http://www.alsa-project.org/), [pulseaudio](http://pulseaudio.org), [forked-daapd](https://ejurgensen.github.io/forked-daapd/) (to Airplay), [snapserver](https://github.com/badaix/snapcast), etc.

This requires a Spotify premium account, but does not require a Spotify developer key or libspotify binary.

The process run is [librespot](https://github.com/plietar/librespot), an open source client library for Spotify.
This docker container image leverages the work from [David Cooper](https://dtcooper.github.io/raspotify).

[Dockerhub](https://hub.docker.com/r/svanscho/rpi-spotify/): [![](https://images.microbadger.com/badges/version/svanscho/rpi-spotify.svg)](https://microbadger.com/images/svanscho/rpi-spotify "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/svanscho/rpi-spotify.svg)](https://microbadger.com/images/svanscho/rpi-spotify "Get your own image badge on microbadger.com") 

## Prerequisites

* A Raspberry Pi (tested on RPi2/3)
* Docker
* docker-compose

## Usage

* Create file docker-compose.yml

```yml
version: "3.3"
services:
  rpi-spotify:
    image: flaviostutz/rpi-spotify
    network_mode: host
    restart: always
    devices:
      - /dev/snd:/dev/snd
    environment:
      - SPOTIFY_NAME=MyHouse
```

* Run ```docker-compose up -d```

* Open Spotify App and click on a speaker icon (Connect to a device)

* If you are on the same network as this container, select the speaker "MySpeaker"

* Enjoy!


## ENVs

* SPOTIFY_NAME: Specifies the name of this speaker (shown in Spotify client)
* DEVICE_NAME: PCM output io device to which the sound will be output using ALSA. Defaults to 'equal' so that you can configure alsa equalization. In this case, configure the target hw using "ALSA_SLAVE_PCM". If empty, will try to get the first available device. If defined to a hardware (eg. "hw:0,0"), equalization won't take place.
* ALSA_SLAVE_PCM: slave device as configured in alsa to which the sound will be sent to. eg. use 'plughw:0,0' for device at card 0, sub 0"
* EQUALIZATION: an equalization profile name or a series of 10 space separated values from 0-100 (one for each equalizer bin)
  * profile names: flat, classical, club, dance, bass, treble, live, party, pop, rock, techno
  * bins example: "82 79 70 70 70 70 70 72 80 90"
  * if you wish to interactively test the best equalization parameters, execute ```docker-compose exec rpi-spotify alsamixer -D equal```. On the next screen play with each equalization params, get the desired bin values and set this ENV parameter accordingly

## Development

Auto build doesn't work on Docker Hub because it is a cross compilation on RPI. You have to build the image locally and push it manually

```shell
docker-compose build
docker login
docker push flaviostutz/rpi-spotify
```

## Screenshots

<img src="screenshot.png" width="200" />
