#!/bin/bash

# Script detects system architecture, then downloads and installs the appropriate Medibuntu repository.. 

shopt -s nocasematch
echo
echo "This script installs the Medibuntu repo of packages. There may be some legal restriction on its use depending upon your jurisditcion. Please proceed with caution."
echo
read -p "Do you wish to continue? (Y/N): "

case $REPLY in
y|yes) # If Yes, Continue with script
  sudo wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo aptitude --quiet update && sudo aptitude --assume-yes --quiet --allow-untrusted install medibuntu-keyring && sudo aptitude --quiet update
  sudo aptitude --assume-yes install app-install-data-medibuntu apport-hooks-medibuntu && sudo aptitude --assume-yes --quiet dist-upgrade && sudo aptitude install libdvdcss2

# Detect Architecture and install appropriate software
  case `uname -m` in
  i?86|k7)
    sudo aptitude install w32codecs
    ;;
  x86_64)
    sudo aptitude install w64codecs
    ;;
  ppc|ppc64)
    sudo aptitude install ppc-codecs
    ;;
  *)
    echo
    echo "No suitable multimedia codecs found for `uname -m`"
    ;;
  esac ;;
 
*) # If not Yes, terminate script
  echo "You must answer Yes to continue.  Terminating script"
  ;;
esac
