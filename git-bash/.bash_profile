echo Bash profile loaded


#Change Directory
##Personal
alias cdworkspace="cd /c/workspace/"
alias cdworkspace-utils="cd /c/workspace/workspace-utils/"
alias cdmongodb="cd /c/workspace/ddd-with-mongodb/"
alias cdmarketplace="cd /c/workspace/marketplace-with-ddd/"
alias cdfastsharper="cd /c/workspace/fast-sharper"
alias cdsso="cd /c/workspace/sso"
alias cdmacro="cd /c/workspace/chronos-macro-pxg"
alias cdtextstostudy="cd /c/workspace/texts-to-study/src"


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
	git push -u origin $(git rev-parse --abbrev-ref HEAD)
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