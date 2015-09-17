# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi

PS1='\h:\W \u\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize
# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
	local SEARCH=' '
	local REPLACE='%20'
	local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
	printf '\e]7;%s\a' "$PWD_URL"
    }
    PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
fi

if [ -f ${HOME}/.bashrc_addon ]; then
	source ${HOME}/.bashrc_addon
fi

PAGER=/opt/local/bin/most
export PAGER

alias pg_start='sudo su - postgres -c "/opt/local/lib/postgresql94/bin/pg_ctl start -D /opt/local/var/db/postgresql94/defaultdb -l /tmp/postgresql.log"'
alias pg_stop='sudo su - postgres -c "/opt/local/lib/postgresql94/bin/pg_ctl stop -D /opt/local/var/db/postgresql94/defaultdb"'
alias tmux='TERM=screen-256color-bce tmux -2'

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/jsumners/.gvm/bin/gvm-init.sh" ]] && source "/Users/jsumners/.gvm/bin/gvm-init.sh"
