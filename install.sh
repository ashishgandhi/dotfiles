#!/bin/zsh -e

# Setup zsh
function link_file {
    src="${PWD}/$1"
    dst="${HOME}/${1/_/.}"

    if [ -e "${dst}" ] && [ ! -L "${dst}" ]; then
        mv $dst $dst.bak
    fi

    ln -sfh ${src} ${dst}
}

for i in _*
do
    link_file $i
done

# Install SF Mono
loc='/tmp/SF-Mono.dmg'
curl -o $loc https://developer.apple.com/design/downloads/SF-Mono.dmg
hdiutil attach $loc
mnt='/Volumes/SFMonoFonts'
sudo installer -verbose -pkg "${mnt}/SF Mono Fonts.pkg" -target /
hdiutil detach $mnt

# Install packages
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install clang-format cmake ctags-exuberant fasd ffmpeg fzf git go ipython jq mas ncdu python ripgrep tig tldr vim youtube-dl

# Install apps
brew install --cask 1password appcleaner dash fork iina intellij-idea iterm2 paw numi rectangle signal sublime-text suspicious-package textmate

# No longer installing
# brew cask uninstall alfred bartender google-chrome homebrew/cask-versions/sequel-pro-nightly sourcetree spotify

# Install Mac App Store apps
# Amphetamine, DaisyDisk, Fantastical 2, Flow, Front and Center, JSON Editor, Kaleidoscope, Keka, Microsoft To Do, Monodraw, Paste, Reeder 5, Spark, Things 3, Tweetbot 3, WhatsApp, Wipr
mas install 937984704 411643860 975937182 1423210932 1493996622 1544743900 567740330 587512244 470158793 1274495053 920404675 967805235 1529448980 1176895641 904280696 1384080005 1147396723 1320666476

# No longer installing
# Magnet, Pocket, PomTimer, Silicio, The Unarchiver, iStat Menus
# mas uninstall 441258766 568494494 843107699 933627574 425424353 1319778037

# Update path and other essential environment variables
source ~/.zprofile

# Preferences

# Global
defaults write -g AppleKeyboardUIMode -int 3
defaults write -g com.apple.trackpad.scaling -float 3
defaults write -g InitialKeyRepeat -int 25
defaults write -g KeyRepeat -int 2
defaults write -g NSQuitAlwaysKeepsWindows -bool YES
defaults write -g NSCloseAlwaysConfirmsChanges -bool YES
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 2
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool YES

# Menu Bar
defaults write com.apple.systemuiserver menuExtras -array \
"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
"/System/Library/CoreServices/Menu Extras/Battery.menu" \
"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
"/System/Library/CoreServices/Menu Extras/Clock.menu" \
"/System/Library/CoreServices/Menu Extras/Displays.menu" \
"/System/Library/CoreServices/Menu Extras/Volume.menu"
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.clock DateFormat -string "MMM d  h:mm"
killall SystemUIServer

# Finder
defaults write com.apple.finder ShowPathbar -bool YES
defaults write com.apple.finder ShowStatusBar -bool YES
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"
defaults write com.apple.finder NewWindowTarget "PfHm"
defaults write com.apple.finder NewWindowTargetPath "file://$HOME/"
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy name" ~/Library/Preferences/com.apple.finder.plist
killall Finder

# Dock
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock launchanim -bool NO
defaults write com.apple.dock magnification -bool NO
defaults write com.apple.dock show-recents -bool NO
killall Dock

# Mission Control
# Hot corners
# Possible values:
#
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
#
# Corner are tl, tr, bl, br
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock showAppExposeGestureEnabled -bool YES
defaults write com.apple.dock mru-spaces -bool NO
defaults write com.apple.dock expose-group-apps -bool YES
killall Dock

# Safari
# Under Privacy needs Full Disk Access
defaults write com.apple.Safari AutoFillPasswords -bool NO
defaults write com.apple.Safari IncludeInternalDebugMenu -bool YES
defaults write com.apple.Safari IncludeDevelopMenu -bool YES
defaults write com.apple.Safari ShowIconsInTabs -bool YES
defaults write com.apple.Safari ShowFavorites -bool YES
defaults write com.apple.Safari ShowCloudTabsInFavorites -bool YES
defaults write com.apple.Safari ShowPrivacyReportInFavorites -bool YES
defaults write com.apple.Safari ShowBackgroundImageInFavorites -bool NO
defaults write com.apple.Safari ShowFrequentlyVisitedSites -bool NO
defaults write com.apple.Safari ShowSiriSuggestionsPreference -bool NO
defaults write com.apple.Safari ShowReadingListInFavorites -bool NO
defaults write com.apple.Safari ReadingListSaveArticlesOfflineAutomatically -bool YES
defaults write com.apple.Safari ShowOverlayStatusBar -bool YES
defaults write com.apple.Safari AlwaysShowTabBar -bool YES
defaults write com.apple.Safari PrintHeadersAndFooters -bool NO
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool YES
defaults write com.apple.Safari CanPromptForPushNotifications -bool NO
defaults write -g WebKitDeveloperExtras -bool YES

