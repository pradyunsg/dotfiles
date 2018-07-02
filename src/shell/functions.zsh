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
function p {
  PROJECT_DIRECTORY=${PROJECT_DIRECTORY:-"${HOME}/Projects"}
  if [ ! -n "$1" ]; then
    cd "$PROJECT_DIRECTORY"
  elif [ -n "$2" ]; then
    echo "Usage: mcd directory"
    echo "FATAL: Too many arguments"
    return 1
  elif [ ! -d "${PROJECT_DIRECTORY}/$1" ]; then
    echo "'${PROJECT_DIRECTORY}/$1' does not exist"
    return 1
  else
    cd $PROJECT_DIRECTORY/$1
    workhere
  fi
}
