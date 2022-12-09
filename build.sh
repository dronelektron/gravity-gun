#!/bin/bash

PLUGIN_NAME="gravity-gun"

cd scripting
spcomp $PLUGIN_NAME.sp -i include -o ../plugins/$PLUGIN_NAME.smx
