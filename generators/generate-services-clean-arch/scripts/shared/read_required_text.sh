while [ -z $input ]; do
    read -p "$1 
" input
done 

echo $input