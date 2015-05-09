# MySQL
#alias mysql_start="sudo /usr/local/mysql/support-files/mysql.server start"
#alias mysql_stop="sudo /usr/local/mysql/support-files/mysql.server stop"
#alias mysql_restart="sudo /usr/local/mysql/support-files/mysql.server restart"

export SHELL=/usr/local/bin/bash

export PATH=/usr/local/Cellar/python/bin:/opt/local/mjprof1.0:~/.yscripts:$PATH
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH

# TODO: move somwhere else
# oracle
export PATH=$PATH:/opt/instantclient
export SQLPATH=/opt/instantclient
export DYLD_LIBRARY_PATH=/opt/instantclient

# MongoDB
alias mongo_start="mongod -dbpath /usr/local/var/mongodb"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

####
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/i307088/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# Move somewhere else 

# Vagrant
vssh () {
	vagrant ssh $1 -- -A
}

# Fleet/Vagrant
export FLEETCTL_TUNNEL=127.0.0.1:2222

