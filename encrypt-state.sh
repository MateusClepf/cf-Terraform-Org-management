#!/bin/bash

# Export your AGE key for SOPS
export SOPS_AGE_KEY_FILE="~/key.txt"

# Function to encrypt a specific state file
encrypt_single_state() {
  local state_file="$1"
  local dir=$(dirname "$state_file")
  local base=$(basename "$state_file")
  
  cd "$dir"
  sops --encrypt "$base" > "${base}.enc"
  echo "Encrypted: $state_file"
  cd - > /dev/null
}

# Function to decrypt a specific state file
decrypt_single_state() {
  local enc_file="$1"
  local dir=$(dirname "$enc_file")
  local base=$(basename "$enc_file" .enc)
  
  cd "$dir"
  sops --decrypt "${base}.enc" > "$base"
  echo "Decrypted: $enc_file to $dir/$base"
  cd - > /dev/null
}

# Function to encrypt all state files
encrypt_all_state() {
  find . -name "terraform.tfstate" | while read state_file; do
    encrypt_single_state "$state_file"
  done
  echo "All state files encrypted"
}

# Function to decrypt all encrypted state files
decrypt_all_state() {
  find . -name "terraform.tfstate.enc" | while read enc_file; do
    decrypt_single_state "$enc_file"
  done
  echo "All state files decrypted"
}

# Function to encrypt state files in a specific directory
encrypt_dir_state() {
  local target_dir="$1"
  find "$target_dir" -name "terraform.tfstate" | while read state_file; do
    encrypt_single_state "$state_file"
  done
  echo "State files in $target_dir encrypted"
}

# Function to decrypt state files in a specific directory
decrypt_dir_state() {
  local target_dir="$1"
  find "$target_dir" -name "terraform.tfstate.enc" | while read enc_file; do
    decrypt_single_state "$enc_file"
  done
  echo "State files in $target_dir decrypted"
}

# Main logic
case "$1" in
  encrypt)
    if [ -n "$2" ]; then
      encrypt_dir_state "$2"
    else
      encrypt_all_state
    fi
    ;;
  decrypt)
    if [ -n "$2" ]; then
      decrypt_dir_state "$2"
    else
      decrypt_all_state
    fi
    ;;
  encrypt-file)
    if [ -n "$2" ]; then
      encrypt_single_state "$2"
    else
      echo "Error: No file specified"
      exit 1
    fi
    ;;
  decrypt-file)
    if [ -n "$2" ]; then
      decrypt_single_state "$2"
    else
      echo "Error: No file specified"
      exit 1
    fi
    ;;
  *)
    echo "Usage: $0 {encrypt|decrypt} [directory]"
    echo "       $0 {encrypt-file|decrypt-file} <file_path>"
    exit 1
    ;;
esac