v::error() {
  echo -ne "\e[31m"
  echo "ERROR:" $@
  echo -ne "\e[0m"
}

# Subcommand definitions
v::command::activate() {
  if ! [ -z $2 ]; then
    v::error "Got too many arguments"
    return 1
  fi

  if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "Usage: v a[ct[ivate]] [-h|--help] [name]"
    echo ""
    echo "  Activates a virtual environment."
    echo ""
    echo "  If an argument is given, the virtual environment for that project"
    echo "  is activated."
    echo ""
    echo "  If no argument is given, the virtual environment relative to the "
    echo "current path is used."
    echo ""
    echo "Options:"
    echo "  -h, --help   Show this message."
  elif ! [ -z $1 ]; then
    source ${PROJECT_DIRECTORY}/$1/.venv/bin/activate
  elif [ -d .venv ]; then
    source .venv/bin/activate
  else
    echo "No virtualenv associated with this directory."
    echo "You can associate one using 'v make'."
  fi
}

v::command::deactivate() {
  if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "Usage: v d[eactivate] [-h|--help]"
    echo ""
    echo "  Deactivates the currently active virtual environment."
    echo ""
    echo "Options:"
    echo "  -h, --help   Show this message."
  elif ! [ -z $1 ]; then
    v::error "Did not expect any arguments."
    return 1
  fi

  deactivate
}

v::command::make() {
  if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "Usage: v make [-h|--help] [name [...]]"
    echo ""
    echo "  Creates and activates a virtual environment, associating it with"
    echo "  the current directory by creating a \"${VENV_NAME_FILE}\" file."
    echo ""
    echo "  If a \"${VENV_NAME_FILE}\" file exists in the current directory,"
    echo "  no action is taken and an error is printed."
    echo ""
    echo "  If any arguments are given, all but the first are forwarded to "
    echo "  virtualenv. The first argument is used to name the virtual "
    echo "  environment. If it starts with '-', an error is thrown."
    echo ""
    echo "  In the absence of any arguments, the current directory is used "
    echo "  to name the virtual environment."
    echo ""
    echo "Options:"
    echo "  -h, --help   Show this message."
    return 0
  elif [ -d .venv ]; then
    v::error "A virtualenv already exists in this folder."
    return 1
  elif ! [ -z $1 ]; then
    v::error "Did not expect any arguments."
    return 1
  fi

  echo "Creating virtualenv here..."
  python3 -m venv --upgrade-deps .venv
  v::command::activate
}

v::command::remove() {
  if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "Usage: v rm [-h|--help] name"
    echo ""
    echo "  Deletes a virtual environment., associating it with"
    echo "  the current directory by creating a \"${VENV_NAME_FILE}\" file."
    echo ""
    echo "  If a \"${VENV_NAME_FILE}\" file exists in the current directory,"
    echo "  no action is taken and an error is printed."
    echo ""
    echo "Options:"
    echo "  -h, --help   Show this message."
    return 0
  elif ! [ -z $1 ]; then
    v::error "Did not expect any arguments."
    return 1
  elif ! [ -d .venv ]; then
    v::error "Did not find a virtualenv in this folder."
    return 1
  fi

  rm -rf .venv
}

v::command::wipe() {
  case $1 in
    "")
      ;;
    "-h" | "--help")
      echo "Usage: v wipe [-h|--help]"
      echo ""
      echo "  Wipe all pacakges ."
      echo ""
      echo "Options:"
      echo "  -h, --help   Show this message."
      return 0
      ;;
    *)
      echo "Got invalid argument: $1"
      return 1
      ;;
  esac

  if ! [ -d .venv ]; then
    v::error "Did not find a virtualenv in this folder."
    return 1
  fi

  # Put output of pip freeze in a single location.
  temp_file=$(mktemp /tmp/XXXXXXXXX.requirements.txt)
  pip list --format=freeze | egrep --color=auto -v '(distribute|wsgiref|appdirs|packaging|pyparsing|six)' > "$temp_file"

  # Nothing to remove.
  if ! [ -n "$(cat "$temp_file")" ]; then
    echo "Nothing to remove."
    rm -f "$temp_file"
  fi

  # Uninstall the packages.
  line_count=$(cat "$temp_file" | wc -l | xargs)
  echo "Found ${line_count} packages."

  pip uninstall -y $(cat "$temp_file" | grep -ve '^pip' | grep -ve '^setuptools' | grep -ve '^wheel' | sed 's/>|@/=/g' | cut -f1 -d=)

  rm -f "$temp_file"
}

# Shorthands
v::command::a() { v::command::activate $@ }
v::command::d() { v::command::deactivate $@ }
v::command::mk() { v::command::make $@ }
v::command::rm() { v::command::remove $@ }
v::command::ls() { v::command::list $@ }

# Help text
v::command::help() {
  FG="\e[36m"
  RESET="\e[0m"
  echo "A helper for managing virtualenvs"
  echo
  echo "Subcommands:"
  echo -e "  ${FG}(a)     activate   ${RESET} Activate a virtualenv"
  echo -e "  ${FG}(d)     deactivate ${RESET} Dectivate current virtualenv"
  echo -e "  ${FG}(mk)    make       ${RESET} Make a virtualenv"
  echo -e "  ${FG}(rm)    remove     ${RESET} Remove a virtualenv"
  echo -e "  ${FG}        wipe       ${RESET} Remove all packages from currently active virtualenv"
}

# Main entrypoint
function v() {
  subcommand=$1
  case ${subcommand} in
    "" | "-h" | "--help")
      v::command::help
      ;;
    *)
      # Check if there's a subcommand by that name
      if ! typeset -f v::command::${subcommand} > /dev/null; then
        FG="\e[31m"
        RESET="\e[0m"
        echo -e "${FG}ERROR: '$subcommand' is not a known subcommand.${RESET}" >&2
        return 1
      fi

      shift
      v::command::${subcommand} $@
      ;;
  esac
}
