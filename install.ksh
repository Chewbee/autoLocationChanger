#!/bin/ksh

sudo cp ./autoNetworkLocation.ksh /Users/Georges.Henry.Portefait/bin/autoNetworkLocation.ksh
sudo cp ./autoLocationChanger.plist ~/Library/LaunchAgents/autoLocationChanger.plist

launchctl unload ~/Library/LaunchAgents/autoLocationChanger.plist
launchctl load ~/Library/LaunchAgents/autoLocationChanger.plist


