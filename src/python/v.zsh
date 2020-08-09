export VENV_NAME_FILE=".venvname"

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
    echo "  If an argument is given, the virtual environment with that name"
    echo "  is activated."
    echo ""
    echo "  If no argument is given, and a \"${VENV_NAME_FILE}\" file exists in the"
    echo "  current directory, the virtual environment named in that"
    echo "  file is used."
    echo ""
    echo "Options:"
    echo "  -h, --help   Show this message."
  elif ! [ -z $1 ]; then
    workon "$1"
    # pyenv activate "$1"
  elif [ -r ${VENV_NAME_FILE} ]; then
    workon "$(cat ${VENV_NAME_FILE})"
    # pyenv activate "$(cat ${VENV_NAME_FILE})"
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
    v::error "Got too many arguments"
  fi

  deactivate
  # pyenv deactivate
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
  elif [ -r ${VENV_NAME_FILE} ]; then
    v::error "\"${VENV_NAME_FILE}\" file already exists."
    return 1
  elif ! [ -z $1 ]; then
    # Abort if the name looks like an option (i.e. starts with '-')
    if [[ $1 == "-*" ]]; then
      v::error "First argument seems to be an option. Please provide a name."
      return 1
    fi
    _v_make_name="$1"
    shift
  else
    _v_make_name="$(basename "$(pwd)")"

    # If there's already a virtual environment with this name, abort.
    v::command::list --oneline | while read line; do
      if [[ $line == $_v_make_name ]]; then
        v::error "${_v_make_name} is the name of an existing virtual environment."
        v::error "Please provide a different name."
        return 1
      fi
    done
  fi

  echo "Creating virtualenv \"${_v_make_name}\" here."
  mkvirtualenv -a "$(pwd)" "${_v_make_name}" $@ && \
   echo "$(basename "$(pwd)")" > ${VENV_NAME_FILE}
  # pyenv virtualenv ${_v_make_name}

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
    # Abort if the name looks like an option (i.e. starts with '-')
    if [[ $1 == "-*" ]]; then
      v::error "First argument seems to be an option. Please provide a name."
      return 1
    fi
    venv_name="$1"
    shift
  elif [ -f ${VENV_NAME_FILE} ]; then
    venv_name=$(cat ${VENV_NAME_FILE})

    # Look for an environment by this name.
    found_from_file=false
    v::command::list --oneline | while read line; do
      if [[ $line == $venv_name ]]; then
        found_from_file=true
      fi
    done

  if [[ $found_from_file == "false" ]]; then
      v::error "No environment named ${venv_name}."
      return 1
    fi
  else
    v::error "Did not find a ${VENV_NAME_FILE} or get name for the environment."
    v::error "Aborting due to lack of a name."
    return 1
  fi

  rmvirtualenv "${venv_name}"
  if [[ $? == 0 && $found_from_file == "true" ]]; then
    rm ${VENV_NAME_FILE}
  fi
}

v::command::list() {
  case $1 in
    "")
      ;;
    "-h" | "--help")
      echo "Usage: v list [--oneline|-h|--help]"
      echo ""
      echo "  Lists all virtual environments created."
      echo ""
      echo "Options:"
      echo "  --oneline    Show virtual environment names, one per line."
      echo "  -h, --help   Show this message."
      return 0
      ;;
    "--oneline")
      _v_list_oneline=1
      ;;
    *)
      echo "Got invalid argument: $1"
      return 1
      ;;
  esac

  if [[ ${_v_list_oneline} == "1" ]]; then
    lsvirtualenv -b
  else
    lsvirtualenv -b | column -c $COLUMNS
  fi
}

v::command::mk-tmp() {
  use_magic=0
  if [[ $1 == "." ]]; then
    use_magic=1
    shift
  fi

  if [[ $use_magic == "1" ]]; then
    pushd > /dev/null
  fi
  mktmpenv $@
  if [[ $use_magic == "1" ]]; then
    popd > /dev/null
  fi
}

v::command::rm-tmp() {
  candidates=$(lsvirtualenv -b | grep tmp-)
  if [ -z $candidates ]; then
    echo "No temporary environments found."
    return 0
  fi

  count=$(echo ${candidates} | wc -l | xargs)
  echo "Will remove ${count} environments."
  echo $candidates | while read line; do
    rmvirtualenv $line
  done
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

  wipeenv
}

# Shorthands
v::command::a() { v::command::activate $@ }
v::command::act() { v::command::activate $@ }
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
  echo -e "  ${FG}(a/act) activate   ${RESET} Activate a virtualenv"
  echo -e "  ${FG}(d)     deactivate ${RESET} Dectivate current virtualenv"
  echo -e "  ${FG}(mk)    make       ${RESET} Make a virtualenv"
  echo -e "  ${FG}(rm)    remove     ${RESET} Remove a virtualenv"
  echo -e "  ${FG}(ls)    list       ${RESET} List existing virtualenvs"
  echo -e "  ${FG}        wipe       ${RESET} Remove all packages from currently active virtualenv"
  echo -e "  ${FG}        mk-tmp     ${RESET} Make a temporary virtualenv, that gets deleted on deactivate"
  echo -e "  ${FG}        rm-tmp     ${RESET} Remove all temporary virtualenvs"
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
