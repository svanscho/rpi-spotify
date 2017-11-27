This container runs a headless [Spotify](https://www.spotify.com/us/) player that can be remote-controlled by any Spotify app. Audio is output to /dev/snd, so you need to make sure the docker container has access to it (see examples). This allows the host system to play back the audio using [alsa](http://www.alsa-project.org/), [pulseaudio](http://pulseaudio.org), [forked-daapd](https://ejurgensen.github.io/forked-daapd/) (to Airplay), [snapserver](https://github.com/badaix/snapcast), etc.

This requires a Spotify premium account, but does not require a Spotify developer key or libspotify binary.

The process run is [librespot](https://github.com/plietar/librespot), an open source client library for Spotify.
This docker container image leverages the work from [David Cooper](https://dtcooper.github.io/raspotify).

### Examples
- docker run -d --device=/dev/snd:/dev/snd --net=host svanscho/raspotify
- docker run -d --device=/dev/snd:/dev/snd --net=host *-e SPOTIFY_NAME=docker-spotify* svanscho/raspotify

If you want the container to always run (even when the RPi rebooted):
- docker run -d *--restart=always* --device=/dev/snd:/dev/snd --net=host svanscho/raspotify
