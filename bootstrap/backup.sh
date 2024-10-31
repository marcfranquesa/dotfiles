#!/bin/sh

# script to backup $HOME

# useful command in mac, fixes issues with permissions in external drive
# diskutil resetUserPermissions / `id -u`

volumes_path="/Volumes"
regex_volumes_ignore="^(Macintosh HD)$"

volumes=$(ls "$volumes_path" | grep -v -E "$regex_volumes_ignore")

echo "These are the currently mounted devices, pick one to continue.\n"
echo "$volumes" | awk '{print NR ") " $0}'

echo
read -p "Select a volume by number or name: " selection
while :; do
    if echo "$selection" | grep -qE '^[0-9]+$'; then
        volume=$(echo "$volumes" | awk -v sel="$selection" 'NR==sel')
    else
        volume="$selection"
    fi

    if [ -n "${volume}" ] && [ -d "${volumes_path}/${volume}" ]; then
        break
    fi

    read -p "Volume: '${volume}' is invalid, select a different volume by number or name: " selection
done

echo "\nUsing volume '${volume}'."

backups_path="${volumes_path}/${volume}/backups"
if [ ! -d "${backups_path}" ]; then
    echo "No backups folder found in '${volume}', creating it."
    mkdir ${backups_path}
fi

backups=$(ls "${backups_path}")

read -p "Do you want to create a new backup? (y/n): " answer
case "$answer" in
y | Y)
    read -p "Enter backup name: " backup
    if [ -d "${backups_path}/${backup}" ]; then
        echo "Backup '${backup}' already exists."
        exit 1
    fi
    echo "Creating backup '${backup}'."
    mkdir "${backups_path}/${backup}"
    ;;
*)
    if [ -z "${backups}" ]; then
        echo "No other backups found."
        exit 1
    else
        echo "\nThese are the existing backups, pick one to continue.\n"
        echo "${backups}" | awk '{print NR ") " $0}'

        echo
        read -p "Select a backup by number or name: " selection
        while :; do
            if echo "$selection" | grep -qE '^[0-9]+$'; then
                backup=$(echo "$backups" | awk -v sel="$selection" 'NR==sel')
            else
                backup="$selection"
            fi

            if [ -n "${backup}" ] && [ -d "${backups_path}/${backup}" ]; then
                break
            fi

            read -p "Backup: '${backup}' is invalid, select a different backup by number or name: "
        done
    fi
    ;;
esac

backup_path="${backups_path}/${backup}"

tool="cp -r"
if command -v rsync >/dev/null; then
    tool="rsync -avPh --delete --exclude={Library,.cache,.keyboards,.Trash,.local,gitclones,playground}"
fi

echo "\nBacking up '${HOME}' to '${backup_path}'"

# copy to today
today=$(date "+%Y-%m-%d")
today_path="${backup_path}/${today}"
mkdir -p "${today_path}"
eval ${tool} "${HOME}" "${today_path}"

# copy to latest
latest_path="${backup_path}/latest"
mkdir -p "${latest_path}"
eval ${tool} "${HOME}" "${latest_path}"
