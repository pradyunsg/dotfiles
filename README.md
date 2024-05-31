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

## License

The contents of this repository are licensed under the GPL v3 license.
