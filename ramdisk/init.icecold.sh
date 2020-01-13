#!/system/bin/sh
# PureCAFx Reborn Ramdisk Files
# Based On KudProject Development

# Allows us to get init-rc-like style
write() { echo "$2" > "$1"; }

# CPU Values
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor blu_schedutil
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 2016000
write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 652000

# GPU 
write /sys/class/kgsl/kgsl-3d0/devfreq/governor "msm-adreno-tz"
write /sys/class/kgsl/kgsl-3d0/max_gpuclk 650000000
write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 650000000
write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 133330000

# Thermal
chmod 0644 /sys/module/msm_thermal/parameters/enabled
write /sys/module/msm_thermal/parameters/enabled 1
chmod 0644 /sys/module/msm_thermal/core_control/enabled
write /sys/module/msm_thermal/core_control/enabled 0
chmod 0644 /sys/module/msm_thermal/vdd_restriction/enabled

# I/O scheduler
write /sys/block/mmcblk0/queue/scheduler cfq
write /sys/block/mmcblk1/queue/scheduler cfq

# Disable slice_idle on supported block devices
for block in mmcblk0 mmcblk1 dm-0 dm-1 sda; do
    write /sys/block/$block/queue/iosched/slice_idle 0
done

