[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
[ -d /usr/share/bash-completion/completions ] && . "/usr/share/bash-completion/completions/*"

# BASH COMPLETION by mrrw:
set completion-ignore-case 'on'
# https://superuser.com/questions/288714/bash-autocomplete-like-zsh
#bind 'set show-all-if-ambiguous on'
bind TAB:complete # COMPLETES IF ONLY ONE OPTION EXISTS
bind TAB:menu-complete # CYCLES THROUGH POSSIBLE COMPLETION OPTIONS
#TAB_menu-complete   #### BROKEN
#Tab: menu-complete  #### BROKEN
set show-all-if-ambiguous on
#set TAB_menu-complete on
# end section'by mrrw'
