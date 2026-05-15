#!/bin/bash
set -euo pipefail

LOG_FILE="/var/log/user_creation.log"
DEFAULT_SHELL="/bin/bash"
PASSWORD_LENGTH=14

log() {
    echo "$(date '+%F %T') : $1" | tee -a "$LOG_FILE"
}

generate_password() {
    openssl rand -base64 $PASSWORD_LENGTH
}

create_user() {
    local username=$1

    if id "$username" &>/dev/null; then
        log "User $username already exists"
        return
    fi

    password=$(generate_password)

    useradd -m -s "$DEFAULT_SHELL" "$username"
    echo "$username:$password" | chpasswd
    passwd -e "$username"

    mkdir -p /home/$username/.ssh
    chmod 700 /home/$username/.ssh
    chown -R $username:$username /home/$username/.ssh

    log "User $username created successfully"
    echo "Username: $username Password: $password"
}

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 username"
    exit 1
fi

create_user "$1"
