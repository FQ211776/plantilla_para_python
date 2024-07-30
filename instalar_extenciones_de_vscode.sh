#!/bin/bash

check_vscode_extension() {
  local extension_id="$1"
  if [ -z "$extension_id" ]; then
    echo "Extension ID cannot be empty"
    return 1
  fi

  installed_extension=$(code --list-extensions | grep -i "$extension_id")

  if [ -n "$installed_extension" ]; then
    return 0
  fi

   echo "Making sure VSCode Extension '$extension_id' is installed before we continue"
  code --install-extension "$extension_id"
}

# Example usage
#check_vscode_extension "VSpaceCode.whichkey"
#check_vscode_extension "tobias-z.vscode-harpoon"

EXT_LIST="
redhat.vscode-yaml
ms-python.python 
JohnnyMorganz.stylua
re1san.tsuki
ssigwart.trailing-whitespace-fixer
" &&
  for EXT in $EXT_LIST; do check_vscode_extension $EXT; done
