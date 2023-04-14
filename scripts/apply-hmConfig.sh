#!/bin/sh

nix build .#hmConfig.bradley.activationPackage
./result/activate
