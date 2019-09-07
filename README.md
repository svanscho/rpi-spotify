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
version: "3.7"
services:
  rpi-spotify:
    build: .
    image: flaviostutz/rpi-spotify
    network: host
    restart: always
    environment:
      - SPOTIFY_NAME=MySpeaker
      - DEVICE_NAME=/dev/snd  
```

* Run ```docker-compose up -d```

* Open Spotify App and click on a speaker icon (Connect to a device)

* If you are on the same network as this container, select the speaker "MySpeaker"

* Enjoy!


## ENVs

* SPOTIFY_NAME: Specifies the name of this speaker (shown in Spotify client)
* DEVICE_NAME: Output io device to which the sound will be output. Defaults to "/dev/snd"

## Screenshots

<img src="screenshot.png" width="200" />
