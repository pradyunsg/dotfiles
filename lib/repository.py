import os
import click

from .config import HOME_DIR
from .logging import log
from .utils import run


class Repository(object):

    def __init__(self, source_dir, target_dir, walk_depth, verbose, dry_run):
        super().__init__()
        self.global_action = None
        self.source_dir = os.path.abspath(source_dir)
        self.target_dir = os.path.abspath(target_dir)
        self.walk_depth = walk_depth
        self.verbose = verbose
        self.dry_run = dry_run

    def link_source_to_target(self, source, target):
        run('mkdir -p "{}"'.format(os.path.dirname(target)), self)
        run('ln -s "{}" "{}"'.format(source, target), self)

    def get_action(self, target):
        if self.global_action is not None:
            return self.global_action

        # Mapping of options to return values
        mapping = {
            's': 'skip',
            'b': 'backup',
            'u': 'update (overwrite)',
        }

        # Prepare Prompt
        options = []
        for val in mapping.values():
            options.append('[{}]{}'.format(val[0], val[1:]))
            options.append('[{}]{} all'.format(val[0].upper(), val[1:]))

        prompt_text = (
            'File already exists: {}\n'
            'What do you want to do?\n'
            '{}'
        ).format(target, ', '.join(options))

        # Show Prompt
        click.echo(prompt_text)

        # Get and validate input
        action = ' '
        while action.lower() not in mapping:
            action = click.getchar()
            click.echo(action)

        # Set the action
        val = mapping[action.lower()].split()[0]

        if action.isupper():
            self.global_action = val

        return val

    def find_files_to_symlink(self, topics):
        walk_dir = self.source_dir.rstrip(os.path.sep)
        base_depth = walk_dir.count(os.path.sep)
        # assert os.path.isdir(walk_dir)
        # if topics and 'base' not in topics:
        #     log.info('Adding topic {!r}', 'base')

        for root, dirs, files in os.walk(walk_dir):
            current_depth = root.count(os.path.sep)

            # Filter topics
            # if current_depth == 0 and topics:
            #     for item in dirs[:]:
            #         if item not in topics:
            #             dirs.remove(item)
            #             log.info('Skipping topic: {}'.format(item))

            # Skip .git folders
            if '.git' in dirs:
                dirs.remove('.git')

            # yield things to be symlinked
            for item in dirs + files:
                substr_length = len("symlink.")

                if item.startswith("symlink."):
                    target_name = item[substr_length:]
                elif item.endswith(".symlink"):
                    target_name = item[:-substr_length]
                else:
                    continue
                source = os.path.join(root, item)
                target = self.compute_target(
                    os.path.relpath(root, walk_dir),
                    target_name,
                )

                yield source, target

            # Ensure we don't recurse more than the allowed limit
            if current_depth >= base_depth + self.walk_depth:
                del dirs[:]

    def compute_target(self, relative_directory_path, dest_name):
        topic_unused, *parts = relative_directory_path.split(os.sep)

        # Add the "." to make it a dotfile
        if not parts:
            dest_name = "." + dest_name
        else:
            parts[0] = "." + parts[0]

        final_parts = parts + [dest_name]
        return os.path.join(self.target_dir, *final_parts)

    def backup_file(self, fname):
        run('mv "{0}" "{0}.backup"'.format(fname), self)

    def remove_file(self, fname):
        run('rm "{}"'.format(fname), self)

    def sync(self, topics):
        """Symlinks the dotfiles in the source_dir with target_dir

        Structure of dotfiles:
          - topic-1/
            - content-file-1.shrc
            - content-file-2.symlink
            - content-file-3.zsh
          - topic-2/
            - content-file-1.shrc
            - content-file-2.symlink
            - content-file-3.zsh
        """
        if not self.dry_run:
            # Write the location of the dotfiles repository in a file
            path = os.path.join(self.target_dir, '.dotfiles-dir')
            with open(path, 'w') as f:
                f.write(self.source_dir)

        for source, target in self.find_files_to_symlink(topics):
            # Determine what to do with target
            if os.path.islink(target):
                if os.readlink(target) == source:  # link is up to date
                    action = 'up to date'
                else:  # link needs updating
                    action = 'update'
            elif not os.path.exists(target):
                action = 'create'
            else:
                action = self.get_action(target)

            if target.startswith(HOME_DIR + os.sep):
                status_target = "~" + target[len(HOME_DIR):]
            else:
                status_target = target
            log.spaced_status(action, status_target)

            # Take the required action
            if action in ['skip', 'up to date']:
                continue  # no action needed.
            elif action == 'backup':
                self.backup_file(target)
            elif action == 'update':
                self.remove_file(target)

            self.link_source_to_target(source, target)

        self.clean()

    def is_broken_symlink(self, path):
        return os.path.islink(path) and not os.path.exists(path)

    def clean(self):
        """Removes stale symlinks from target_dir
        """
        for item in os.listdir(self.target_dir):
            path = os.path.join(self.target_dir, item)
            # If symlink is broken
            if self.is_broken_symlink(path):
                if not self.dry_run:
                    run('rm "{}"'.format(path), self)
                log.spaced_status('remove', path)
