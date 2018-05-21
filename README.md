TWRP 3.x.x for u8833
====================
To get started with OMNI ROM, you'll need to get familiar with Git and Repo:
https://source.android.com/source/using-repo.html
But for TWRP recovery, we don't need full OMNI ROM sourcecode and minimal sourcecode would be fine.
To initialize your local repository using the OMNI ROM trees to build TWRP, use a command like this:

    repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-5.1

To initialize a shallow clone, whcih will save even more space, use a command like this:

    repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-5.1

Then to sync up:

    repo sync --force-sync --no-clone-bundle --no-tags

Then add u8833 device tree:

    mkdir device/huawei
    cd device/huawei
    git clone https://github.com/adeii/twrp_device_huawei_u8833.git
    mv twrp_device_huawei_u8833 u8833

Then to build:

    cd ../..
    . build/envsetup.sh
    lunch omni_u8833-eng
    mka recoveryimage
    
NOTE:
=====
TWRP 3.1.x should be last version of recovery using twrp-4.4 branch, using 4.4 kernel, supporting till Android 7.1.
TWRP 3.2+ must using at least twrp-5.1 branch, still using 4.4 kernel and whole tree as previous versions (thanks, Ceastel), supporting Android 8.1.
Since Android 7.0, /misc partition must be included in booting process and must be readen before /boot.
Huawei MSM8225 phones do not need nor use this partition (IFAIK), but TWRP 3.2+ recovery read it.
And /misc partition must be clean/wiped to jump off recovery loop, or jump to normal boot (partition /boot).
To do it so, workaround is made. Before "Reboot to system", open Terminal in TWRP and type and execute:

     misc.sh

Ignore error about 4MB partition /misc is full and no free space.
If not, or just power off TWRP, phone will goes to recovery mode again.
Maybe "Reboot to bootload mode" and "Reboot to download mode" also reboot phone to recovery mode, not tested.
