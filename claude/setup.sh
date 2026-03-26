#!/bin/bash
script_name=$0
script_dir=$(cd "$(dirname "$0")" && pwd)

if [ ! -d ~/.claude ]; then
  mkdir ~/.claude
fi
ln -snf ${script_dir}/settings.json ~/.claude/settings.json
ln -snf ${script_dir}/skills ~/.claude/skills
