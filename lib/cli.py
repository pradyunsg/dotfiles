import click

from .checker import SystemChecker
from .config import HOME_DIR, DEFAULT_SOURCE_DIR
from .repository import DotFilesRepo
from .utils import task


@click.group()
@click.option(
    '--src-dir', type=click.Path(exists=True), default=DEFAULT_SOURCE_DIR,
    help="Location to use as dotfiles directory"
)
@click.option(
    '--dest-dir', type=click.Path(exists=True), default=HOME_DIR,
    help="Location to create symlinks"
)
@click.option(
    '-n', '--dry-run', default=False, is_flag=True,
    help='Enable debugging mode (implies --verbose)'
)
@click.option(
    '--depth', default=3, type=int,
    help='How deep to recurse looking for ".symlink" items'
)
@click.option(
    '-v', '--verbose', default=False, is_flag=True,
    help='Show what commands have been executed.'
)
@click.pass_context
def cli(ctx, src_dir, dest_dir, dry_run, depth, verbose):
    if dry_run:
        verbose = True

    ctx.obj['obj'] = DotFilesRepo(src_dir, dest_dir, depth, verbose, dry_run)
    ctx.obj['verbose'] = verbose


@cli.command()
@click.argument('topics', nargs=-1)
@click.pass_context
def sync(ctx, topics):
    """Update the symlinks
    """
    with task('Syncing dotfiles'):
        ctx.obj['obj'].sync(topics)


@cli.command()
@click.pass_context
def clean(ctx):
    """Removes stale/broken symlinks
    """
    with task('Cleaning broken symlinks'):
        ctx.obj['obj'].clean()


@cli.command()
@click.pass_context
def check(ctx):
    """Check whether a system is setup correctly.
    """
    checker = SystemChecker()
    checker.run("tools/checks.yaml")


def main():
    cli(obj={}, auto_envvar_prefix='DOTFILES')
