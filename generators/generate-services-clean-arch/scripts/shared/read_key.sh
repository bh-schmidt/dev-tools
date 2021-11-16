BASE_DIRECTORY=$(dirname "$0")

read_key() {
    local input
    while ! "$BASE_DIRECTORY/scripts/shared/contains.sh" $@ $input; do
        read -rsn1 input
    done
    echo $input
}

read_key $@