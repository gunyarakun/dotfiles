#!/bin/bash
script_name=$0
script_dir=$(cd "$(dirname "$0")" && pwd)

if [ ! -d ~/.pi/agent ]; then
  mkdir -p ~/.pi/agent
fi
ln -snf ${script_dir}/settings.json ~/.pi/agent/settings.json
