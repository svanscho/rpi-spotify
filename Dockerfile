FROM resin/rpi-raspbian
RUN curl -sL https://dtcooper.github.io/raspotify/install.sh | sh
ENV SPOTIFY_NAME raspotify
CMD /usr/bin/librespot --name "$SPOTIFY_NAME" --backend alsa --bitrate 320 --disable-audio-cache
