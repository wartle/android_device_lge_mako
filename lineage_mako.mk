# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 768

# Lineage Charger
WITH_LINEAGE_CHARGER := false

# Dexpreopt
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := true
WITH_DEXPREOPT_DEBUG_INFO := false

# The target has no boot jars to check
SKIP_BOOT_JARS_CHECK := true

# Inherit from the common product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit from the Lineage vendor
$(call inherit-product, vendor/lineage/config/common_mini_go_phone.mk)
$(call inherit-product, vendor/lineage/build/target/product/product_launched_with_j_mr1.mk)

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/lge/mako/device.mk)
$(call inherit-product, vendor/lge/mako/mako-vendor.mk)

# Common Android Go configurations
$(call inherit-product, build/target/product/go_defaults.mk)

# Dalvik (2 GB configuration)
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := mako
PRODUCT_NAME := lineage_mako
PRODUCT_BRAND := google
PRODUCT_MODEL := Nexus 4
PRODUCT_MANUFACTURER := LGE

PRODUCT_GMS_CLIENTID_BASE := android-google

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=occam \
    PRIVATE_BUILD_DESC="occam-user 5.1.1 LMY48T 2237560 release-keys"

BUILD_FINGERPRINT := google/occam/mako:5.1.1/LMY48T/2237560:user/release-keys
