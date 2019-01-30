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

![Preview Image](./docs/README-image.png)


> NOTE
> The prompt I use is currently not accessible to everyone.
> I'm currently working on improving it to a state where I'm comfortable
> releasing it in. Plus, it's slooow today. :)

## Installation

The current approach is a little weird. You need to have Python 3.4+
environment with `click > 6` and `PyYAML` installed.

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
