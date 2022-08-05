# Dotfiles

(and a bit more)

This project contains most of my personal configs and some scripts I frequently use.

This config has been built for years to suit my preferences and is still being updated. You might use everything you want from it, even if I would recommend not using it as-is.

## Installation

Most folders have `init.sh` and `setup.sh` scripts. The `init.sh` script created everything needed for local, uncommitted customization. The `setup.sh` script does the setup to use the config in the folder on the machine, usually by creating symlinks.

There is also `init.sh` and `setup.sh` scripts at the repository root. `init.sh` root script will symlink the directory to `~/.dotfiles` and run all subfolders `init.sh` scripts. The `setup.sh` root script will run all subfolders `setup.sh` scripts.

## Contributing

This is my personal configs. I will most likely change it only if my needs change.

However, you are welcome to open a discussion if you want to discuss some configs or want to let me know about some awesome options that I might not know.
