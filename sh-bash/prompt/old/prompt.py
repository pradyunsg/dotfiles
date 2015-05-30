import os
import sys
import shlex
import subprocess

#------------------------------------------------------------------------------
# Constants
#------------------------------------------------------------------------------
SYMBOLS = {
    "user": ">",
    "root": "#",

    "history": "!",
    "command_no": "#",

    "ahead": "↑",
    "behind": "↓",
    "upstream": "→",
    "detached": ":",

    "dirty": "✘",
    # "dirty": "",
    "clean": "✔",

    "modified": "≠",
    "deleted": "-",
    "unmerged": "!",
}


#------------------------------------------------------------------------------
# Convenience functions
#------------------------------------------------------------------------------
def pad(text, pad_with="  "):
    """A convenience function for adding spaces to both sides of the text
    """
    return "{1[0]}{0}{1[1]}".format(text, pad_with)


def get_output(command, **kwargs):
    r"""Run command with arguments and return its output.
    """
    cmd = shlex.split(command)
    kwargs.update(stderr=subprocess.DEVNULL, universal_newlines=True)

    with subprocess.Popen(cmd, stdout=subprocess.PIPE, **kwargs) as process:
        try:
            output, _ = process.communicate()
        except Exception:
            process.kill()
            process.wait()
            raise
    return output.strip()


#------------------------------------------------------------------------------
# Output management
#------------------------------------------------------------------------------
class ANSIOutput(object):
    """Wrapper for text output for printing with ANSI support
    """

    def __init__(self, stream=sys.stdout):
        super(ANSIOutput, self).__init__()
        self._stack = []
        self.stream = stream

    def __call__(self, **kwargs):
        self.start(**kwargs)
        return self

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.stop()
        return exc_type is None

    def start(self, fg=None, bg=None, bold=False, underline=False, reverse=False):  # noqa
        """Add the ANSI escape codes to color text with the color specified.

        `fg` and `bg` are used as a 216 color value,
        """
        args = dict(
            fg=fg, bg=bg, bold=bold, underline=underline, reverse=reverse
        )
        self._stack.append(args)
        self.write(self._escape_code(**args))

    def _escape_code(self, fg, bg, bold, underline, reverse):
        params = []
        if bold:
            params.append(1)
        if underline:
            params.append(4)
        if reverse:
            params.append(7)
        if fg:
            params.extend([38, 5, fg])
        else:
            params.append(39)
        if bg:
            params.extend([48, 5, bg])
        else:
            params.append(49)
        return "\[\033[{}m\]".format(";".join(str(x) for x in params))

    def stop(self):
        self.write("\[\033[0m\]")
        self._stack.pop(-1)
        # Re-start the previous escape code!
        if self._stack:
            self.write(self._escape_code(**self._stack[-1]))

    def write(self, text):
        self.stream.write(text)


#------------------------------------------------------------------------------
# Information extraction
#------------------------------------------------------------------------------
class Git(object):
    """Figure out and provide the information related to git
    """

    def in_repo(self):
        pipe = subprocess.Popen(
            shlex.split("git rev-parse --is-inside-work-tree"),
            stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT
        )
        with pipe:
            pipe.communicate()
        return pipe.returncode == 0

    def get_info(self):
        di = {}
        if not self.in_repo():
            return di

        di["attached"] = self.is_head_attached()
        if di["attached"]:
            # Branch information
            branch_name, upstream_info = self.branch_info()
            di["branch_name"] = branch_name
            # Upstream information
            if upstream_info is not None:
                upstream, (ahead, behind) = upstream_info
                di["upstream"] = upstream
                di["ahead"] = ahead
                di["behind"] = behind
        else:
            # Detached HEAD, only commit hash
            di["commit_hash"] = self.detached_hash()

        # Working directory information
        working = self.working_dir_info()
        di["modified"] = working[0]
        di["deleted"] = working[1]
        di["unmerged"] = working[2]
        di["dirty"] = bool(sum(working))
        return di

    def is_head_attached(self):
        """Parse the symbolic ref to figure out what we are need to refer to.
        """
        self._HEAD = get_output("git symbolic-ref HEAD")
        return self._HEAD.startswith("refs/heads/")

    # HEAD Information
    def detached_hash(self):
        """Get the hash of the commit the HEAD points to.
        """
        return get_output("git rev-parse --short=20 HEAD")

    # Branch Information
    def branch_info(self):
        """Get the information about the branch.
        """
        branch_name = self._HEAD[11:]  # Branch name
        return branch_name, self.upstream_info(branch_name)

    # Upstream Information
    def upstream_info(self, branch_name):
        """Get the information about the upstream.
        """
        # Get the upstream if it exists.
        upstream = get_output(
            "git rev-parse --abbrev-ref {}@{{upstream}}".format(branch_name)
        )
        # There is no upstream, there can't be divergence.
        # The 2nd condition is for empty repositories.
        if not upstream or upstream == branch_name + "@{upstream}":
            return None, (0, 0)
        else:  # There is upstream. Check for divergence.
            divergence = get_output(
                "git rev-list --count --left-right {}...HEAD".format(upstream)
            )
            return upstream, tuple(map(int, divergence.split()))

    # Working Directory Information
    def working_dir_info(self):
        def count_files(opt):
            return len(get_output("git ls-files -" + opt).splitlines())
        # print(get_output("git ls-files -o"))
        modified = count_files("m")
        deleted = count_files("d")
        unmerged = count_files("u")
        return modified, deleted, unmerged


