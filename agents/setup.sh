#!/bin/bash
script_name=$0
script_dir=$(cd "$(dirname "$0")" && pwd)

# Agent Skills (cross-agent standard path, read by OpenCode, skills CLI, etc.)
if [ ! -d ~/.agents ]; then
  mkdir ~/.agents
fi

# ln -snf into an existing real directory would nest the link inside it
if [ -d ~/.agents/skills ] && [ ! -L ~/.agents/skills ]; then
  echo "~/.agents/skills is a real directory; merge it into ${script_dir}/skills and remove it first" >&2
  exit 1
fi
ln -snf ${script_dir}/skills ~/.agents/skills

# lock file for the skills CLI (npx skills), so installs are tracked in dotfiles
ln -snf ${script_dir}/skill-lock.json ~/.agents/.skill-lock.json
