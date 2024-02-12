#!/bin/sh

set_equalizer_curve() {
  curve="${*}"
  ctl=0
  for point in ${curve}
  do
    ctl=$(( ${ctl} + 1 ))
    echo cset numid=${ctl} ${point}
  done | amixer -D equal -s
}

profile="${1:-flat}"
case "${profile}" in
flat) curve="65 65 65 65 65 65 65 65 65 65" ;;
classical) curve="58 58 58 58 58 58 45 47 47 42" ;;
club) curve="58 58 62 66 66 66 62 58 58 58" ;;
dance) curve="72 68 60 58 58 48 47 47 58 58" ;;
bass) curve="71 71 71 66 59 52 44 41 40 40" ;;
treble) curve="42 42 42 52 62 74 83 83 83 85" ;;
large_hall) curve="74 74 66 66 58 51 51 51 58 58" ;;
live) curve="51 58 64 66 66 66 64 62 62 60" ;;
party) curve="68 68 58 58 58 58 58 58 68 68" ;;
pop) curve="56 65 68 70 66 56 54 54 56 56" ;;
rock) curve="72 66 50 45 52 64 72 74 74 74" ;;
techno) curve="70 66 58 50 51 58 70 72 72 72" ;;
*) curve="${profile}" ;;
esac

[ "${curve}" ] && set_equalizer_curve "${curve}"
