FROM balenalib/rpi-raspbian:buster-20201118

#alsa install
RUN apt-get update && \
    apt-get install alsa-utils pulseaudio libpulse-dev libasound2-plugin-equal gettext -y

#raspotify install
RUN apt-get update && \
    apt-get -y install curl apt-transport-https && \
    curl -sSLk https://dtcooper.github.io/raspotify/key.asc | apt-key add -v - && \
    echo "deb https://dtcooper.github.io/raspotify raspotify main" | tee /etc/apt/sources.list.d/raspotify.list && \
    apt-get update && \
    apt-get -y install raspotify 

RUN groupadd -g 9003 spotify && useradd -u 9003 -r -g spotify spotify && usermod -a -G audio spotify

ENV SPOTIFY_NAME RaspotifySpeaker
ENV BACKEND_NAME 'alsa'
ENV DEVICE_NAME 'equal'
ENV ALSA_SLAVE_PCM 'plughw:0,0'
ENV ALSA_SOUND_LEVEL '100%'
ENV VERBOSE 'false'
ENV EQUALIZATION ''

ADD /asound.conf /etc/asound.conf
ADD --chown=spotify:spotify /equalizer.sh /

ADD --chown=spotify:spotify /startup.sh /
CMD /startup.sh
