#!/bin/zsh

git pull origin main;

function main() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "sync.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
        --exclude ".gitignore" \
		--exclude ".secrets" \
		--exclude "tests" \
		-avh --no-perms . ~
}

if [[ $1 == "--force" || $1 == "-f" ]]; then
	main;
else
	read -q "REPLY?This may overwrite existing files in your home directory. Are you sure? (y/n) "
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		main;
	fi;
fi;
unset main;

