#!/bin/bash
#==========================================================================
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#==========================================================================
# Description:
#   This is to get the crash reports of submitted/pending.
#
# Author: Askeing Yen, Naoki Hirata, Walter Chen,
#==========================================================================

set -e

if [ -f crashreports.txt ]
then
rm crashreports.txt
fi

echo "Getting root for device"
adb root
echo "Submitted crash reports" > crashreports.txt
adb shell ls -al /data/b2g/mozilla/Crash\ Reports/submitted >> crashreports.txt
echo "Pending crash reports" >> crashreports.txt
adb shell ls -al /data/b2g/mozilla/Crash\ Reports/pending >> crashreports.txt

cat crashreports.txt

echo -e "\n### The links of submitted crash reports:"
cat crashreports.txt | grep "bp-" | sed s/.*bp-/https:\\/\\/crash-stats\.mozilla\.com\\/report\\/index\\//g | sed s/\.txt//g
