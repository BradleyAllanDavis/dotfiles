#!/usr/bin/env bash

# MacOS Configuration

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

LINE="========================================================================="

#######################################################################

echo ""
echo $LINE
echo "System"
echo $LINE

echo "Disable the sudden motion sensor as it’s not useful for SSDs"
sudo pmset -a sms 0

echo "Set standby delay to 24 hours (default is 1 hour)"
sudo pmset -a standbydelay 86400

# echo "Never go into computer sleep mode"
#sudo systemsetup -setcomputersleep Off > /dev/null

echo "Set the timezone; see 'sudo systemsetup -listtimezones' for other values"
sudo systemsetup -settimezone "America/Los_Angeles" > /dev/null

#######################################################################

echo ""
echo $LINE
echo "Terminal"
echo $LINE

echo "Only use UTF-8 in Terminal.app"
defaults write com.apple.terminal StringEncodings -array 4

echo "Enable “focus follows mouse” for Terminal.app and all X11 apps"
defaults write com.apple.terminal FocusFollowsMouse -bool true
defaults write org.x.X11 wm_ffm -bool true

echo "Enable Secure Keyboard Entry in Terminal.app"
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

echo "Disable the annoying line marks"
defaults write com.apple.Terminal ShowLineMarks -int 0

#######################################################################

echo ""
echo $LINE
echo "iTerm 2"
echo $LINE

echo "Don’t display the annoying prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# ?
defaults write com.googlecode.iterm2 HotkeyTermAnimationDuration -float 0.00001

#######################################################################

echo ""
echo $LINE
echo "General UI/UX"
echo $LINE

echo "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo "Allow text substitution in every app"
defaults write -g WebAutomaticTextReplacementEnabled -bool true

echo "Always show scrollbars"
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

echo "Disable transparency in the menu bar and elsewhere on Yosemite"
defaults write com.apple.universalaccess reduceTransparency -bool true
# defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool true

echo "Menu bar: show remaining battery percentage"
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

echo "Set sidebar icon size to small"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

echo "Disable the over-the-top focus ring animation"
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

echo "Increase window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo "Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo "Disable the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

# echo "Remove duplicates in the “Open With” menu (also see 'lscleanup' alias)"
# /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

echo "Enable Resume system-wide"
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool true

echo "Disable automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

echo "Disable the crash reporter"
defaults write com.apple.CrashReporter DialogType -string "none"

echo "Set Help Viewer windows to non-floating mode"
defaults write com.apple.helpviewer DevMode -bool true

echo "Finder: allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "Disable "close windows when quitting an app""
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool true

echo "Restart automatically if the computer freezes"
sudo systemsetup -setrestartfreeze on

echo "Disable smart quotes and dashes as they’re annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

#######################################################################

echo ""
echo $LINE
echo "Trackpad/Mouse"
echo $LINE

echo "Set mouse speed"
defaults write -g com.apple.mouse.scaling 5.0

#######################################################################

echo ""
echo $LINE
echo "Bluetooth Accessories"
echo $LINE

echo "Increase sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

#######################################################################

echo ""
echo $LINE
echo "Input"
echo $LINE

echo "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

echo "Set language and text formats"
defaults write NSGlobalDomain AppleLanguages -array "en" "nl"
defaults write NSGlobalDomain AppleLocale -string "en_US@currency=USD"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Inches"
defaults write NSGlobalDomain AppleMetricUnits -bool false

echo "Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

#######################################################################

echo ""
echo $LINE
echo "Keyboard"
echo $LINE

echo "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 1.0

echo "Set a shorter delay until repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 11

#######################################################################

echo ""
echo $LINE
echo "Xcode"
echo $LINE

echo "Always use spaces for indenting"
defaults write com.apple.dt.Xcode DVTTextIndentUsingTabs -bool false

echo "Show tab bar"
defaults write com.apple.dt.Xcode AlwaysShowTabBar -bool true

#######################################################################

echo ""
echo $LINE
echo "iTunes"
echo $LINE

echo "Stop iTunes from responding to the keyboard media keys"
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

#######################################################################

echo ""
echo $LINE
echo "Screensaver"
echo $LINE

echo "Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

#######################################################################

echo ""
echo $LINE
echo "Screen Capture"
echo $LINE

echo "Save screenshots to the downloads folder"
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

echo "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

echo "Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

#######################################################################

echo ""
echo $LINE
echo "Displays"
echo $LINE

echo "Enable subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2
# defaults write -g AppleFontSmoothing -int 0

echo "Enable HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

#######################################################################

echo ""
echo $LINE
echo "Finder"
echo $LINE

# echo "Hide menubar"
# defaults write NSGlobalDomain _HIHideMenuBar -bool true

echo "Show the ~/Library folder"
sudo chflags nohidden ~/Library

echo "Show the /Volumes folder"
sudo chflags nohidden /Volumes

