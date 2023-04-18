#!/bin/bash

read -ep "Set ComputerName (friendly): " NAME
sudo scutil --set ComputerName $NAME
read -ep "Set HostName (shell): " NAME
sudo scutil --set HostName $NAME
read -ep "Set LocalHostName (bonjour): " NAME
sudo scutil --set LocalHostName $NAME
read -ep "Set NetBIOSName (): " NAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $NAME

# vim: ft=sh syn=sh
