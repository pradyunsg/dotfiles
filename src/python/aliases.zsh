_pradyunsg_log "Creating Python-specific shorthands..."

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