class General(object):

    def get_info(self):
        di = {}
        # Let the shell handle these!
        di["directory"] = "\\w"
        di["history"] = "\\!"
        di["command_no"] = "\\#"
        di["jobs"] = "[\\j]" if int(sys.argv[2]) else None
        di["last_success"] = sys.argv[1] == "0"
        di["root"] = os.geteuid() == 0
        return di


class VirtualEnv(object):

    def get_info(self):
        di = {}
        # Get the venv name
        name = os.environ.get("VIRTUAL_ENV", None)
        if name is not None:
            name = os.path.basename(name)
        di["name"] = name
        return di


#------------------------------------------------------------------------------
# Printing the information
#------------------------------------------------------------------------------
def print_formatted_prompt(general, git, venv):
    # Jobs (only if there are any)
    if general["jobs"]:
        with ansi(bg=210):
            ansi.write(pad(general["jobs"]))
    # Command No.
    with ansi(bg=141):
        ansi.write(pad(SYMBOLS["command_no"] + general["command_no"]))
    # History
    with ansi(bg=210):
        ansi.write(pad(SYMBOLS["history"] + general["history"]))
    # Git
    print_formatted_git(**git)
    # VirtualEnv
    if venv["name"] is not None:
        with ansi(bg=105):
            ansi.write(pad(venv["name"]))

    ansi.write("\n")

    # Directory
    with ansi(bg=33):
        ansi.write(pad(general["directory"]))

    ansi.write("\n")

    # Prompt
    if general["root"]:
        prompt_symbol = SYMBOLS["root"]
    else:
        prompt_symbol = SYMBOLS["user"]
    if general["last_success"]:
        prompt_colors = dict(bg=70)
    else:
        prompt_colors = dict(bg=1)

    with ansi(**prompt_colors):
        ansi.write(pad(prompt_symbol))

    ansi.write(" ")


def print_formatted_git(
        attached=None, commit_hash="",
        branch_name="", upstream="", ahead=None, behind=None,
        modified=0, deleted=0, unmerged=0, dirty=True
    ):

    # Not in a git repo!
    if attached is None:
        return

    if not attached:
        with ansi(fg=240, bg=254):
            ansi.write(pad(SYMBOLS["detached"] + commit_hash))
        return
    with ansi(fg=240, bg=254):
        ansi.write(" ")

        # Branch information
        ansi.write(branch_name)
        if upstream:
            ansi.write(SYMBOLS["upstream"])
            ansi.write(upstream)
            if ahead:
                ansi.write(" ")
                with ansi(fg=2, bg=254):
                    ansi.write(SYMBOLS["ahead"])
                    ansi.write(str(ahead))
            if behind:
                ansi.write(" ")
                with ansi(fg=1, bg=254):
                    ansi.write(SYMBOLS["behind"])
                    ansi.write(str(behind))

        if dirty:
            ansi.write(" ")
            with ansi(fg=124, bg=254):
                ansi.write(SYMBOLS["dirty"])
            # Working directory information
            if modified or True:
                with ansi(fg=244, bg=254):
                    ansi.write(" ")
                    ansi.write(SYMBOLS["modified"])
                    ansi.write(str(modified))
            if deleted or True:
                with ansi(fg=244, bg=254):
                    ansi.write(" ")
                    ansi.write(SYMBOLS["deleted"])
                    ansi.write(str(deleted))
            if unmerged or True:
                with ansi(fg=244, bg=254):
                    ansi.write(" ")
                    ansi.write(SYMBOLS["unmerged"])
                    ansi.write(str(unmerged))

        ansi.write(" ")


# Keep a global object.
ansi = ANSIOutput()


def main():
    # Extract all the information
    git = Git().get_info()
    general = General().get_info()
    venv = VirtualEnv().get_info()

    # Write the information
    print()
    print_formatted_prompt(general, git, venv)
    print()
    print()

if __name__ == '__main__':
    main()
