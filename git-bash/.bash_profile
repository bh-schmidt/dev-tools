echo Bash profile loaded


alias ebash="vim ~/.bash_profile"
alias rbash="source ~/.bash_profile"

#Change Directory
##Personal
alias cdworkspace="cd /g/workspace/personal"
alias cdworkspace-utils="cd /g/workspace/personal/workspace-utils/"
alias cdmongodb="cd /g/workspace/personal/ddd-with-mongodb/"
alias cdmarketplace="cd /g/workspace/personal/marketplace-with-ddd/"
alias cdfastsharper="cd /g/workspace/personal/fast-sharper"
alias cdsso="cd /g/workspace/personal/sso"
alias cdmacro="cd /g/workspace/personal/chronos-macro-pxg"
alias cdtextstostudy="cd /g/workspace/personal/dotnet/texts-to-study/"
alias cdfsquery="cd /g/workspace/personal/fs.query/src"

##Work

#Git
alias gs="git status -s $1 $2 $3 $4 $5 $6 $7 $8 $9"
alias gbranch="git branch  $1 $2 $3 $4 $5 $6 $7 $8 $9"
alias gmerge="git merge  $1 $2 $3 $4 $5 $6 $7 $8 $9"
alias gmergetool="git mergetool  $1 $2 $3 $4 $5 $6 $7 $8 $9"
alias gcheckout="git checkout  $1 $2 $3 $4 $5 $6 $7 $8 $9"
alias gfetch="git fetch -a  $1 $2 $3 $4 $5 $6 $7 $8 $9"
alias gpull="git pull  $1 $2 $3 $4 $5 $6 $7 $8 $9"
alias gadd="git add $1 $2 $3 $4 $5 $6 $7 $8 $9"
alias gdiff="git diff $1 $2 $3 $4 $5 $6 $7 $8 $9"
alias gmerge="git merge $1 $2 $3 $4 $5 $6 $7 $8 $9"
alias gdifftree="git diff-tree --pretty=\"full\" --name-only -r $1 $2 $3 $4 $5 $6 $7 $8 $9"

function sort-by-size(){
	du -sh -- *  | sort -rh
}

function textstart() {
	cdtextstostudy
	cd ./texts-to-study-gui/src
	npm start
}

function cgs(){
	clear
	gs
}

function gcpush(){
	gs
	git commit -m "$1"
	git push -u origin $(git rev-parse --abbrev-ref HEAD)
}

function gcpush-all(){
	git add .
	gs
	git commit -am "$1"
	git push -u origin $(git rev-parse --abbrev-ref HEAD)
}

function gpull-origin(){
	git pull -u origin $(git rev-parse --abbrev-ref HEAD)
}

function gpush(){
	git push -u origin $(git rev-parse --abbrev-ref HEAD) $1 $2 $3 $4 $5 $6 $7 $8 $9
}

function glog(){
	git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
}

function glog-graph(){
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
}

function branchfrommaster(){
	gfetch
	git stash
	gc master
	gpull
	gc -b $1
	git stash pop
	gs
}

function gcommit(){
    if [ -z $1 ]
    then
	git commit

    elif [ -z $2 ];
    then
        git commit -m "$1" $2 $3 $4 $5 $6 $7 $8 $9;

    else
        git commit -m "$1" -m "$2" $3 $4 $5 $6 $7 $8 $9;
    fi
}
