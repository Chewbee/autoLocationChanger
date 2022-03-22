#!/bin/ksh

mkdir -p usr/local/var/log
exec &>/usr/local/var/log/autoNetworkLocation.log

# get the wifi connected 
currentWifi=$(networksetup -getairportnetwork en0 ) 
print Connected to: "$currentWifi"
toTest=${currentWifi//Current Wi-Fi Network: ?(re)/} 
# echo "$toTest"
# Checking the curretn wifi 
if [[ "$toTest" == 'WiFiFirst' ]] ; then
    #Switch  the location
    echo "Switching Location" "$toTest"
    osascript -e 'display notification "Network Location changing to First " with title "First"'
    networksetup -switchtolocation First 
    exit
#
elif [[ "$toTest" == 'Monext_Guest' ]] ; then
echo "Switching Location" "$toTest"
    osascript -e 'display notification "Network Location changing to Monext " with title "Monext"'
    networksetup -switchtolocation Monext 
    exit
#
elif [[ "$toTest" != 'WiFiFirst' ]] ; then
echo "Switching Location" "$toTest"
    osascript -e 'display notification "Network Location changing to Automatic " with title "Network Location switching"'
    networksetup -switchtolocation Automatic 
    exit
else
    echo "Already on the First Configuration" "$toTest"
    osascript -e 'display notification "Network Location is first " with title "Network Location is First"'
fi