echo "Use column view in all Finder windows by default"
echo "Four-letter codes for the other view modes: 'icnv', 'clmv', 'Flwv', and 'Nlsv'"
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

echo "Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "Empty Trash securely by default"
defaults write com.apple.finder EmptyTrashSecurely -bool true

echo "Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons"
defaults write com.apple.finder QuitMenuItem -bool true

echo "Finder: disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true

echo "Set Desktop as the default location for new Finder windows"
echo "For other paths, use 'PfLo' and 'file:///full/path/here/'"
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Dropbox/"

echo "Show icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# echo "Finder: show hidden files by default"
#defaults write com.apple.finder AppleShowAllFiles -bool true

echo "Disable animations when opening and closing windows"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

echo "Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "Finder: show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "Disable animations when opening a Quick Look window"
defaults write -g QLPanelAnimationDuration -float 0

echo "Finder: show path bar in finder window"
defaults write com.apple.finder ShowPathbar -bool true

echo "Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "Enable spring loading for directories"
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

echo "Remove the spring loading delay for directories"
defaults write NSGlobalDomain com.apple.springing.delay -float 0

echo "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

echo "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

echo "Enable snap-to-grid for icons on the desktop"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

echo "Expand the following File Info panes: General, Open with, and Sharing & Permissions"
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true

killall Finder

#######################################################################

echo ""
echo $LINE
echo "Mission Control"
echo $LINE

echo "Speed up Mission Control animations"
defaults write com.apple.dock expose-animation-duration -float 0.1

echo "Displays have separate spaces"
defaults write com.apple.spaces spans-displays -bool TRUE

echo "Don’t group windows by application in Mission Control"
echo "(i.e. use the old Exposé behavior instead)"
defaults write com.apple.dock expose-group-by-app -bool false

echo "Don’t automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

#######################################################################

echo ""
echo $LINE
echo "Dashboard"
echo $LINE

echo "Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

echo "Don’t show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true

echo "Enable Dashboard dev mode (allows keeping widgets on the desktop)"
defaults write com.apple.dashboard devmode -bool true

#######################################################################

echo ""
echo $LINE
echo "Notification Center"
echo $LINE

echo "Disable Notification Center completely"
launchctl unload /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

# echo "Re-enable Notification Center"
# launchctl load /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

# Setup DND on NotificationCenter
# MAC_UUID=$(system_profiler SPHardwareDataType | awk -F" " '/UUID/{print $3}')
# for USER_TEMPLATE in "/System/Library/User Template"/*
#   do
#     /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/ByHost/com.apple.notificationcenterui.$MAC_UUID "dndEnd" -float 1379
#     /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/ByHost/com.apple.notificationcenterui.$MAC_UUID "doNotDisturb" -bool FALSE
#     /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/ByHost/com.apple.notificationcenterui.$MAC_UUID "dndStart" -float 1380
#   done

killall SystemUIServer

#######################################################################

echo ""
echo $LINE
echo "Safari & WebKit"
echo $LINE

echo "Deactive inline video"
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false

echo "Enable debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu 1

echo "Show status bar"
defaults write com.apple.Safari ShowStatusBar -boolean true

echo "Safari resumes last session"
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true

echo "Open pages in tabs instead of windows: automatically"
defaults write com.apple.Safari TabCreationPolicy -int 1

echo "Don't make new tabs active"
defaults write com.apple.Safari OpenNewTabsInFront -bool false

echo "Command-clicking a link creates tabs"
defaults write com.apple.Safari CommandClickMakesTabs -bool true

echo "Block pop-up windows"
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

echo "Update extensions automatically"
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

echo "Disable the standard delay in rendering a Web page"
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25

echo "Do not track"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

echo "Privacy: don’t send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo "Press Tab to highlight each item on a web page"
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

echo "Show the full URL in the address bar (note: this still hides the scheme)"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

echo "Set Safari’s home page to 'about:blank' for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank"

echo "Prevent Safari from opening ‘safe’ files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

echo "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

echo "Show Safari’s bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool true

echo "Hide Safari’s sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

echo "Disable Safari’s thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

echo "Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo "Make Safari’s search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

echo "Remove useless icons from Safari’s bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo "Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

echo "Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

#######################################################################

echo ""
echo $LINE
echo "Mail"
echo $LINE

echo "Disable send and reply animations in Mail.app"
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

echo "Copy email addresses as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app"
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

echo "Display emails in threaded mode, sorted by date (oldest at the top)"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

echo "Disable inline attachments (just show the icons)"
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

#######################################################################

echo ""
echo $LINE
echo "Time Machine"
echo $LINE

echo "Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# echo "Disable local Time Machine backups"
# hash tmutil &> /dev/null && sudo tmutil disablelocal
#hash tmutil &amp;&gt; /dev/null &amp;&amp; sudo tmutil disablelocal

#######################################################################

