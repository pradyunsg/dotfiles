import os

HOME_DIR = os.path.expanduser('~')
ROOT_DIR = os.path.abspath(os.path.dirname(os.path.dirname(__file__)))

DEFAULT_SOURCE_DIR = os.path.join(ROOT_DIR, "src")
ACTION_COLOR_DICT = {
    'backup': 'magenta',
    'create': 'cyan',
    'remove': 'red',
    'skip': 'magenta',
    'up to date': 'green',
    'update': 'blue',
    'outdated': 'red',
    # For SystemChecker
    'topic': 'magenta',
    'pass': 'green',
    'fail': 'red',
    'warn': 'yellow',
}
