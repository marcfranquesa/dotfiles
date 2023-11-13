for file in ~/.{aliases,bindkeys,exports,extra,functions,zsh_prompt}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;