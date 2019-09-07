FROM resin/rpi-raspbian
RUN curl -sL https://dtcooper.github.io/raspotify/install.sh | sh
ENV SPOTIFY_NAME RaspotifySpeaker
ENV DEVICE_NAME /dev/snd
CMD /usr/bin/librespot --name "$SPOTIFY_NAME" --backend alsa --bitrate 320 --disable-audio-cache  --device "$DEVICE_NAME"
