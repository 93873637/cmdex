#!/bin/bash

# Extend Modules Array
EX_MODS=(
  ubuntu
  isaac
  ginger
  # Add new extend modules here which defined on $CMDEX_HOME/ex
)

# Test
: '
echo
echo "** test EX_MODS array"
echo "** EX_MODS = ${EX_MODS[@]}"
echo "** len(EX_MODS) = ${#EX_MODS[@]}"
echo "** EX_MODS[0] = ${EX_MODS[0]}"
echo "** len(EX_MODS[0]) = ${#EX_MODS[0]}"
for i in "${!EX_MODS[@]}"; do
  echo "Element[$i] = ${EX_MODS[$i]}"
done
echo
# '

# Setup
function ex_setup() {
  cd $CMDEX_HOME/ex/$1/sh
  if [ -f ./__setlink.sh ]; then
    source ./__setlink.sh
  fi
  if [ -f ./__setup.sh ]; then
    source ./__setup.sh
  fi
  export PATH=${CMDEX_HOME}/ex/$1/sh:$PATH
}
function setup_extensions() {
  for i in "${!EX_MODS[@]}"; do
    ex_setup ${EX_MODS[$i]}
  done
}

# Show Links
function print_link() {
  echo "[$1]:" | awk '{ print toupper($0) }'
  ls -l | grep '^l' | awk '{ print " "$9" --> "$11 }'
  echo
}

# Add Links
function add_ex_link() {
  cd $CMDEX_HOME/ex/$1/sh
  if [ -f ./__setlink.sh ]; then
    source ./__setlink.sh
  fi
  print_link $1
}
function add_extensions_link() {
  for i in "${!EX_MODS[@]}"; do
    add_ex_link ${EX_MODS[$i]}
  done
}

# Remove Links
function remove_ex_link() {
  echo "[EX]: remove link of $1..."
  find $CMDEX_HOME/ex/$1/sh/ -type l -delete
  echo
}
function remove_extensions_link() {
  for i in "${!EX_MODS[@]}"; do
    remove_ex_link ${EX_MODS[$i]}
  done
}

# Set Exec
function set_ex_exec() {
  set_exec "$CMDEX_HOME/ex/$1/py/*.py"
  set_exec "$CMDEX_HOME/ex/$1/sh/*.sh"
}
function set_extensions_exec() {
  for i in "${!EX_MODS[@]}"; do
    set_ex_exec ${EX_MODS[$i]}
  done
}

# Show sh files
function show_ex_shell() {
  cd $CMDEX_HOME/ex/$1/sh
  echo "[$1]" | awk '{ print toupper($0) }'
  echo "------------------------------------"
  ls *
  echo
}
function show_extensions_shell() {
  for i in "${!EX_MODS[@]}"; do
    show_ex_shell ${EX_MODS[$i]}
  done
}

# Show sh files
function show_ex_env() {
  cd $CMDEX_HOME/ex/$1/sh
  if [ -f ./__env.sh ]; then
    source ./__env.sh
  fi
}
function show_extensions_env() {
  for i in "${!EX_MODS[@]}"; do
    show_ex_env ${EX_MODS[$i]}
  done
}
