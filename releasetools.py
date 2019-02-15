# Copyright (C) 2012 The Android Open Source Project
# Copyright (C) 2019 The LineageOS Project
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

import hashlib
import common
import re

def FullOTA_InstallBegin(info):
  info.script.Mount("/system")
  resizeSystemPartition(info)
  info.script.Unmount("/system")
  return

def IncrementalOTA_InstallBegin(info):
  info.script.Mount("/system")
  resizeSystemPartition(info)
  info.script.Unmount("/system")
  return

def resizeSystemPartition(info):
  info.script.AppendExtra('package_extract_file("install/bin/parted", "/tmp/parted");');
  info.script.AppendExtra('package_extract_file("install/bin/repartition.sh", "/tmp/repartition.sh");');
  info.script.AppendExtra('set_metadata("/tmp/parted", "uid", 0, "gid", 0, "mode", 0755);');
  info.script.AppendExtra('set_metadata("/tmp/repartition.sh", "uid", 0, "gid", 0, "mode", 0755);');
  info.script.AppendExtra('ui_print("Checking size of the partitions...");');
  info.script.AppendExtra('if run_program("/tmp/repartition.sh") == 0 then');
  info.script.AppendExtra('abort("Invalid partition table detected. Perhaps, you already tried to resize your partitions. You must restore original partition table before installation");');
  info.script.AppendExtra('endif;');
