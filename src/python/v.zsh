export VENV_NAME_FILE=".venvname"

_v__error() {
  echo -ne "\e[31m"
  echo "ERROR:" $@
  echo -ne "\e[0m"
}

# Subcommand definitions
_v_activate() {
  if ! [ -z $2 ]; then
    _v__error "Got too many arguments"
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
  elif [ -r ${VENV_NAME_FILE} ]; then
    workon "$(cat ${VENV_NAME_FILE})"
  else
    echo "No virtualenv associated with this directory."
    echo "You can associate one using 'v make'."
  fi
}

_v_deactivate() {
  if [[ $1 == "-h" || $1 == "--help" ]]; then
    echo "Usage: v d[eactivate] [-h|--help]"
    echo ""
    echo "  Deactivates the currently active virtual environment."
    echo ""
    echo "Options:"
    echo "  -h, --help   Show this message."
  elif ! [ -z $1 ]; then
    _v__error "Got too many arguments"
  fi

  deactivate
}

_v_make() {
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
    _v__error "\"${VENV_NAME_FILE}\" file already exists."
    return 1
  elif ! [ -z $1 ]; then
    # Abort if the name looks like an option (i.e. starts with '-')
    if [[ $1 == "-*" ]]; then
      _v__error "First argument seems to be an option. Please provide a name."
      return 1
    fi
    _v_make_name="$1"
    shift
  else
    _v_make_name="$(basename "$(pwd)")"

    # If there's already a virtual environment with this name, abort.
    _v_list --oneline | while read line; do
      if [[ $line == $_v_make_name ]]; then
        _v__error "${_v_make_name} is the name of an existing virtual environment."
        _v__error "Please provide a different name."
        unset _v_make_name
        return 1
      fi
    done
  fi

  echo "Creating virtualenv \"${_v_make_name}\" here."
  mkvirtualenv -a "$(pwd)" "${_v_make_name}" $@ && \
    echo "$(basename "$(pwd)")" > ${VENV_NAME_FILE}

  unset _v_make_name
}

_v_remove() {
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
  elif [ -e ${VENV_NAME_FILE} ]; then
    _v__error "\"${VENV_NAME_FILE}\" file already exists."
    return 1
  elif ! [ -z $1 ]; then
    # Abort if the name looks like an option (i.e. starts with '-')
    if [[ $1 == "-*" ]]; then
      _v__error "First argument seems to be an option. Please provide a name."
      return 1
    fi
    _v_rm_name="$1"
    shift
  else
    _v_rm_name="$(basename "$(pwd)")"

    # If there's already a virtual environment with this name, abort.
    _v_list --oneline | while read line; do
      if [[ $line == $_v_rm_name ]]; then
        _v__error "${_v_rm_name} is the name of an existing virtual environment."
        _v__error "Please provide a different name."
        unset _v_rm_name
        return 1
      fi
    done
  fi

  echo "Creating virtualenv \"${_v_rm_name}\" here."
  mkvirtualenv -a "$(pwd)" "${_v_rm_name}" $@ && \
    echo "$(basename "$(pwd)")" > ${VENV_NAME_FILE}

  unset _v_rm_name
}

_v_list() {
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
  unset _v_list_oneline
}

_v_mk-tmp() {
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

_v_rm-tmp() {
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

_v_wipe() {
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
_v_a() { _v_activate $@ }
_v_act() { _v_activate $@ }
_v_d() { _v_deactivate $@ }
_v_mk() { _v_make $@ }
_v_rm() { _v_remove $@ }
_v_ls() { _v_list $@ }

# Help text
_v_help() {
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
  . /Users/pradyunsg/Projects/dotfiles/src/python/v.zsh
  subcommand=$1
  case $subcommand in
    "" | "-h" | "--help")
      _v_help
      ;;
    *)
      # Check if there's a subcommand by that name
      if ! typeset -f _v_${subcommand} > /dev/null; then
        FG="\e[31m"
        echo -e "${FG}ERROR: '$subcommand' is not a known subcommand.${RESET}" >&2
        RESET="\e[0m"
        return 1
      fi

      shift
      _v_${subcommand} $@
      ;;
  esac
}
