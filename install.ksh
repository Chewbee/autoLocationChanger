#!/bin/ksh

sudo cp autoNetworkLocation.ksh /usr/local/bin
sudo cp autoLocationChanger.plist ~/Library/LaunchAgents/autoLocationChanger.plist

launchctl unload ~/Library/LaunchAgents/autoLocationChanger.plist
launchctl load ~/Library/LaunchAgents/autoLocationChanger.plist


