read_key() {
    local input
    while ! ./scripts/shared/contains.sh $@ $input; do
        read -rsn1 input
    done
    echo $input
}

read_key $@