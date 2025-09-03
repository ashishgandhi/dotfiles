#!/bin/zsh -e

# Have to copy since neither folder nor file symlinks work
filters="${HOME}/Library/Filters"
mkdir -p "${filters}"
cp ~/.config/filters/* "${filters}"

# Install Apple fonts
fonts=('SF-Pro' 'SF-Mono' 'NY')
for font in "${fonts[@]}"
do
    loc="/tmp/${font}.dmg"
    curl -Lo "${loc}" "https://devimages-cdn.apple.com/design/resources/download/${font}.dmg"
    mnt="/Volumes/${font}"
    hdiutil attach -mountpoint "${mnt}" "${loc}"
    pkg=$(find "$mnt" -iname '*.pkg' -print -quit)
    sudo installer -verbose -pkg "${pkg}" -target /
    hdiutil detach "${mnt}"
    rm "${loc}"
done

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

# Install packages
brew install cmake ffmpeg fzf git go ipython jq mas ncdu python ripgrep tig vim yt-dlp zoxide

# Install apps
brew install --cask appcleaner dash@6 dropbox fork google-drive iina kaleidoscope@3 mimestream paste signal suspicious-package

# Install Mac App Store apps
# 1Blocker, 1Password for Safari, Amphetamine, BBEdit, Crouton, DaisyDisk, Hex Fiend, Ivory, Keka, Microsoft To Do, Monodraw, Sink It, Reeder, TestFlight, Things, uBlock Origin Lite, Vinegar, WhatsApp, Wipr 2
mas install 1365531024 1569813296 937984704 404009241 1461650987 411643860 1342896380 6444602274 470158793 1274495053 920404675 6449873635 1529448980 899247664 904280696 6745342698 1591303229 310633997 1662217862

# Preferences

# Global
defaults write -g AppleKeyboardUIMode -int 3
defaults write -g com.apple.trackpad.scaling -float 3
defaults write -g com.apple.mouse.scaling -float 2.5
defaults write -g com.apple.scrollwheel.scaling -float 1
defaults write -g AppleShowScrollBars -string WhenScrolling
defaults write -g InitialKeyRepeat -int 25
defaults write -g KeyRepeat -int 2
defaults write -g ApplePressAndHoldEnabled -bool NO
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool NO
defaults write -g NSQuitAlwaysKeepsWindows -bool YES
defaults write -g NSCloseAlwaysConfirmsChanges -bool YES
defaults write -g NSUserKeyEquivalents -dict-add Strikethrough '@$x'
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 2
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool YES
defaults write com.apple.universalaccess showWindowTitlebarIcons -bool YES

# Menu Bar
# defaults -currentHost read com.apple.controlcenter BatteryShowPercentage -bool NO
#  2: Show When Active
#  8: Don't Show in Menu Bar
# 18: Always Show in Menu Bar
# 24: Removed manually from menu bar by dragging
defaults -currentHost write com.apple.controlcenter Sound -int 18
defaults -currentHost write com.apple.controlcenter Weather -int 2
defaults -currentHost write com.apple.controlcenter NowPlaying -int 2
defaults -currentHost write com.apple.controlcenter FocusModes -int 8
# 0: when space allows
# 1: always
# 2: never
defaults write com.apple.menuextra.clock ShowDate -int 0
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool YES
# This means the Menu Bar shows in full screen videos as well
# defaults write -g AppleMenuBarVisibleInFullscreen -bool YES

# Spotlight
defaults -currentHost write com.apple.Spotlight MenuItemHidden -bool YES
defaults write com.apple.Spotlight PasteboardHistoryTimeout -int 2592000

# Window management
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool NO
# Tiling shortcuts are saved in a complex dictionary in com.apple.symbolichotkeys
# Best to manually set customize them instead

# Finder
defaults write com.apple.finder ShowPathbar -bool YES
defaults write com.apple.finder ShowStatusBar -bool YES
defaults write com.apple.finder FXDefaultSearchScope -string SCcf
defaults write com.apple.finder FXPreferredViewStyle -string icnv
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"
defaults write com.apple.finder _FXSortFoldersFirst -bool YES
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:arrangeBy name' ~/Library/Preferences/com.apple.finder.plist
killall Finder

# Dock
defaults write com.apple.dock tilesize -int 42
defaults write com.apple.dock launchanim -bool NO
defaults write com.apple.dock magnification -bool NO
defaults write com.apple.dock show-recents -bool NO
killall Dock

# Mission Control
# Hot corners
# Possible values:
#
#  0: None
#  2: Mission Control
#  3: Application Windows
#  4: Desktop
#  5: Start Screen Saver
#  6: Disable Screen Saver
#  7: Dashboard
# 10: Put Display to Sleep
# 11: Launchpad
# 12: Notification Center
# 13: ⌘ Lock Screen
# 14: Quick Note
#
# Corner are tl, tr, bl, br
defaults write com.apple.dock wvous-bl-corner -int 3
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock showAppExposeGestureEnabled -bool YES
defaults write com.apple.dock mru-spaces -bool NO
defaults write com.apple.dock expose-group-apps -bool YES
killall Dock

# Safari
# Under Privacy needs Full Disk Access
defaults write com.apple.Safari AutoFillPasswords -bool YES
defaults write com.apple.Safari AutoFillCreditCardData -bool YES
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool NO
defaults write com.apple.Safari IncludeInternalDebugMenu -bool YES
defaults write com.apple.Safari IncludeDevelopMenu -bool YES
defaults write com.apple.Safari ShowIconsInTabs -bool YES
defaults write com.apple.Safari ShowFavorites -bool YES
defaults write com.apple.Safari ShowCloudTabsInFavorites -bool YES
defaults write com.apple.Safari ShowPrivacyReportInFavorites -bool NO
defaults write com.apple.Safari ShowBackgroundImageInFavorites -bool NO
defaults write com.apple.Safari ShowFrequentlyVisitedSites -bool NO
defaults write com.apple.Safari ShowSiriSuggestionsPreference -bool NO
defaults write com.apple.Safari ShowReadingListInFavorites -bool NO
defaults write com.apple.Safari ReadingListSaveArticlesOfflineAutomatically -bool YES
defaults write com.apple.Safari ShowOverlayStatusBar -bool YES
defaults write com.apple.Safari AlwaysShowTabBar -bool NO
defaults write com.apple.Safari PrintHeadersAndFooters -bool NO
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool YES
defaults write com.apple.Safari CanPromptForPushNotifications -bool NO
defaults write com.apple.Safari NeverUseBackgroundColorInToolbar -bool YES
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool NO
defaults write com.apple.Safari AutoOpenSafeDownloads -bool NO
defaults write com.apple.Safari WebKitPreferences.privateClickMeasurementEnabled -bool NO
defaults write com.apple.Safari EnableEnhancedPrivacyInRegularBrowsing -bool NO
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool YES
defaults write com.apple.Safari BlockStoragePolicy -int 1
defaults write com.apple.Safari UseHTTPSOnly -bool YES
defaults write -g WebKitDeveloperExtras -bool YES

# Contacts
# Under Privacy needs Contacts
defaults write com.apple.AddressBook ABNameSortingFormat -string 'sortingFirstName sortingLastName'

# Mail
# Under Privacy needs Full Disk Access
defaults write com.apple.mail ConversationViewMarkAllAsRead -bool YES
defaults write com.apple.mail ShouldHideHighlights -bool YES
defaults write com.apple.mail ColorQuoterColorIncoming -bool NO
defaults write com.apple.mail NewMessagesSoundName -string Blow

# Messages
defaults write ~/Library/Containers/com.apple.tonelibraryd/Data/Library/Preferences/com.apple.ToneLibrary.plist sms-sound-identifier -string texttone:Bamboo

# Calendar
defaults write com.apple.iCal showDeclinedEvents -bool YES
defaults write com.apple.iCal 'Show Week Numbers' -bool YES
defaults write com.apple.iCal 'Show heat map in Year View' -bool YES
defaults write com.apple.iCal 'Default duration in minutes for new event' -float 30

# Calculator
defaults write com.apple.calculator ViewDefaultsKey -string Scientific
defaults write com.apple.calculator PaperTapeVisibleDefaultsKey -bool YES

# Reminders
# Specify time in hours format like 1000
defaults write com.apple.remindd todayNotificationFireTime -int -1
defaults write com.apple.remindd showRemindersAsOverdue -bool YES
defaults write com.apple.remindd shouldIncludeRemindersDueTodayInBadgeCount -bool NO
defaults write com.apple.remindd enableAssignmentNotifications -bool YES

# Image Capture
# Show the details panel
defaults write com.apple.Image_Capture IK_scannerDisplayMode -int 1
defaults write com.apple.Image_Capture IK_ScanResolution -int 300
defaults write com.apple.Image_Capture IK_CreateSingleDocument -bool YES
# Fall back to default of US letter
defaults write com.apple.Image_Capture IK_UseCustomScanSize -int 0
# Save scans as PDFs
defaults write com.apple.Image_Capture IK_FileFormatTagColor -int 7
# Set scan location from predefined list to ~/Downloads
# IK_Scanner_selectedTag overrides IK_Scanner_downloadURL
defaults write com.apple.Image_Capture IK_Scanner_selectedTag -int 1004

# Vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
cd ~/.vim/plugged/YouCompleteMe
./install.py --go-completer

# Reeder
defaults write com.reederapp.5.macOS items.leading-swipe -int 19
defaults write com.reederapp.5.macOS items.trailing-swipe -int 1
defaults write com.reederapp.5.macOS corekit.animator.configuration -int 2
defaults write com.reederapp.5.macOS app.icon-badge -int 0
defaults write com.reederapp.5.macOS app.layout -int 0
defaults write com.reederapp.5.macOS app.item-order -int -1
defaults write com.reederapp.5.macOS app.item-group-by-feed -bool YES
defaults write com.reederapp.5.macOS article.pull-to-next-prev -bool NO
defaults write com.reederapp.5.macOS bionic.toolbar -bool NO
defaults write com.reederapp.5.macOS browser.open-links-in-default-browser -bool YES
defaults write com.reederapp.5.macOS toolbar.com.reederapp.internal.ReadLater -bool YES
defaults write com.reederapp.5.macOS app.toolbar-sharing-services -array com.apple.share.AirDrop.send com.reederapp.internal.ReadLater com.reederapp.internal.CopyLink
defaults write com.reederapp.5.macOS Cloud/default -dict syncing.interval '<integer>15</integer>' syncing.on-wake '<true/>'
defaults write com.reederapp.5.macOS ReadLater/default -dict syncing.interval '<integer>15</integer>' syncing.on-wake '<true/>'
defaults write com.reederapp.5.macOS shortcuts -dict-add item.toggle-read \
 '<dict>
    <key>keyEquivalent</key>
    <string>U</string>
    <key>modifierFlags</key>
    <integer>131072</integer>
  </dict>'

# NetNewsWire
defaults write com.ranchero.NetNewsWire-Evergreen refreshInterval -int 2
defaults write com.ranchero.NetNewsWire-Evergreen windowState -dict-add readFeedsFilterState '<true/>'
defaults write com.ranchero.NetNewsWire-Evergreen SUEnableAutomaticChecks -bool YES

# Mimestream
defaults write com.mimestream.Mimestream TrailingEdgeSwipeAction -string trash
defaults write com.mimestream.Mimestream LeadingEdgeSwipeAction -string archive
defaults write com.mimestream.Mimestream ListStyle -string expanded
defaults write com.mimestream.Mimestream HideBadgeForSpam -bool YES

# Paste
defaults write com.wiheads.paste-direct kPSTPreferencesEnableSoundEffects -bool NO
defaults write com.wiheads.paste-direct always-paste-as-plain-text -bool YES
defaults write com.wiheads.paste-direct kPSTPreferencesBlackAppsBundles -array com.apple.keychainaccess com.apple.Passwords com.1password.1password

# Fork
defaults write com.DanPristupov.Fork applicationUpdateChannel -int 1
defaults write com.DanPristupov.Fork terminalClient -int 1
defaults write com.DanPristupov.Fork externalDiffTool -int 10
defaults write com.DanPristupov.Fork mergeTool -int 10
defaults write com.DanPristupov.Fork defaultSourceFolder -string "${HOME}/Developer"

# Crouton
defaults write com.meal.plan.ios username -string Ashish
defaults write com.meal.plan.ios shouldDetectWebsites -bool NO
defaults write com.meal.plan.ios showDiscover -bool NO

# Vinegar
defaults write com.andadinosaur.Vinegar.MacExtension advanced -bool NO
defaults write com.andadinosaur.Vinegar.MacExtension showToolbar -bool NO
defaults write com.andadinosaur.Vinegar.MacExtension quality -string auto

# AppCleaner
defaults write net.freemacsoft.AppCleaner SUEnableAutomaticChecks -bool YES
defaults write net.freemacsoft.AppCleaner SUAutomaticallyUpdate -bool YES

# Rectangle
defaults write com.knollsoft.Rectangle SUEnableAutomaticChecks -bool YES
defaults write com.knollsoft.Rectangle launchOnLogin -bool YES
defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -bool YES
defaults write com.knollsoft.Rectangle windowSnapping -int 1
defaults write com.knollsoft.Rectangle todo -int 1
defaults write com.knollsoft.Rectangle footprintAnimationDurationMultiplier -float 0.75

# Ivory
defaults write com.tapbots.Ivory mediaPlaybackType -int 1

# Things
defaults write com.culturedcode.ThingsMac CCDockCountType -int 1

# BBEdit
defaults write com.barebones.bbedit EditorSoftWrap -bool YES
defaults write com.barebones.bbedit SoftWrapStyle -int 2
defaults write com.barebones.bbedit EditingWindowShowPageGuide -bool NO
defaults write com.barebones.bbedit Search_WrapAround -bool YES

# IINA
defaults write com.colliderli.iina showRemainingTime -bool YES
defaults write com.colliderli.iina SUEnableAutomaticChecks -bool YES
defaults write com.colliderli.iina resumeLastPosition -bool YES

# Siri
defaults write com.apple.Siri StatusMenuVisible -bool YES
defaults write com.apple.Siri TypeToSiriEnabled -bool YES
defaults write com.apple.Siri VoiceTriggerUserEnabled -bool YES

# iTerm2
defaults write com.googlecode.iterm2 PrefsCustomFolder -string '~/.config/iterm2'
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
