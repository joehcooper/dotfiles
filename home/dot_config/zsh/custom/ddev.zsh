# Auto-generate completions into the OMZ cache directory if they are missing
DDEV_CACHE_FILE="$ZSH_CACHE_DIR/completions/_ddev"
if [[ ! -f "$DDEV_CACHE_FILE" ]] && command -v ddev >/dev/null; then
  echo "Generating DDEV autocompletions..."
  mkdir -p "$ZSH_CACHE_DIR/completions"
  command ddev completion zsh > "$DDEV_CACHE_FILE"
fi

ddev() {
  if [[ "$PWD" == "$HOME/Sites/"* ]] && [[ "$1" == "config" ]]; then
    local relative_path="${PWD#$HOME/Sites/}"
    local parent_dir="${relative_path%%/*}"
    
    if [[ -n "$parent_dir" ]] && [[ "$*" != *"--project-tld"* ]]; then
      local auto_tld="${parent_dir}.ddev.site"
      
      command ddev "$@"
      local exit_status=$?
      
      if [[ $exit_status -eq 0 ]]; then
        echo "Auto-applying ${auto_tld} TLD based on parent folder..."
        command ddev config --project-tld="$auto_tld" >/dev/null 2>&1
      fi
      
      return $exit_status
    fi
  fi
  
  command ddev "$@"
}
