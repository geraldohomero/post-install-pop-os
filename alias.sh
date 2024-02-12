#!/bin/bash
#####################################################################################
## This script adds custom aliases defined in the CUSTOM_ALIASES array to          ##
## the .bash_aliases file in the user's home directory, ensuring convenient        ##
## access to frequently used commands. Additionally, it includes a safety check to ## 
## prevent execution as root, mitigating accidental modification of system files.  ##
#####################################################################################

# Your custom aliases
CUSTOM_ALIASES=(
  'alias ips="ip -c -br a"'
  'alias his="history|grep"'
  'alias ports="netstat -tulanp"'
  'alias update="./update.sh"'
  'alias upd="./update.sh"'
  'alias plexstatus="sudo service plexmediaserver status"'
  'alias plexstart="sudo service plexmediaserver start"'
  'alias plexstop="sudo service plexmediaserver stop"'
  'alias mysqlstatus="sudo systemctl status mysql"'
  'alias mysqlstart="sudo systemctl start mysql"'
  'alias mysqlstop="sudo systemctl stop mysql"'
  'alias syncstatus="./syncthingStatus.sh"'
)

# Check if the script is run as root
if [[ $EUID -eq 0 ]]; then
  echo "This script should not be run as root."
  exit 1
fi

# add aliases to .bash_aliases file
add_aliases_to_bashrc() {
  BASH_ALIASES_FILE="$HOME/.bash_aliases"

  # Check if .bash_aliases file exists or create it
  if [[ ! -e "$BASH_ALIASES_FILE" ]]; then
    touch "$BASH_ALIASES_FILE"
    echo "Created .bash_aliases file in the home directory."
  else
    echo ".bash_aliases file already exists in the home directory."
  fi

  # Check if the aliases are already present in .bash_aliases
  for alias_line in "${CUSTOM_ALIASES[@]}"; do
    if ! grep -qF "$alias_line" "$BASH_ALIASES_FILE"; then
      echo "$alias_line" >> "$BASH_ALIASES_FILE"
      echo "Added: $alias_line"
    else
      echo "Alias already exists: $alias_line"
    fi
  done
}

# Execute the function to add aliases to .bash_aliases
add_aliases_to_bashrc
