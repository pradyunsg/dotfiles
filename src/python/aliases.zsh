# Sometimes, you need a package quickly
function mkpkg() {
    if [ -n "$1" ]; then
        mkdir -p "./$1/$1"
        echo "\
from setuptools import setup, find_packages

setup(
    name=\"$1\",
    version=\"0.1.0\",
    packages=find_packages()
)
" > "./$1/setup.py"
        echo "print('Hi from $1')" > "./$1/$1/__init__.py"
        return 0
    fi
    echo "Need an argument"
    return 1
}

function toxr() {
    if [[ -z "$1" || -z "$2" ]]; then
        echo "FATAL: Not enough arguments"
        echo "Usage: toxr <env> <binary>"
        return 1
    fi

    if [ ! -e ".tox/$1" ]; then
        echo "FATAL: No environment '$1' created."
        return 1
    elif [ ! -e ".tox/$1/bin/$2" ]; then
        echo "FATAL: No binary '$2' available."
        return 1
    fi
    ./.tox/$1/bin/$2 "${@:3}"
}
