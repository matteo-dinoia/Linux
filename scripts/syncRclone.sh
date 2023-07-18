#!/bin/sh
echo "Starting copy of: Documents (except syncRclone)"
echo "-----------------------------------------------"
rclone sync -P --exclude=syncRclone.sh /home/matteo/Documents DriveScuola:/RClone/SchoolShare/
echo "-----------------------------------------------"
echo "Done" && exit


