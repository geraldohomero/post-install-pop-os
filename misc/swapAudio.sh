####################
## For PulseAudio ##
####################

pactl load-module module-remap-sink \
    sink_name=reverse-stereo \
    master=0 \
    channels=2 \
    master_channel_map=front-right,front-left \
    channel_map=front-left,front-right
