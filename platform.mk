# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

$(call inherit-product, device/sony/common/common.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, hardware/broadcom/wlan/bcmdhd/config/config-bcm.mk)

SOMC_PLATFORM := kitakami

SONY_ROOT := device/sony/kitakami/rootdir

# Media
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/system/etc/aanc_tuning_mixer.txt:system/etc/aanc_tuning_mixer.txt \
    $(SONY_ROOT)/system/etc/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(SONY_ROOT)/system/etc/audio_platform_info_i2s.xml:system/etc/audio_platform_info_i2s.xml \
    $(SONY_ROOT)/system/etc/media_codecs.xml:system/etc/media_codecs.xml \
    $(SONY_ROOT)/system/etc/media_profiles.xml:system/etc/media_profiles.xml

# Broadcom BT
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/system/etc/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

# IDC
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/system/usr/idc/clearpad.idc:system/usr/idc/clearpad.idc \
    $(SONY_ROOT)/system/usr/idc/touch_fusion.idc:system/usr/idc/touch_fusion.idc

# Keylayout
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/system/usr/keylayout/clearpad.kl:system/usr/keylayout/clearpad.kl \
    $(SONY_ROOT)/system/usr/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(SONY_ROOT)/system/usr/keylayout/mhl-rcp.kl:system/usr/keylayout/mhl-rcp.kl \
    $(SONY_ROOT)/system/usr/keylayout/msm8994-tomtom-snd-card_Button_Jack.kl:system/usr/keylayout/msm8994-tomtom-snd-card_Button_Jack.kl \
    $(SONY_ROOT)/system/usr/keylayout/touch_fusion.kl:system/usr/keylayout/touch_fusion.kl

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    $(SONY_ROOT)/system/etc/msm_irqbalance.conf:system/etc/msm_irqbalance.conf

# TORCH
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/torch/torch:system/bin/torch

# Device Specific Hardware
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml

DEVICE_PACKAGE_OVERLAYS += \
    device/sony/kitakami/overlay

# Platform Init
PRODUCT_PACKAGES += \
    fstab.kitakami \
    init.kitakami.pwr

# NFC packages
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    NfcNci \
    nfc_nci.pn54x.default \
    Tag
    
# ANT+
PRODUCT_COPY_FILES += \
    external/ant-wireless/antradio-library/com.dsi.ant.antradio_library.xml:system/etc/permissions/com.dsi.ant.antradio_library.xml

PRODUCT_PACKAGES += \
    AntHalService \
    com.dsi.ant.antradio_library \
    libantradio

# Recovery
PRODUCT_PACKAGES += \
    init_sony \
    toybox_static \
    keycheck

# Audio
PRODUCT_PACKAGES += \
    audio.primary.msm8994

# GFX
PRODUCT_PACKAGES += \
    copybit.msm8994 \
    gralloc.msm8994 \
    hwcomposer.msm8994 \
    memtrack.msm8994

# GPS
PRODUCT_PACKAGES += \
    gps.msm8994

# CAMERA
PRODUCT_PACKAGES += \
    camera.msm8994

# Keymaster
PRODUCT_PACKAGES += \
    keystore.msm8994

# FM
PRODUCT_PACKAGES += \
    FMRadio \
    brcm-uim-sysfs \
    libfmjni

# VR HAL
PRODUCT_PACKAGES += \
    vr.sumire

# Enable low power video mode for 4K encode
PRODUCT_PROPERTY_OVERRIDES += \
    vidc.debug.perf.mode=2 \
    vidc.enc.dcvs.extra-buff-count=2

# for perfd
PRODUCT_PROPERTY_OVERRIDES += \
    ro.min_freq_0=384000
    ro.min_freq_4=384000

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=libqti-perfd-client.so

PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/vendor/lib64/libril-qc-qmi-1.so

PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_cdma_sub=0

# LTE, CDMA, GSM/WCDMA
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=10 \
    telephony.lteOnCdmaDevice=1 \
    persist.radio.mode_pref_nv10=1 \
    ro.telephony.get_imsi_from_sim=true

PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.apm_sim_not_pwdn=1

# Setup custom emergency number list based on the MCC. This is needed by RIL
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.custom_ecc=1

# Enable Wifi calling
PRODUCT_PROPERTY_OVERRIDES += \
    persist.data.iwlan.enable=true

# Request modem to send PLMN name always irrespective
# of display condition in EFSPN.
# RIL uses this property.
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.always_send_plmn=true

# If data_no_toggle is 0 there are no reports if the screen is off.
# If data_no_toggle is 1 then dormancy indications will come with screen off.
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.data_no_toggle=1

# Allow tethering without provisioning app
PRODUCT_PROPERTY_OVERRIDES += \
    net.tethering.noprovisioning=true

# Ril sends only one RIL_UNSOL_CALL_RING, so set call_ring.multiple to false
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.call_ring.multiple=0

# Update 1x signal strength after 2s
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.radio.snapshot_enabled=1 \
    persist.radio.snapshot_timer=2

PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196609

# aDSP sensors
## max rate
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qti.sensors.max_accel_rate=false \
    ro.qti.sensors.max_gyro_rate=false \
    ro.qti.sensors.max_mag_rate=false \
    ro.qti.sensors.max_geomag_rotv=50

# IO Scheduler
PRODUCT_PROPERTY_OVERRIDES += \
    sys.io.scheduler=bfq

# setup dalvik vm configs.
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)


# only include verity on user builds for CM
ifeq ($(TARGET_BUILD_VARIANT),user)
  PRODUCT_COPY_FILES += device/sony/sumire/fstab-verity.sumire:root/fstab.sumire

  # setup dm-verity configs.
  PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/platform/soc.0/f9824900.sdhci/by-name/system
  # don't check verity on vendor partition as we don't compile it with the boot and system image
  # PRODUCT_VENDOR_VERITY_PARTITION := /dev/block/platform/soc.0/f9824900.sdhci/by-name/vendor
  $(call inherit-product, build/target/product/verity.mk)
endif

## sensor type
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qti.sensors.wu=true
