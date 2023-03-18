export ALIAS_COMMANDS_FILE="$HOME/AliasCLI/aliases"
source "$ALIAS_COMMANDS_FILE"                                                                                          

function al() {
    if [[ $1 == "-h" ]]; then
        echo "al -h                : show this help page"
        echo "al                   : list all aliases"
        echo "al <string>          : list aliases containing <string>"
        echo "al -d <string>       : delete aliases containing <string>"
        echo "al -v <string>       : view command for an alias"
        echo "al <alias> <command> : create a new alias or update an existing one"
        return 0
    fi

    if [[ $# -eq 0 ]]; then
        grep "^alias" "$ALIAS_COMMANDS_FILE" | sed 's/^alias //g'
    elif [[ $# -eq 1 ]]; then
        grep "$1" "$ALIAS_COMMANDS_FILE" | sed 's/^alias //g'
    elif [[ $1 == "-v" ]]; then
        command=$(grep "alias $2=" "$ALIAS_COMMANDS_FILE" | sed "s/alias $2='\(.*\)'$/\1/")
        if [[ -n $command ]]; then
            echo "$2 -> $command"
        else
            echo "No command found for alias: \"$2\""
        fi
    elif [[ $1 =~ ^-[Dd]$ ]]; then
        if [[ $# -lt 2 ]]; then
            echo "Please specify an alias to delete"
            return 1
        fi
        echo "Delete alias '$2'? [y/n]" && read
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            sed -i.bak "/^alias $2=.*/d" "$ALIAS_COMMANDS_FILE"
            echo "Deleted alias $2"
        fi
    elif [[ $# -eq 2 ]]; then
        if grep "^alias $1=" "$ALIAS_COMMANDS_FILE"; then
            existing_command=$(grep "^alias $1=" "$ALIAS_COMMANDS_FILE" | sed "s/^alias $1='\(.*\)'$/\1/")
            echo "Alias \"$1\" already exists: \"$existing_command\""
            echo "Update to \"$2\"? (y/n) "
            read
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                sed -i.bak "/^alias $1=\"/d" "$ALIAS_COMMANDS_FILE"
                echo "alias $1=\"$2\"" >> "$ALIAS_COMMANDS_FILE"
            fi
        else
            echo "alias $1=\"$2\"" >> "$ALIAS_COMMANDS_FILE"
        fi
    else
        echo "Invalid arguments"
        return 1
    fi
}
