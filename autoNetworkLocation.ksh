#!/bin/ksh
mkdir -p /usr/local/var/log/
exec &>/usr/local/var/log/autoNetworkLocation.log

#echo "autoNetworkLocation triggered" | logger -s >> /usr/local/var/logautoNetworkLocation.log
# get SSID of the wifi connected 
# get SSID
SSID=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | awk '/ SSID:/ {print $2}'`
echo `date` "New SSID found: $SSID"
#
SSID=`networksetup -getairportnetwork en0` 
print Connected to: ${SSID//Current Wi-Fi Network: ?(re)/} 
SSID=${SSID//Current Wi-Fi Network: ?(re)/} 

# Switching
if [[ "$SSID" == 'iPhone' ]] ; then
    #Switch  the location
    #echo "Switching Location" 
    osascript -e 'display notification "Network Location Changed to Automatic" with title "Network Location Changed"'
    networksetup -switchtolocation Automatic  
	echo "autoNetworkLocation changed to Automatic " | logger -s >> /usr/local/var/logautoNetworkLocation.log
elif [[ "$SSID" == 'WiFiFirst' ]] ; then
    # echo "Already on the First Configuration" 
    osascript -e 'display notification "Switching to the First Configuration" with title "Network Location Changed"'
	networksetup -switchtolocation First  
	echo "autoNetworkLocation changed to First" | logger -s >> /usr/local/var/logautoNetworkLocation.log
else 
	osascript -e 'display notification "Defaulting to the Automatic Configuration" with title "Network Location Changed"'
	networksetup -switchtolocation Automatic  
	echo "autoNetworkLocation defaulting to Automatic " | logger -s >> /usr/local/var/logautoNetworkLocation.log
fi
