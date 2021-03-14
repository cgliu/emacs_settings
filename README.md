# My Emacs settings
## installation
    Open a terminal and run:
    git clone https://github.com/cgliu/emacs_settings.git ~/.emacs.d

    All done. Enjoy!

## Tips
### Unity 'Emacsclient -c' launcher
   - copy ./desktop/emacsclient.desktop to
     ~/.local/share/applications/

### Shell alias
    alias em='env TERM=xterm-256color  emacsclient -t "$@"'
