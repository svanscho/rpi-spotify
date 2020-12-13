FROM balenalib/rpi-raspbian:buster-20201118

#alsa install
RUN apt-get update
RUN apt-get install alsa-utils libasound2-plugin-equal gettext -y

#raspotify install
RUN curl -sSL https://dtcooper.github.io/raspotify/key.asc | apt-key add -v -
RUN echo "deb https://dtcooper.github.io/raspotify raspotify main" | tee /etc/apt/sources.list.d/raspotify.list
RUN apt-get update
RUN apt-get -y install curl apt-transport-https
RUN apt-get -y install raspotify 

ENV SPOTIFY_NAME RaspotifySpeaker
ENV BACKEND_NAME 'alsa'
ENV DEVICE_NAME 'equal'
ENV ALSA_SLAVE_PCM 'plughw:0,0'
ENV ALSA_SOUND_LEVEL '100%'
ENV VERBOSE 'false'
ENV EQUALIZATION ''

ADD /asound.conf /
ADD /equalizer.sh /

ADD /startup.sh /
CMD /startup.sh
