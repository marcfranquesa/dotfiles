for file in ~/.{aliases,exports,extra,functions,zsh_prompt}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;