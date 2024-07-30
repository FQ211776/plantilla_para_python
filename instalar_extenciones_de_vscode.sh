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

    read -p "The VSCode Extension '$extension_id' is currently not installed. This must be installed when you work with the DBC AL source code. (install and continue, break) (default: install): " selection

    if [ -z "$selection" ]; then
        selection="install"
    fi

    if [ "$selection" == "break" ]; then
        echo "Please make sure VSCode Extension '$extension_id' is installed before we continue"
        return 1
    fi

    echo "Making sure VSCode Extension '$extension_id' is installed before we continue"
    code --install-extension "$extension_id"
}

# Example usage
check_vscode_extension "VSpaceCode.whichkey" 
check_vscode_extension "tobias-z.vscode-harpoon"
