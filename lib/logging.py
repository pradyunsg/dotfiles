import click

from .config import ACTION_COLOR_DICT


class Logger(object):

    def __init__(self):
        super().__init__()
        self._indent = 0
        self._indent_size = 4

    def __enter__(self):
        self._indent += self._indent_size
        return self

    def __exit__(self, exception_type, exception_value, traceback):
        self._indent -= self._indent_size
        return True

    @staticmethod
    def style(msg, **kwargs):
        return click.style(msg, **kwargs)

    def _m(self, message, *args, **kwargs):
        # A shorthand for brevity
        if isinstance(message, str):
            return " " * self._indent + message.format(*args, **kwargs)
        else:
            assert not (args, kwargs)
            return " " * self._indent + repr(message)

    def info(self, message, *args, **kwargs):
        click.secho(self._m(message, *args, **kwargs))

    def error(self, message, *args, **kwargs):
        click.secho(self._m('ERROR: ' + message, *args, **kwargs), fg='red')

    def spaced_status(self, action, message, fit_width=10):
        colour = ACTION_COLOR_DICT.get(action, None)
        if colour is None:
            self.error(
                "Got unknown action for logger - {}; will continue though",
                action
            )

        s = click.style("[" + action.center(fit_width) + "]", fg=colour)
        self.info('{} {}', s, message)


log = Logger()
