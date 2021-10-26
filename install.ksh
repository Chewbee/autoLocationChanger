#!/bin/ksh

sudo cp autoNetworkLocation.ksh /usr/local/bin

launchctl unload ~/Library/LaunchAgents/autoLocationChanger.plist
launchctl load ~/Library/LaunchAgents/autoLocationChanger.plist


