This container runs a headless [Spotify](https://www.spotify.com/us/) player that can be remote-controlled by any Spotify app. Audio is output to a pipe, which can be consumed in another container or the host system by [alsa](http://www.alsa-project.org/), [pulseaudio](http://pulseaudio.org), [forked-daapd](https://ejurgensen.github.io/forked-daapd/) (to Airplay), [snapserver](https://github.com/badaix/snapcast), etc.

This requires a Spotify premium account, but does not require a Spotify developer key or libspotify binary.

The process run is [librespot](https://github.com/plietar/librespot), an open source client library for Spotify.
This docker container image leverages the work from [David Cooper](https://dtcooper.github.io/raspotify).

### Examples
docker run -d --device=/dev/snd:/dev/snd --net=host svanscho/raspotify
docker run -d --device=/dev/snd:/dev/snd --net=host -e SPOTIFY_NAME=docker-spotify svanscho/raspotify
