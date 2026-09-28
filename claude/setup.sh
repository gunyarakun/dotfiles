#!/bin/bash
script_name=$0
script_dir=$(cd "$(dirname "$0")" && pwd)

if [ ! -d ~/.claude ]; then
  mkdir ~/.claude
fi
ln -snf ${script_dir}/settings.json ~/.claude/settings.json
ln -snf ${script_dir}/hooks ~/.claude/hooks

skills_dir=$(cd "${script_dir}/../agents/skills" && pwd)
if [ -d ~/.claude/skills ] && [ ! -L ~/.claude/skills ]; then
  # ~/.claude/skills is a real directory (e.g. gstack lives there), so
  # ln -snf would nest the link inside it; link each skill instead
  for skill in "${skills_dir}"/*; do
    [ -e "${skill}/SKILL.md" ] || continue
    ln -snf "${skill}" ~/.claude/skills/
  done
else
  ln -snf "${skills_dir}" ~/.claude/skills
fi
