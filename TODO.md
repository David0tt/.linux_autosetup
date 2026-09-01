# TODO: 

# reduce the time after which the windows are shown when hovering over the taskbar
# Set alacritty as terminal emulator default
# Set up all the tiling-wm features for kde plasma 


I have a Roccat Vulcan 122 keyboard with LED lights. How can i control these from my linux machine (CachyOS with sway)? 

On windows, i used roccat swarm for this. I liked to have the setup, where keys would light up on keypress and then fade. 

However, for now i would be fine with just turning off the LEDs entirely. How can i do this? 


# clean up .linux_autosetup git, so the .linux_autosetup does not include the sway changes anymore

# Make the lockscreen look nicer


# Clean up README.md


# Do a code pass: are there any errors / mistakes / things to improve in the config?


# Set up Mullvad + VM environment 

# Clean up the KGlobalShortcuts file again for better alacritty as terminal hotkey
# Maybe different hotkeys from KGlobalShortcuts are not needed


# Discord does not start on Wayland -> Now it does


# mpv support in player control -> Not really needed
# Make YouTube preview images larger (scaled in height direction)

# for some reason, spotify does not start on wayland anymore


# Set up google drive



# Fix "Another instance of code is running" error at system startup; This only happens on logout/login, not on full system restart

# TODO maybe i can use a windows 11 VM only for office apps

# Fix dolphin "open terminal here" should open alacritty




# check whether i3 workspace icons exists for sway


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



# Learning: I can control screen brightness using 
ddcutil --display 1 getvcp 10
ddcutil --display 1 setvcp 10 + 5
ddcutil --display 1 setvcp 10 - 5
ddcutil detect --brief # can be used to detect the display number

Did this driver work to translate ddci to brightnessctl?
sudo pacman -S ddcci-driver-linux-dkms



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


# Try zed as editor (should have remote support, should integrate copilot; try other featurs (diff view, LSP support, autoformatter, )

# The y flag in pacman does not do what i thought it does, for auto-confirm, --noconfirm can be used (but risky, since it ignores some user prompts pacmans -Sy is generally always discouraged) -> ask chat, what an appropriate way to do my install would be


# There is a bug: after clicking on the "HDR" button on the sway waybar, the whole sway waybar turns into the hdr toggle button, so if i afterwards click anywhere on the waybar, it toggles HDR, this can be fixed with a sway reload




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