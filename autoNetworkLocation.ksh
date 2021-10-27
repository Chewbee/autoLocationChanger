#!/bin/ksh
mkdir -p /usr/local/var/log
exec &>/usr/local/var/log/autoNetworkLocation.log
# get SSID of the wifi connected 
SSID=`networksetup -getairportnetwork en0` 
print Connected to: ${SSID//Current Wi-Fi Network: ?(re)/} 
SSID=${SSID//Current Wi-Fi Network: ?(re)/} 

# Switching
if [[ "$SSID" == 'iPhone' ]] ; then
    #Switch  the location
    #echo "Switching Location" 
    osascript -e 'display notification "Network Location Changed to Automatic" with title "Network Location Changed"'
    networksetup -switchtolocation Automatic  
elif [[ "$SSID" == 'WiFiFirst' ]] ; then
    # echo "Already on the First Configuration" 
    osascript -e 'display notification "Switching to the First Configuration" with title "Network Location Changed"'
	networksetup -switchtolocation First  
else 
	osascript -e 'display notification "Defaulting to the Automatic Configuration" with title "Network Location Changed"'
	networksetup -switchtolocation Automatic  
fi
