function fish_prompt --description 'Write out the prompt'
    set -l suffix \n'$'
    echo (ps1-rs) "$suffix "
end
