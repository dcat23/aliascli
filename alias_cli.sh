function al() {
    if [[ $1 == "-h" ]]; then
        echo "al -h          : show this help page"
        echo "al             : list all aliases"
        echo "al <string>    : list aliases containing <string>"
        echo "al -d <string> : delete aliases containing <string>"
        echo "al -D <string> : delete aliases containing <string> without confirmation"
        echo "al -v <string> : view command for an alias"
        echo "al <alias> <command> : create a new alias or update an existing one"
        return 0
    fi

    if [[ $# -eq 0 ]]; then
        grep "^alias" ~/.zsh_aliases | sed 's/^alias //g'
    elif [[ $# -eq 1 ]]; then
        grep "$1" ~/.zsh_aliases | sed 's/^alias //g'
    elif [[ $1 == "-d" ]]; then
        if [[ $# -lt 2 ]]; then
            echo "Please specify an alias to delete"
            return 1
        fi
        if [[ $2 == "-D" ]]; then
            confirmation="y"
            shift
        else
            read -p "Delete aliases containing \"$2\"? (y/n) " confirmation
        fi
        if [[ $confirmation =~ ^[Yy]$ ]]; then
            sed -i.bak "/^alias .*=$2/d" ~/.zsh_aliases
            echo "Deleted aliases containing \"$2\""
        fi
    elif [[ $1 == "-v" ]]; then
        command=$(grep "alias $2=" ~/.zsh_aliases | sed "s/alias $2='\(.*\)'$/\1/")
        if [[ -n $command ]]; then
            echo "$2 -> $command"
        else
            echo "No command found for alias: \"$2\""
        fi
    elif [[ $# -eq 2 ]]; then
        if grep -q "^alias $1=" ~/.zsh_aliases; then
            existing_command=$(grep "^alias $1=" ~/.zsh_aliases | sed "s/^alias $1='\(.*\)'$/\1/")
            echo "Alias \"$1\" already exists: \"$existing_command\""
            read -p "Update to \"$2\"? (y/n) " -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sed -i.bak "/^alias $1=\"/d" ~/.zsh_aliases
                echo "alias $1=\"$2\"" >> ~/.zsh_aliases
            fi
        else
            echo "alias $1=\"$2\"" >> ~/.zsh_aliases
        fi
    else
        echo "Invalid arguments"
        return 1
    fi
}
