replace_all(){
    echo "${REPLACE_TEXT//\{$1\}/$2}"
}

replace_all $@