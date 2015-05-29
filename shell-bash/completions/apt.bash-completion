#!/bin/bash

# Debian apt(8) completion
_apt()
{
    local cur prev words cword
    _init_completion || return

    local special i
    for (( i=0; i < ${#words[@]}-1; i++ )); do
        if [[ ${words[i]} == @(list|search|show|update|install|remove|upgrade|full-upgrade|edit-sources|dist-upgrade|purge) ]]; then
            special=${words[i]}
        fi
    done

    if [[ -n $special ]]; then
        case $special in
            remove|purge)
                if [[ -f /etc/debian_version ]]; then
                    # Debian system
                    COMPREPLY=( $( \
                        _xfunc dpkg _comp_dpkg_installed_packages $cur ) )
                else
                    # assume RPM based
                    _xfunc rpm _rpm_installed_packages
                fi
                return 0
                ;;
            *)
                COMPREPLY=( $( apt-cache --no-generate pkgnames "$cur" \
                    2> /dev/null ) )
                return 0
                ;;
        esac
    fi

    case $prev in
        -c|--config-file)
             _filedir
             return 0
             ;;
        -t|--target-release|--default-release)
             COMPREPLY=( $( apt-cache policy | \
                 command grep "release.o=Debian,a=$cur" | \
                 sed -e "s/.*a=\(\w*\).*/\1/" | uniq 2> /dev/null) )
             return 0
             ;;
    esac

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $( compgen -W '-d -f -h -v -m -q -s -y -u -t -b -c -o
            --download-only --fix-broken --help --version --ignore-missing
            --fix-missing --no-download --quiet --simulate --just-print
            --dry-run --recon --no-act --yes --assume-yes --show-upgraded
            --only-source --compile --build --ignore-hold --target-release
            --no-upgrade --force-yes --print-uris --purge --reinstall
            --list-cleanup --default-release --trivial-only --no-remove
            --diff-only --no-install-recommends --tar-only --config-file
            --option --auto-remove' -- "$cur" ) )
    else
        COMPREPLY=( $( compgen -W 'list search show update install
            remove upgrade full-upgrade edit-sources dist-upgrade
            purge' -- "$cur" ) )
    fi

    return 0
} &&
complete -F _apt apt

# ex: ts=4 sw=4 et filetype=sh
