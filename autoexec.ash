###########################################
sleep 3
lu_util exec '/tmp/fuse_d/SCRIPTS/wifi_set.sh'
###########################################
# enabled telnet (optional)
lu_util exec 'if [ ! -f /tmp/fuse_d/enable_info_display.script ]; then touch /tmp/fuse_d/enable_info_display.script; fi'
###########################################

# put your favorite setting here

###########################################
