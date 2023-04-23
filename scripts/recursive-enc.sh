#!/usr/bin/bash

if [[ ! -f .secret ]]; then
  echo "No .secret file"
  exit 1
fi

if [[ $# -eq 1 ]] && [[ $1 == "e" ]]; then
  for file in $(find . -type f | grep -ve ".git/.*"); do
    if [[ $file != "./.secret" ]]; then
      new_file_name="$(dirname $file)/$(basename $file | cut -d/ -f 2- | openssl aes-256-cbc -e -iter +2 -nosalt -kfile .secret | openssl base64 -e | sed "s/\//=-/g")"
      openssl aes-256-cbc -e -iter +2 -nosalt -kfile .secret -in $file -out $new_file_name

      if [[ $? -eq 0 ]]; then
        rm $file
      else
        echo "Could not encrypt file $file to $new_file_name"
        rm -f $new_file_name
      fi
    fi
  done

  for folder in $(find . -type d | grep -ve ".git/.*" | sort -r); do
    if [[ $folder != "." ]] && [[ $folder != "./.git" ]]; then
      new_folder_name="$(dirname $folder)/$(basename $folder | cut -d/ -f 2- | openssl aes-256-cbc -e -iter +2 -nosalt -kfile .secret | openssl base64 -e | sed "s/\//=-/g")"
      mv $folder $new_folder_name
    fi
  done
elif [[ $# -eq 1 ]] && [[ $1 == "d" ]]; then
  for folder in $(find . -type d | grep -ve ".git/.*" | sort -r); do
    if [[ $folder != "." ]] && [[ $folder != "./.git" ]]; then
      new_folder_name="$(dirname $folder)/$(basename $folder | cut -d/ -f 2- | sed "s/=-/\//g" | openssl base64 -d | openssl aes-256-cbc -d -iter +2 -nosalt -kfile .secret)"
      mv $folder $new_folder_name
    fi
  done

  for file in $(find . -type f | grep -ve ".git/.*"); do
    if [[ $file != "./.secret" ]]; then
      new_file_name="$(dirname $file)/$(basename $file | cut -d/ -f 2- | sed "s/=-/\//g" | openssl base64 -d | openssl aes-256-cbc -d -iter +2 -nosalt -kfile .secret)"
      mkdir -p $(dirname $new_file_name)
      openssl aes-256-cbc -d -iter +2 -nosalt -kfile .secret -in $file -out $new_file_name

      if [[ $? -eq 0 ]]; then
        rm $file
      else
        echo "Could not decrypt file $file"
        rm -f $new_file_name
      fi
    fi
  done
else 
  echo "$0 <e|d>"
  exit 1
fi
