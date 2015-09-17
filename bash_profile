if [ -f ${HOME}/.bashrc ]; then
	source ${HOME}/.bashrc
fi

# MacPorts Installer addition on 2014-12-05_at_10:29:38: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/jsumners/.gvm/bin/gvm-init.sh" ]] && source "/Users/jsumners/.gvm/bin/gvm-init.sh"
