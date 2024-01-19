#!/bin/bash

mkdir ~/tmp
cp ~/.idm/uex/wordfiles/worknotes.uew ~/tmp/
rm -rfd ~/.idm/uex
rm -rf ~/.idm/*.spl
rm -rf /tmp/*.spl
uex &
cp ~/tmp/worknotes.uew ~/.idm/uex/wordfiles/
