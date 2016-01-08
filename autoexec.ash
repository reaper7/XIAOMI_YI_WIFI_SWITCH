###########################################
sleep 3
# start wifi_set.sh with mode selected by shutter button
lu_util exec '/tmp/fuse_d/SCRIPTS/wifi_set.sh'
# or start wifi_set.sh with any parameter for forced STA MODE
#lu_util exec '/tmp/fuse_d/SCRIPTS/wifi_set.sh 1'
###########################################
# enabled telnet (optional)
lu_util exec 'if [ ! -f /tmp/fuse_d/enable_info_display.script ]; then touch /tmp/fuse_d/enable_info_display.script; fi'
###########################################

# put your favorite setting here

###########################################
