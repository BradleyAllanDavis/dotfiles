#!/usr/bin/env bash

# Install command line tools if not installed
if type xcode-select >&- && xpath=$( xcode-select --print-path ) && test -d "${xpath}" && test -x "${xpath}" ; then
  xcode-select --install
fi

sudo xcodebuild -license accept

# vim: ft=sh syn=sh
