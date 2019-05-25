# Create a directory and cd into it.
function mcd {
  if [ ! -n "$1" ]; then
    echo "Usage: mcd directory"
    echo "FATAL: Did not pass directory"
    return 1
  elif [ -n "$2" ]; then
    echo "Usage: mcd directory"
    echo "FATAL: Too many arguments"
    return 1
  elif [ -d $1 ]; then
    echo "'$1' already exists"
    return 1
  else
    mkdir $1 && cd $1
  fi
}

# Switching between projects
function pp {
  PROJECT_DIRECTORY=${PROJECT_DIRECTORY:-"${HOME}/Projects"}
  if [ ! -n "$1" ]; then
    cd "$PROJECT_DIRECTORY"
  elif [ -n "$2" ]; then
    echo "Usage: p <dir>"
    echo "FATAL: Too many arguments"
    return 1
  elif [[ "$1" == "." ]]; then
    v act
  elif [ ! -d "${PROJECT_DIRECTORY}/$1" ]; then
    echo "'${PROJECT_DIRECTORY}/$1' does not exist"
    return 1
  else
    cd $PROJECT_DIRECTORY/$1
    v act
  fi
}

# I do this far too often
function octobox-update {
  PROJECT_DIRECTORY=${PROJECT_DIRECTORY:-"${HOME}/Projects"}
  pushd "${PROJECT_DIRECTORY}/octobox"
  git checkout master
  git pull upstream master
  git push origin master
  popd
}
