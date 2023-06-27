#!/bin/ash

echo "running ffmpeg proxy..."

cam_rtmp_host=$REOLINK_RTMP_HOST
cam_rtmp_user=$REOLINK_RTMP_USERNAME
cam_rtmp_password=$REOLINK_RTMP_PASSWORD

cam_rtmp_uri="rtmp://$cam_rtmp_host/bcs/channel0_sub.bcs?channel=0&stream=0&user=$cam_rtmp_user&password=$cam_rtmp_password"

echo "camp_rtmp_host: $camp_rtmp_host"
echo "cam_rtmp_user: $cam_rtmp_user"
echo "cam_rtmp_password: $cam_rtmp_password"
echo "cam_rtmp_uri: $cam_rtmp_uri"

youtube_live_key=$YOUTUBE_LIVE_KEY

echo "youtube_live_key: $youtube_live_key"

rtmp_proxy_injext="rtmp://rtmp-proxy/live"

ffmpeg \
    -i $cam_rtmp_uri \
    -c copy \
    -ar 44100 \
    -f flv rtmp://a.rtmp.youtube.com/live2/$youtube_live_key
