#!/usr/bin/python3.4
"""A bright scheme ideal for slightly transparent dark backgound terminals.
"""
#------------------------------------------------------------------------------
# Configuration
#------------------------------------------------------------------------------
terminals = """
    Eterm ansi dvtm dtterm cygwin console fbterm kterm jfbterm mlterm vt100
    cons25 con132x25 con132x30 con132x43 con132x60
    con80x25 con80x28 con80x30 con80x43 con80x50 con80x60
    eterm-color
    gnome gnome-256color
    konsole konsole-256color
    linux linux-c mach-color
    putty putty-256color
    rxvt rxvt-256color rxvt-cygwin rxvt-cygwin-native rxvt-unicode
    rxvt-unicode-256color rxvt-unicode256
    screen screen-bce screen-w screen.linux
    screen-16color screen-16color-bce screen-16color-bce-s screen-16color-s
    screen-256color screen-256color-bce screen-256color-bce-s screen-256color-s
    st st-256color st-meta st-meta-256color
    xterm xterm-16color xterm-256color xterm-88color xterm-debian xterm-termite
    color-xterm xterm-color
"""

extensions = {
    "audio": (
        ".aac .au .axa .flac .m4a .mid .midi .mka .mp3 .mpc .oga .ogg "
        ".ra .spx .wav .xspf"
    ),
    "video": (
        ".anx .asf .avi .axv .divx .flc .fli .flv .gl .m2ts .m2v .m4v .mkv "
        ".mov .mp4 .mp4v .mpeg .mpg .nuv .ogm .ogv .ogx .qt .rm .rmvb .vob "
        ".webm .wmv"
    ),
    "image": (
        ".jpg .jpeg .gif .bmp .pbm .pgm .ppm .tga .xbm .xpm .tif .tiff .png "
        ".svg .svgz .mng .pcx .xcf .xwd .yuv .cgm .emf .eps .CR2 .ico .dl "
        ".JPG .JPEG .PNG .GIF .BMP .TIF .SVG .ICO"
    ),
    "unimportant": (
        "*# *~ .aux .bak .bbl .blg .cache .class .incomplete .lof .log .lol "
        ".lot .o .out .part .pyc .pyo .swp .temp .tmp .toc"
    ),
    "archive": (
        ".7z .ace .apk .arj .bz .bz2 .cpio .deb .dz .gem .gz .jar .lz .lzh "
        ".lzma .rar .rpm .rz .tar .taz .tbz .tbz2 .tgz .tlz .txz .tz .xz "
        ".z .Z .zip .zoo"
    ),
    "dev-code": (
        ".c .cpp .cxx .c++ .cc .h .hpp .java .objc .lua .php .go .as "
        ".py .py3 .sh .pl .rb .js .css "
    ),
    "dev-doc": (
        "*readme *readme.txt *readme.markdown .md .rst "
        "*README *README.TXT *README.MARKDOWN .MD .RST"
    ),
    "dev-build": "*Makefile *Rakefile *build.xml .travis.yml .coveralls.yml",
    "config": "*1 *rc .cfg .conf .ini .nfo .tex .xml .yml",

    # Files
    "file": "FILE",
    "file-exec": "EXEC",

    # Directory
    "dir": "DIR",

    # Links
    "link": "LINK",
    "link-multi": "MULTIHARDLINK",
    "link-orpah": "ORPHAN",

    # Specials
    "pipe": "FIFO",
    "socket": "SOCK",
    # "door": "DOOR",
    # "device_driver-block": "BLK",
    # "device_driver-character": "CHR",

    # # Special files
    # "file-capability": "CAPABILITY",  # file with capability
    # "file-setuid": "SETUID",          # file that is setuid (u+s)
    # "file-setgid": "SETGID",          # file that is setgid (g+s)

    # # Special Directories
    "dir-sticky": "STICKY",                              # dir with the sticky bit set (+t) and not other-writable
    "dir-other_writable": "OTHER_WRITABLE",              # dir that is other-writable (o+w) and not sticky
    "dir-sticky-other_writable": "STICKY_OTHER_WRITABLE",  # dir that is sticky and other-writable (+t,o+w)

    # Reset to "normal" color
    "reset": "RESET",
}

colors = {
    "audio":       "38;5;127",  # 3/5*Red + 3/5*Blue
    "video":       "38;5;138",  # Light Brown
    "image":       "38;5;208",  # Orange
    "unimportant": "38;5;244",  # 50% Grey
    "archive":     "38;5;170",  # Bright-1 (Slightly Dark) Pink
    "dev-code":    "38;5;51",  # Cyan
    "dev-doc":     "38;5;19",  # Bright-3 Blue
    "dev-build":   "38;5;93",  # Purple + 3Blue
    "config":      "38;5;37",  # Dark Cyan

    # Files
    "file": "38;5;15",  # White
    "file-exec": "38;5;40",  # Bright-1 (Slightly Dark) Green

    # Directory
    "dir": "38;5;33",  # Pure Blue

    # Links
    "link": "38;5;227",  # Bright-1 (Slightly Dark) Yellow
    "link-multi": "38;5;227",  # Bright-1 (Slightly Dark) Yellow
    "link-orpah": "38;5;160",  # Bright-1 (Slightly Dark) Red

    # Specials
    "pipe": "38;5;136",  # Olive Green
    "socket": "38;5;136",  # Olive Green
    # "door": "",
    # "device_driver-block": "",
    # "device_driver-character": "",

    # # Special files
    # "file-capability": "",
    # "file-setuid": "",
    # "file-setgid": "",

    # # Special Directories
    "dir-sticky": "38;5;13",
    "dir-other_writable": "38;5;13",
    "dir-sticky-other_writable": "38;5;57",

    # Reset to "normal" color
    "reset": "0",
}
# Final checks
if not list(sorted(extensions)) == list(sorted(colors)):
    raise AssertionError(
        "{} != {}".format(list(sorted(extensions)), list(sorted(colors)))
    )
#------------------------------------------------------------------------------
# Output
#------------------------------------------------------------------------------

# List all terminals
for term in terminals.split():
    print("TERM", term)
# Print information
for obj_type in sorted(extensions):
    color = colors[obj_type]
    for ext in extensions[obj_type].split():
        print(ext, color)
