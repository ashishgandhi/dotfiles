#!/bin/bash -e

# Use prezto
function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        mv $target $target.df.bak
    fi

    ln -sfh ${source} ${target}
}

for i in _*
do
	link_file $i
done

git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
chsh -s /bin/zsh
exec $SHELL

# Install packages
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install go python cmake ffmpeg ctags-exuberant fasd ripgrep jq clang-format neovim youtube-dl fzf mas
/usr/local/opt/python/libexec/bin/pip install --user --upgrade neovim

# Setup nvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
cd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer
ln -s /usr/local/bin/nvim /usr/local/bin/vim

# Install apps
brew cask install dash 1password iina sublime-text appcleaner sourcetree bartender google-chrome iterm2

# Install Mac App Store apps
# Keka, The Unarchiver, Paste, Spark, Fantastical 2, Things3, iStat Menus, Kaleidoscope, Amphetamine, Magnet, Reeder, Pocket, Wipr, PomTimer, Tweetbot 3, WhatsApp, DaisyDisk
mas install 470158793 425424353 967805235 1176895641 975937182 904280696 1319778037 587512244 937984704 441258766 880001334 568494494 1320666476 843107699 1384080005 1147396723 411643860

# Customize preferences

# Global
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 # Full Keyboard Access: All controls
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3
# defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool YES

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
defaults write com.apple.finder FXPreferredViewStyle -string "icnv" # Nlsv, clmv, Flwv
defaults write com.apple.finder NewWindowTarget "PfHm"
defaults write com.apple.finder NewWindowTargetPath "file://$HOME/"
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy name" ~/Library/Preferences/com.apple.finder.plist
killall Finder

# Dock
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock launchanim -bool NO
defaults write com.apple.dock mru-spaces -bool NO
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
killall Dock

# Tweetbot
defaults write com.tapbots.Tweetbot3Mac syncType -int 1
defaults write com.tapbots.Tweetbot3Mac autoplayVideoTimeline -bool NO
killall Tweetbot

# Reeder
defaults write com.reederapp.rkit2.mac HiddenTitlebar -bool NO
defaults write com.reederapp.rkit2.mac theme3 -string "Standard"
killall Reeder

# Fantastical
defaults write com.flexibits.fantastical2.mac HideStatusItem -bool YES
defaults write com.flexibits.fantastical2.mac ListShows -int 1
defaults write com.flexibits.fantastical2.mac ShowCalendarWeeks -bool YES
defaults write com.flexibits.fantastical2.mac IgnoreQuitWarning -bool YES
killall "Fantastical 2"

# Sourcetree
defaults write com.torusknot.SourceTreeNotMAS createBookmarksOnOpenRepo -bool NO
defaults write com.torusknot.SourceTreeNotMAS fileStatusStagingViewMode -int 1
defaults write com.torusknot.SourceTreeNotMAS agreedToUpdateConfig -bool NO
killall Sourcetree

# iTerm2
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool YES
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 1
defaults write com.googlecode.iterm2 NoSyncTipsDisabled -bool YES
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile -bool YES
defaults write com.googlecode.iterm2 SUEnableAutomaticChecks -bool YES
killall iTerm2

# Terminal
osascript <<EOD
tell application "Terminal"
    set theme to "Solarized Dark"
    do shell script "open '" & theme & ".terminal'"
	delay 1
	set default settings to settings set theme
end tell
EOD

