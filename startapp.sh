#!/bin/bash
exec LD_PRELOAD=/usr/lib/libstdc++.so.6 QT_QPA_PLATFORM=xcb QT_STYLE_OVERRIDE="" /usr/share/cura/Ultimaker_Cura.AppImage --appimage-extract-and-run .