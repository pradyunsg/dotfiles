<h1 align="center">
  pradyunsg's Dotfiles
</h1>
<p align="center">
  Magical objects that make certain computers extremely use-able for me.
</p>

<p align="center">
  <a href="#installation">Installation</a> |
  <a href="#customization">Customization</a> |
  <a href="#license">License</a> |
  <a href="#contributing">Contributing</a> |
  <a href="#acknowledgements">Acknowledgements</a>
</p>

<p align="center">
  <img src="docs/README-image.png" alt="Screenshot of my terminal set-up as on 2020-08-11"/>
</p>


## Installation

This is a manual step currently.

1. Set up Python 3.4+ on the system.
2. Create a virtual environment for housing dotfiles-related dependencies and
   activate it.
3. Run `python manage sync` to create the required symlinks.
4. (WIP) Run `python manage check` to see what more needs to be done to fully
   configure the system.

## Customization

You can do customization using `.local` files:

- `~/.gitconfig.local`
  - This is sourced before any other files from this folder.
- `~/.zshrc.local`
  - This is sourced before any other files from this folder.

These `.local` files can be used to add a few personal stuff without the need
to fork this entire repository, or to add commands you don’t want to commit to
a public repository.

Make sure you create a `~/.gitconfig.local` for storing your credentials. Here's a template, if you're feeling lazy (replace everything in `{}` including the braces) :

```ini
[user]
    email = {your-email-id@example.com}
    name = {Your Name}

# Pro-tip: This makes working with sub-modules easier.
[url "git@github.com:{your-github-username-here}/"]
    insteadOf = "git://github.com/{your-github-username-here}/"
```

As things currently stand, these 2 files can modify nearly everything.

## License

The contents of this repository are licensed under the MIT license.

## Contributing

If you have any ideas or suggestions, feel free to open up an issue or shoot through a pull request! Thanks!

Feel free to fork whenever you want!

## Acknowledgements

Uses parts of or inspired by:

- [@nicksp](https://github.com/nicksp/dotfiles)
- [@westurner](https://github.com/westurner/dotfiles)
- [@holman](https://github.com/holman/dotfiles)
- [@jeffaco](https://github.com/jeffaco/dotfiles)
- [@paulmillr](https://github.com/paulmillr/dotfiles)
- [@mathiasbynens](https://github.com/mathiasbynens/dotfiles)
- I'm sure there's more places that I've lost track of. :sweat_smile:
