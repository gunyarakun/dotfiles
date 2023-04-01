#!/bin/bash
script_name=$0
script_dir=$(dirname "$0")

ln -h ${script_dir}/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -h ${script_dir}/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
