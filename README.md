TWRP 3.2.3.x for u8833
====================
To get started with OMNI ROM, you'll need to get familiar with Git and Repo:
https://source.android.com/source/using-repo.html
But for TWRP recovery, we don't need full OMNI ROM sourcecode and minimal sourcecode would be fine.
To initialize your local repository using the OMNI ROM trees to build TWRP, use a command like this:

    repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-4.4

To initialize a shallow clone, which will save even more space, use a command like this:

    repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-4.4
    
*** Change project bootable/recovery to newest branch, currect is android-9.0 in default.xml ***
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Well, maybe need to add full device tree, but we will still use prebuilts:

    cd .repo
    mkdir local_manifests
    cd local_manifests
    wget https://raw.githubusercontent.com/adeii/twrp_device_huawei_u8833/3230/msm7x27a-LP.xml
    cd ../..
   
Then to sync up:

    repo sync --force-sync --no-clone-bundle --no-tags
    
Then add u8833 device tree:

    mkdir device/huawei
    cd device/huawei
    git clone https://github.com/adeii/twrp_device_huawei_u8833.git u8833
    
*** Apply twrp.patch ***
++++++++++++++++++++++++
     
     cp device/huawei/u8833/twrp.patch . 
     sh ./repo-apply-patch.sh twrp.patch
       
Then to build:

    cd < sourcecode root >
    . build/envsetup.sh
    lunch omni_u8833-eng
    mka recoveryimage
