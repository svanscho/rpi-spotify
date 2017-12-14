This container runs a headless [Spotify](https://www.spotify.com/us/) player that can be remote-controlled by any Spotify app. Audio is output to /dev/snd, so you need to make sure the docker container has access to it (see examples). This allows the host system to play back the audio using [alsa](http://www.alsa-project.org/), [pulseaudio](http://pulseaudio.org), [forked-daapd](https://ejurgensen.github.io/forked-daapd/) (to Airplay), [snapserver](https://github.com/badaix/snapcast), etc.

This requires a Spotify premium account, but does not require a Spotify developer key or libspotify binary.

The process run is [librespot](https://github.com/plietar/librespot), an open source client library for Spotify.
This docker container image leverages the work from [David Cooper](https://dtcooper.github.io/raspotify).

[Dockerhub](https://hub.docker.com/r/svanscho/rpi-spotify/): [![](https://images.microbadger.com/badges/version/svanscho/rpi-spotify.svg)](https://microbadger.com/images/svanscho/rpi-spotify "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/svanscho/rpi-spotify.svg)](https://microbadger.com/images/svanscho/rpi-spotify "Get your own image badge on microbadger.com") 

### Screenshots
<img src="screenshot.png" width="200">

### Prerequisites
- a raspberry pi (tested on RPi2)
- docker (install with `curl -sSL https://get.docker.com | sh`)
### Examples
- `docker run -d --device=/dev/snd:/dev/snd --net=host svanscho/rpi-spotify`
- `docker run -d --device=/dev/snd:/dev/snd --net=host -e SPOTIFY_NAME=docker-spotify svanscho/rpi-spotify`(you can set the name with **--SPOTIFY_NAME**)

If you want the container to always run (even when the RPi rebooted):
- `docker run -d --restart=always --name=rpi-spotify --device=/dev/snd:/dev/snd --net=host svanscho/rpi-spotify` (mind the **--restart=always**)