# Contacts
# Under Privacy needs Contacts
defaults write com.apple.AddressBook ABNameSortingFormat -string "sortingFirstName sortingLastName"

# Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
cd ~/.vim/plugged/YouCompleteMe
./install.py --go-completer --java-completer --clang-completer

# TextMate
defaults write com.macromates.TextMate fileBrowserPlacement -string "left"

# Tweetbot
defaults write com.tapbots.Tweetbot3Mac syncType -int 1
defaults write com.tapbots.Tweetbot3Mac autoplayVideoTimeline -bool NO

# Reeder
defaults write com.reederapp.rkit2.mac HiddenTitlebar -bool NO
defaults write com.reederapp.rkit2.mac theme3 -string "Standard"

# Front and Center
defaults write co.hypercritical.Front-and-Center defaultBehavior -int 2
defaults write co.hypercritical.Front-and-Center launchOnLogin -bool YES
defaults write co.hypercritical.Front-and-Center showDockIcon -bool NO
defaults write co.hypercritical.Front-and-Center showMenuBarIcon -bool YES

# Paste
defaults write com.wiheads.paste kPSTPreferencesEnableSoundEffects -bool NO

# IntelliJ
defaults write com.jetbrains.intellij ApplePressAndHoldEnabled -bool NO

# PCalc
defaults write uk.co.tla-systems.pcalc HorizontalLayoutID_V4 -string "uk.co.tla-systems.pcalc.layout.programminghorizontal"
defaults write uk.co.tla-systems.pcalc ShowTape_V4 -bool YES

# Numi
defaults write com.dmitrynikolaev.numi nightTheme -bool NO
defaults write com.dmitrynikolaev.numi menuBarMode -bool NO

# AppCleaner
defaults write net.freemacsoft.AppCleaner SUEnableAutomaticChecks -bool YES
defaults write net.freemacsoft.AppCleaner SUAutomaticallyUpdate -bool YES

# Rectangle
defaults write com.knollsoft.Rectangle SUEnableAutomaticChecks -bool YES
defaults write com.knollsoft.Rectangle launchOnLogin -bool YES
defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -bool YES

# Things
defaults write com.culturedcode.ThingsMac CCDockCountType -int 3

# Podcasts
defaults write com.apple.podcasts MTPodcastUpdateIntervalDefault -int 0
defaults write com.apple.podcasts MTPodcastAutoDownloadStateDefaultKey -int 1
defaults write com.apple.podcasts MTRemoteSkipInsteadOfNextTrackDefault -bool YES
defaults write com.apple.podcasts MTSkipBackwardsIntervalDefault -int 15
defaults write com.apple.podcasts MTSkipForwardIntervalDefault -int 30
defaults write com.apple.podcasts MTContinuousPlaybackEnabled -bool YES
defaults write com.apple.podcasts MTSyncSubscriptions -bool YES
defaults write com.apple.podcasts MTPodcastDeletePlayedEpisodesDefaultKey -bool YES

# iTerm2
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool YES
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 1
defaults write com.googlecode.iterm2 NoSyncTipsDisabled -bool YES
defaults write com.googlecode.iterm2 NoSyncTurnOffBracketedPasteOnHostChange -bool YES
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile -bool YES
defaults write com.googlecode.iterm2 NoSyncDoNotWarnBeforeMultilinePaste -bool YES
defaults write com.googlecode.iterm2 NoSyncDoNotWarnBeforeMultilinePaste_selection -int 0
defaults write com.googlecode.iterm2 NoSyncDoNotWarnBeforePastingOneLineEndingInNewlineAtShellPrompt -bool YES
defaults write com.googlecode.iterm2 NoSyncDoNotWarnBeforePastingOneLineEndingInNewlineAtShellPrompt_selection -int 1
defaults write com.googlecode.iterm2 NoSyncNewTabFromTmuxOpensTmux -bool YES
defaults write com.googlecode.iterm2 NoSyncNewTabFromTmuxOpensTmux_selection -int 0
defaults write com.googlecode.iterm2 NoSyncNewWindowFromTmuxOpensTmux -bool YES
defaults write com.googlecode.iterm2 NoSyncNewWindowFromTmuxOpensTmux_selection -int 1
defaults write com.googlecode.iterm2 SUEnableAutomaticChecks -bool YES

# Terminal
osascript <<EOD
tell application "Terminal"
    set theme to "Custom"
    do shell script "open ~/.config/terminal/'" & theme & ".terminal'"
    delay 1
    set default settings to settings set theme
end tell
EOD

