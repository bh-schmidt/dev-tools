select_option() {
    if [ ${#SELECT_DATA[@]} -eq 0 ]; then
        echo "No arguments provided"
        return
    fi

    local choice
    while ! ./scripts/shared/contains.sh ${SELECT_DATA[@]} $choice; do
        echo "$SELECT_MESSAGE"
        select opt in "${SELECT_DATA[@]}"; do
            case $opt in
            *)
                choice=$opt
                break
                ;;
            esac
        done
    done
    SELECT_RESULT=$choice
}

select_option