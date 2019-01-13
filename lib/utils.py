import click

import contextlib
import locale
import shlex
import subprocess

from .logging import log


@contextlib.contextmanager
def task(message):
    click.secho('# {}...'.format(message), fg='blue')
    try:
        yield
    except Exception:
        log.error('Aborting due to following error...')
        raise
    else:
        click.secho('# Completed', fg='blue')


def run(command, repo):
    if repo.verbose:
        log.info('> {}', command)
    if repo.dry_run:
        return 0
    return subprocess.call(shlex.split(command))


def run_output(command):
    try:
        return subprocess.check_output(
            shlex.split(command),
            stderr=subprocess.STDOUT,
        ).decode(
            locale.getpreferredencoding()
        )
    except subprocess.CalledProcessError:
        return None
