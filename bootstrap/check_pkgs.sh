#!/bin/sh

CSV_FILE="pkgs.csv"
CSV_PACKAGES=$(tail -n +2 "$CSV_FILE" | cut -d, -f1)
INSTALLED_PACKAGES=$(brew leaves | awk '{print $1}')

for package in $CSV_PACKAGES; do
  if ! grep -q "^$package$" <<<"$INSTALLED_PACKAGES"; then
    echo "Package $package from CSV is not installed."
  fi
done

echo

for package in $INSTALLED_PACKAGES; do
  if ! grep -q "^$package$" <<<"$CSV_PACKAGES"; then
    echo "Package $package is installed but not in CSV."
  fi
done
