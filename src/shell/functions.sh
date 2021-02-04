export PROJECT_DIRECTORY=${PROJECT_DIRECTORY:-"${HOME}/Developer"}

# Switching between projects
function p {
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
