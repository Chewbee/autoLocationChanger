#!/bin/ksh
mkdir -p /usr/local/var/log
exec &>/usr/local/var/log/autoNetworkLocation.log
# get SSID
SSID=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I | awk '/ SSID:/ {print $2}'`
echo `date` "New SSID found: $SSID"
# get the wifi connected 
SSID=`networksetup -getairportnetwork en0` 
print Connected to: ${SSID//Current Wi-Fi Network: ?(re)/} 
SSID=${SSID//Current Wi-Fi Network: ?(re)/} 
# LOCATIONS 
Location_Automatic="Automatic"
Location_Work="First"
Location_Home="Automatic"
# SSIDS
SSID_TelekomPublic=Telekom
SSID_Home=Dantooine5G
SSID_Work=WiFiFirst
# SSID -> LOCATION mapping
case $SSID in
	$SSID_TelekomPublic ) LOCATION="$Location_Automatic";;
	$SSID_Home          ) LOCATION="$Location_Home";;
	$SSID_Work  ) LOCATION="$Location_Work";;
	# ... add more here
esac
	REASON="SSID changed to $SSID"

# still didn't get a location -> use Location_Automatic
if [ -z "$LOCATION" ]; then
	LOCATION="$Location_Automatic"
	REASON="Automatic Fallback"
fi

# case $LOCATION in
#         $Location_Automatic )
#                 # do stuff here you would do in Location_Automatic
#                 osascript -e 'display notification "Network Location Changed to Automatic" with title "Network Location Changed"'
#         ;;

#         $Location_Home )
#                 osascript -e 'display notification "Network Location Changed to Home" with title "Network Location Changed"'
#         ;;
# 				# ... add more here
# esac


# Checking the curretn wifi 
if [[ "$SSID" != 'WiFiFirst' ]] ; then
    #Switch  the location
    #echo "Switching Location" 
    osascript -e 'display notification "Network Location Changed to Work" with title "Network Location Changed"'
    networksetup -switchtolocation First 
else
    echo "Already on the First Configuration" 
    osascript -e 'display notification "Already on the First Configuration" with title "Network Location unchanged"'
fi
