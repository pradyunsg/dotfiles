# pradyunsg's dotfiles

## Setting up a new machine

Clone this repository and run the sync script.

```bash
mkdir ~/Developer && cd ~/Developer && \
  git clone https://github.com/pradyunsg/dotfiles.git && cd dotfiles && \
  scripts/sync
```

## Functional overview

This follows a topical layout (taking inspiration from [@holman's dotfiles](https://github.com/holman/dotfiles)) where each topic is a directory containing related files. The home directory's files are symlinks to the actual files in this repository's clone.

This repository's is managed as a symlink farm, with the logic for managing the farm living in `scripts/sync`.

## Additional repositories

This setup uses a `~/.dotfiles.toml` file for determining what files need to be brought over. This is intended to be customizable.

You can add an additional repository by name, by adding another entry to the `[repositories]` table in the `~/.dotfiles.toml` file.

```
[repositories]
personal = "/Users/pradyunsg/dotfiles"
work = "/Users/pradyunsg/work-dotfiles"
```

### Resolving conflicts between repositories

If two repositories provide the same dotfile, you can set up an override using the `[[conflicts]]` array of tables.

```
[[conflicts]]
file = ".bashrc"
use = "work"

[[conflicts]]
file = ".zshrc"
use = "personal"
```

## License

The contents of this repository are licensed under the GPL v3 license.
