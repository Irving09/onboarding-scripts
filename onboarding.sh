bindkey '^[^[[C' forward-word
bindkey '^[^[[D' backward-word

alias reformatJson='pbpaste | jq -S | pbcopy'
alias list='eza -l'
alias cat=bat
alias gitreset='git reset HEAD --hard'
alias gpom='git pull origin master'
alias gcom='git checkout master'
alias gco='git checkout'

function j8() {
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
}
function j11() {
  export JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home'
}
function j17() {
  export JAVA_HOME="/Users/iestrera/Library/Java/JavaVirtualMachines/temurin-17.0.9/Contents/Home"
}
function j21() {
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home"
}

function mvn-3-9() {
  export M2_HOME="/Users/iestrera/dev/maven/apache-maven-3.9.7"
}
function mvn-3-8() {
  export M2_HOME="/Users/iestrera/dev/maven/apache-maven-3.8.7"
}
function mvn-3-5() {
  export M2_HOME="/Users/iestrera/dev/maven/apache-maven-3.5.4"
}

function checkGitChanges {
  # Check if the current directory is a git repository
  if [[ ! -d .git ]]; then
    echo "This is not a git repository."
    return 1
  fi

  # Check if there are any uncommitted changes
  if [[ $(git status --porcelain) ]]; then
    echo "There are uncommitted changes."
    return 1
  fi

  # Check if there are any changes that have not been pushed
  if [[ $(git diff --exit-code HEAD) ]]; then
    echo "There are changes that have not been pushed."
    return 1
  fi

  # No changes found
  echo "No changes found."
  return 0
}
function newbranch {
  checkGitChanges
  hasChange=$?

  if [[ "$hasChange" == 1 ]]
  then
    git stash save
  fi
  
  gcom
  gpom
  git checkout -b $1

  if [[ "$hasChange" == 1 ]]
  then
    git stash apply
  fi
  
  git push -u origin $1
}
