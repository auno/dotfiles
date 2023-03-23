# vim: set ts=4 sw=4 expandtab:
#
if type fzf > /dev/null; then
    if type fd > /dev/null; then
        FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null"
        FZF_CTRL_T_COMMAND="fd --strip-cwd-prefix --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null"
        FZF_ALT_C_COMMAND="fd --strip-cwd-prefix --type d --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null"

        _fzf_compgen_path () {
            echo "$1"
            command fd --strip-cwd-prefix --hidden --exclude .git --exclude .hg --exclude .svn "$1" 2> /dev/null
        }

        _fzf_compgen_dir () {
            command fd --strip-cwd-prefix --type d --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null
        }
    fi

    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
fi
