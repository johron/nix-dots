function nix-update
    set -l orig_cwd (pwd)

    cd ~/nix-dots || return

    nix flake update
    or begin
        cd $orig_cwd
        return 1
    end

    nh os switch
    or begin
        cd $orig_cwd
        return 1
    end

    flatpak update -y

    cd $orig_cwd
end

function nix-has-update
    set -l orig_cwd (pwd)

    cd ~/nix-dots || return

    nix flake update --output-lock-file /tmp/nix-has-update.lock
    if ! diff -q flake.lock /tmp/nix-has-update.lock >/dev/null 2>&1; then
        echo "has update?!!?"
    end
end