echo ""
echo $LINE
echo "Activity Monitor"
echo $LINE

echo "Show the main window when launching Activity Monitor"
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

echo "Visualize CPU usage in the Activity Monitor Dock icon"
defaults write com.apple.ActivityMonitor IconType -int 5

echo "Show all processes in Activity Monitor"
defaults write com.apple.ActivityMonitor ShowCategory -int 0

echo "Sort Activity Monitor results by CPU usage"
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

#######################################################################

echo ""
echo $LINE
echo "Mac App Store & Software Updates"
echo $LINE

echo "Enable the WebKit Developer Tools in the Mac App Store"
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

echo "Enable Debug Menu in the Mac App Store"
defaults write com.apple.appstore ShowDebugMenu -bool true

echo "Enable the automatic update check"
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "Download newly available updates in background"
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

echo "Install System data files & security updates"
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

echo "Automatically download apps purchased on other Macs"
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

echo "Turn on app auto-update"
defaults write com.apple.commerce AutoUpdate -bool true

echo "Allow the App Store to reboot machine on macOS updates"
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

#######################################################################

echo ""
echo $LINE
echo "Photos"
echo $LINE

echo "Prevent Photos from opening automatically when devices are plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

#######################################################################

echo ""
echo $LINE
echo "Messages"
echo $LINE

echo "Disable automatic emoji substitution (i.e. use plain text smileys)"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

echo "Disable smart quotes as it’s annoying for messages that contain code"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

echo "Disable continuous spell checking"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

#######################################################################

echo ""
echo $LINE
echo "Transmission"
echo $LINE

echo "Do not store incomplete downloads"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool false

echo "Don’t prompt for confirmation before downloading"
defaults write org.m0k.transmission DownloadAsk -bool false

echo "Trash original torrent files"
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

echo "Hide the donate message and legal disclaimer"
defaults write org.m0k.transmission WarningDonate -bool false
defaults write org.m0k.transmission WarningLegal -bool false

# IP block list.
# Source: https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission/
defaults write org.m0k.transmission BlocklistNew -bool true
defaults write org.m0k.transmission BlocklistURL -string "http://john.bitsurge.net/public/biglist.p2p.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true

#######################################################################

echo ""
echo $LINE
echo "Spotlight"
echo $LINE

# echo "Hide Spotlight tray-icon (and subsequent helper)"
# sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search

# Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed before
# echo "Use 'sudo mdutil -i off '/Volumes/foo'' to stop indexing any volume."
# sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using OS X 10.9 or older):
# 	MENU_DEFINITION
# 	MENU_CONVERSION
# 	MENU_EXPRESSION
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# Load new settings before rebuilding the index
#killall mds > /dev/null 2>&1

# Make sure indexing is enabled for the main volume
#sudo mdutil -i on / > /dev/null

# Rebuild the index from scratch
#sudo mdutil -E / > /dev/null

#######################################################################

echo ""
echo $LINE
echo "Flux"
echo $LINE

echo "Location Mountain View, CA"
defaults write org.herf.Flux location "37.4,-122"
defaults write org.herf.Flux locationTextField "Mountain View"
defaults write org.herf.Flux locationType "L"

echo "Daytime temperature"
defaults write org.herf.Flux dayColorTemp -int 5000

echo "Evening temperature"
defaults write org.herf.Flux nightColorTemp -int 3000

echo "Night temperature"
defaults write org.herf.Flux lateColorTemp -int 1200

echo "Wake up at 8am"
defaults write org.herf.Flux wakeTime -int 480

echo "Sleep late on weekends"
defaults write org.herf.Flux sleepLate -bool true

#######################################################################

echo ""
echo $LINE
echo "Address Book"
echo $LINE

echo "Enable the debug menu in Address Book"
defaults write com.apple.addressbook ABShowDebugMenu -bool true

#######################################################################

echo ""
echo $LINE
echo "iCal"
echo $LINE

echo "Enable the debug menu in iCal (pre-10.8)"
defaults write com.apple.iCal IncludeDebugMenu -bool true

#######################################################################

echo ""
echo $LINE
echo "Disk Utility"
echo $LINE

echo "Enable the debug menu in Disk Utility"
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

#######################################################################

echo ""
echo $LINE
echo "TextEdit"
echo $LINE

echo "Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -int 0

echo "Open and save files as UTF-8 in TextEdit"
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

#######################################################################

echo ""
echo $LINE
echo "Google Chrome (Canary)"
echo $LINE

echo "Use the system-native print preview dialog"
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true

echo "Expand the print dialog by default"
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

#######################################################################

echo ""
echo $LINE
echo "Tweetbot"
echo $LINE

echo "Bypass the annoyingly slow t.co URL shortener"
defaults write com.tapbots.TweetbotMac OpenURLsDirectly -bool true

#######################################################################

unset NAME
unset LINE

# vim: ft=sh syn=sh
