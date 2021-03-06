#!/bin/bash

FRAMEWORK_VER='1.145.0'
PLATFORM_VER='4.3.0'

FRAMEWORK_URL="https://bintray.com/platformio/dl-packages/download_file?file_path=framework-arduinoteensy-${FRAMEWORK_VER}.tar.gz"
PLATFORM_URL="https://github.com/platformio/platform-teensy/archive/v${PLATFORM_VER}.tar.gz"

rm -rf patched && mkdir patched && cd patched
wget "${FRAMEWORK_URL}" -O framework-arduinoteensy-${FRAMEWORK_VER}.tar.gz && \
wget "${PLATFORM_URL}" -O platform-teensy-${PLATFORM_VER}.tar.gz && \
mkdir framework-arduinoteensy && \
tar xzf framework-arduinoteensy-${FRAMEWORK_VER}.tar.gz -C framework-arduinoteensy && \
tar xzf platform-teensy-${PLATFORM_VER}.tar.gz && \
mv platform-teensy-${PLATFORM_VER} teensy && \
patch -p1 -d framework-arduinoteensy/cores < ../framework-arduinoteensy-ds4/00-teensy-cores.patch && \
patch -p0 -d framework-arduinoteensy < ../framework-arduinoteensy-ds4/01-add-ds4-options-in-boards-txt.patch && \
patch -p0 < ../framework-arduinoteensy-ds4/99-pfio-package-name.patch && \
patch -p0 < ../platform-teensy.patch && \
mv framework-arduinoteensy framework-arduinoteensy-ds4 && \
mv teensy teensy-ds4
