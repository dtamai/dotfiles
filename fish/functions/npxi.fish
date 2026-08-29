function npxi --description 'Run a local node_modules/.bin command under node inspect'
    if test (count $argv) -eq 0
        echo "usage: npxi <bin> [args...]" >&2
        return 1
    end

    set -l bin $argv[1]
    set -l binpath ./node_modules/.bin/$bin

    if not test -e $binpath
        echo "npxi: $binpath not found (run from a project with that dependency installed)" >&2
        return 1
    end

    set -l rest
    if test (count $argv) -gt 1
        set rest $argv[2..-1]
    end

    env NODE_INSPECT_RESUME_ON_START=1 node inspect $binpath $rest
end
