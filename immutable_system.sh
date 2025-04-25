

#!/bin/bash

# --- Configuration Section ---
# Define immutable settings here
readonly BASE_USER_DIR="/opt/user_environments"
readonly JAIL_BASE_DIR="/opt/jails"
readonly DEFAULT_SHELL="/bin/bash"
readonly SCRIPT_BASE_DIR="/usr/local/scripts/usermanager" # Dynamic script location base

# Ensure script base directory exists
mkdir -p "$SCRIPT_BASE_DIR"

# --- Helper Functions ---

# Function to log actions
log_action() {
  local timestamp=$(date +%Y-%m-%d_%H:%M:%S)
  echo "[$timestamp] $1" >> /var/log/usermanager.log
}

# Function to check if a user exists
user_exists() {
  id -u "$1" >/dev/null 2>&1
  return $?
}

# Function to create a user environment directory
create_user_env_dir() {
  local username="$1"
  local user_dir="$BASE_USER_DIR/$username"
  mkdir -p "$user_dir"
  if [ -d "$user_dir" ]; then
    chown "$username":"$username" "$user_dir"
    chmod 0700 "$user_dir"
    log_action "Created user environment directory: $user_dir for user $username"
    return 0
  else
    log_action "Error creating user environment directory: $user_dir for user $username"
    return 1
  fi
}

# Function to set basic user security
set_user_security() {
  local username="$1"
  # Set strong password policy (example - adjust as needed)
  sudo chage -d 0 "$username" # Force password change on next login
  sudo chage -m 7 -M 90 "$username" # Minimum 7 days, maximum 90 days password age
  log_action "Applied basic security settings for user $username"
}

# Function to create a jailed user environment
create_jailed_environment() {
  local username="$1"
  local jail_dir="$JAIL_BASE_DIR/$username"

  # Create the jail directory structure
  mkdir -p "$jail_dir"{/bin,/lib64,/usr/bin}

  # Copy essential binaries (minimal set - expand as needed)
  cp -P /bin/{bash,ls,pwd,date} "$jail_dir"/bin/
  cp -P /usr/bin/scp "$jail_dir"/usr/bin/ # Example addition
  ldd /bin/bash /bin/ls /bin/pwd /bin/date /usr/bin/scp | awk '{if ($2 != "") print $2}' | sort -u | xargs -r cp -P --parents {} "$jail_dir"

  # Create necessary device nodes (minimal - adjust based on needs)
  sudo mount --bind /dev "$jail_dir"/dev
  sudo mount --bind /sys "$jail_dir"/sys
  sudo mount --bind /proc "$jail_dir"/proc

  # Create user inside the jail
  sudo chroot "$jail_dir" /usr/sbin/useradd -m -s "$DEFAULT_SHELL" "$username"
  if [ $? -eq 0 ]; then
    log_action "Created jailed environment for user $username in $jail_dir"
    return 0
  else
    log_action "Error creating user inside jailed environment $jail_dir for user $username"
    # Cleanup partially created jail?
    return 1
  fi
}

# Function to set immutable settings for a user (example: .bashrc)
set_immutable_settings() {
  local username="$1"
  local user_home
  user_home=$(getent passwd "$username" | cut -d: -f6)
  if [ -n "$user_home" ]; then
    if [ -f "$user_home/.bashrc" ]; then
      chattr +i "$user_home/.bashrc"
      log_action "Set immutable flag on $user_home/.bashrc for user $username"
      return 0
    else
      log_action "$user_home/.bashrc not found for user $username"
      return 1
    fi
  else
    log_action "Could not determine home directory for user $username"
    return 1
  fi
}

# Function to remove immutable settings for a user (for modifications)
unset_immutable_settings() {
  local username="$1"
  local user_home
  user_home=$(getent passwd "$username" | cut -d: -f6)
  if [ -n "$user_home" ]; then
    if [ -f "$user_home/.bashrc" ]; then
      chattr -i "$user_home/.bashrc"
      log_action "Removed immutable flag on $user_home/.bashrc for user $username"
      return 0
    else
      log_action "$user_home/.bashrc not found for user $username"
      return 1
    fi
  else
    log_action "Could not determine home directory for user $username"
    return 1
  fi
}

# --- Main Script Logic ---

case "$1" in
  create_user)
    if [ -z "$2" ]; then
      echo "Usage: $0 create_user <username>"
      exit 1
    fi
    local new_user="$2"
    if user_exists "$new_user"; then
      echo "User '$new_user' already exists."
      exit 1
    fi
    sudo useradd -m -s "$DEFAULT_SHELL" "$new_user"
    if [ $? -eq 0 ]; then
      log_action "Created user: $new_user"
      create_user_env_dir "$new_user"
      set_user_security "$new_user"
    else
      log_action "Error creating user: $new_user"
      exit 1
    fi
    ;;

  create_jailed_user)
    if [ -z "$2" ]; then
      echo "Usage: $0 create_jailed_user <username>"
      exit 1
    fi
    local jailed_user="$2"
    if user_exists "$jailed_user"; then
      echo "User '$jailed_user' already exists."
      exit 1
    fi
    if create_jailed_environment "$jailed_user"; then
      set_user_security "$jailed_user"
    fi
    ;;

  set_immutable)
    if [ -z "$2" ]; then
      echo "Usage: $0 set_immutable <username>"
      exit 1
    fi
    set_immutable_settings "$2"
    ;;

  unset_immutable)
    if [ -z "$2" ]; then
      echo "Usage: $0 unset_immutable <username>"
      exit 1
    fi
    unset_immutable_settings "$2"
    ;;

  delete_user)
    if [ -z "$2" ]; then
      echo "Usage: $0 delete_user <username> [--remove-files]"
      exit 1
    fi
    local del_user="$2"
    local remove_files=0
    if [ "$3" == "--remove-files" ]; then
      remove_files=1
    fi
    if ! user_exists "$del_user"; then
      echo "User '$del_user' does not exist."
      exit 1
    fi
    if [ "$remove_files" -eq 1 ]; then
      sudo userdel -r "$del_user"
      log_action "Deleted user '$del_user' and removed home directory and mail spool."
    else
      sudo userdel "$del_user"
      log_action "Deleted user '$del_user'."
      # Optionally remove user environment directory
      if [ -d "$BASE_USER_DIR/$del_user" ]; then
        sudo rm -rf "$BASE_USER_DIR/$del_user"
        log_action "Removed user environment directory for '$del_user'."
      fi
      # TODO: Consider removing jail environment as well
    fi
    ;;

  list_users)
    echo "Existing users:"
    cut -d: -f1 /etc/passwd
    ;;

  help)
    echo "User Management Script"
    echo "Usage: $0 <action> [username] [options]"
    echo ""
    echo "Actions:"
    echo "  create_user <username>          : Creates a new user with a dedicated environment."
    echo "  create_jailed_user <username>   : Creates a new user in a jailed environment."
    echo "  set_immutable <username>        : Sets the immutable flag on the user's .bashrc."
    echo "  unset_immutable <username>      : Removes the immutable flag from the user's .bashrc."
    echo "  delete_user <username> [--remove-files]"
    echo "                                  : Deletes a user (optionally removes files)."
    echo "  list_users                      : Lists all users on the system."
    echo "  help                            : Displays this help message."
    exit 0
    ;;

  *)
    echo "Invalid action. Use '$0 help' for usage instructions."
    exit 1
    ;;
esac

exit 0