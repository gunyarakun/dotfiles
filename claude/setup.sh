#!/bin/bash
script_name=$0
script_dir=$(dirname "$0")

ln -h ${script_dir}/settings.json ~/.claude/settings.json
