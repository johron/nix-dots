function p --description 'cd to ~/Projects/<name>'
    set -l root $HOME/Projects

    if test (count $argv) -eq 0
        cd $root
        return
    end

    cd $root/(string join / $argv)
end

function __p_complete
    set -l token (commandline -ct)
    set -l root $HOME/Projects

    __fish_complete_directories $root/$token \
        | string replace -r "^$(string escape --style=regex $root)/" ''
end

complete -c p -f -a '(__p_complete)'