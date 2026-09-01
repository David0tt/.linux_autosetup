# TODO: 

# reduce the time after which the windows are shown when hovering over the taskbar
# Set alacritty as terminal emulator default
# Set up all the tiling-wm features for kde plasma 


# clean up .linux_autosetup git, so the .linux_autosetup does not include the sway changes anymore


# Clean up README.md


# Do a code pass: are there any errors / mistakes / things to improve in the config?


# Set up Mullvad + VM environment 

# Clean up the KGlobalShortcuts file again for better alacritty as terminal hotkey
# Maybe different hotkeys from KGlobalShortcuts are not needed


# Set up google drive



# Fix "Another instance of code is running" error at system startup; This only happens on logout/login, not on full system restart

# TODO maybe i can use a windows 11 VM only for office apps
    -> This seems like a good project: https://github.com/winapps-org/winapps

# Fix dolphin "open terminal here" should open alacritty (pcmanfm just informs at first startup, that no terminal emulator is set alacritty)



# try to get lol to run (maybe in VM with gpu passthrough with one with iGPU/dGPU); 

# get office apps to work -> try full VM or WinApps; Lutris; 

# add to Readme: install_script.sh assumes to start off with a fresh ubuntu/gnome installation; install_script_CachyOS.sh assumes CashyOS/KDE. I am using these, since they provide a good baseline for packages for the general system, and prevent me from running into many issues down the line which i would have to manually fix by mostly by installing packages and setting up configuration. Further, i sometimes need the gui desktop as a fallback (e.g. to show something to a non-computer-literate person that would be distracted by the tiling WM, or e.g. for gaming or screenshares (zoom) which just work better in the full gui environment)


# LEARNING: Idle Watt usage is at 130W in CachyOS+Sway; I think on Windows it was much higher, but need to check
- CachyOS + Sway; normal desktop load (VSCode, YouTube running): 130W
- CachyOS + Sway; Fully Idle:
- CachyOS + KDE Plasma; normal desktop load: 
- CachyOS + KDE Plasma; fully idle: 
- Windows; normal desktop load:
- Windows; fully idle: 



# On power consumption: 
# To show which performance mode the CPU is in
watch -n 1 "grep . /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference"
# Check whether boost is enabled (0->Off, 1->On): 
cat /sys/devices/system/cpu/cpu*/cpufreq/boost
# Both change, when i cycle through the power-saver widget
# If the PC has an integrated GPU, it would be an option to fully switch to it, but my CPU currently does not have one



# The tray entry for network is shown in dark gray, previously it was white. How can i make it white again
# All menues opened from the tray (e.g. right-click on bluetooth icon) are now as large as the one for poweroff/shutdown/logout/..., please make the other ones their original size again. Only the one for power options should be so large



# Opening Bitlocker encrypted drives
# Note: The mounted disk performance is surprisingly fast, with 160MB/s R/W

sudo mkdir -p /media/bitlocker_data
sudo cryptsetup bitlkOpen /dev/sda2 bitlocker_drive_data --verbose --debug
sudo mount -t ntfs3 /dev/mapper/bitlocker_drive_data /media/bitlocker_data
# Unmount
sudo umount /media/bitlocker_data
sudo cryptsetup close bitlocker_drive_data

sudo mkdir -p /media/bitlocker_c
sudo cryptsetup bitlkOpen /dev/nvme0n1p3 bitlocker_drive_c --verbose --debug
# Normally one would like to do: 
sudo mount -t ntfs3 /dev/mapper/bitlocker_drive_c /media/bitlocker_c
# But this fails since the drive is "dirty" (probably due to fast-boot/hybernate)
# To open it safely, mount it with read only, force
sudo mount -t ntfs3 -o ro,force /dev/mapper/bitlocker_drive_c /media/bitlocker_c
# Unmount
sudo umount /media/bitlocker_c
sudo cryptsetup close bitlocker_drive_c


sudo mkdir -p /media/bitlocker_games
sudo cryptsetup bitlkOpen /dev/nvme1n1p2 bitlocker_drive_games --verbose --debug
# sudo mount -t ntfs3 /dev/mapper/bitlocker_drive_games /media/bitlocker_games
sudo mount -t ntfs3 -o ro,force /dev/mapper/bitlocker_drive_games /media/bitlocker_games
# Unmount
sudo umount /media/bitlocker_games
sudo cryptsetup close bitlocker_drive_games




# Try Zed


# Try meta quest on cachy


# Try zed as editor (should have remote support, should integrate copilot; try other featurs (diff view, LSP support, autoformatter, ) -> I did not like it

# The y flag in pacman does not do what i thought it does, for auto-confirm, --noconfirm can be used (but risky, since it ignores some user prompts pacmans -Sy is generally always discouraged) -> ask chat, what an appropriate way to do my install would be




Publish new workspace icon daemon. 
Note to users: 
- This system is quite hacky. If you want something simpler, you can use the default approach of mapping programs to nerdfont symbols
    - Pros: This is more tried and tested
    - Con: You don't get the actual icons; You don't get the icons automatically
- Add to "inspiration" section: https://github.com/j-waters/sway-dynamic-names


- post to this post https://github.com/swaywm/sway/issues/4882 ; And maybe some others

# TODO try google drive integration in KDE plasma dolphin
# TODO maybe in nautilus it is better
# However, i guess both are not syncs, only streaming









# install docker
# Try getting Windows to work (maybe in Docker, like Omarchy)

# Get Video Conferences / Screen Sharing to work (teams, zoom, discord)#




# For now, i just want to dual boot CachyOS and Windows on the Surface Pro9




# Special for Surface: 
    - Get surface specific drivers to work
        - Touchpad, pen, camera
    - Get keyboard to work in limine to enable unlocking disk encryption
    - Get nice KDE plasma unlock screen (-> Probably be fully reinstalling and not selecting sway)
    - enable secure boot again



# Missing to fully switch to CachyOS:
    - External drives on main PC and Images should be managed
    - Can i just install CachyOS on the Games partition? (should also be a 1TB SSD)