#!/bin/bash

NOTES_DIR=${NOTES_DIR:-$HOME/notes}
SESSION_FILE=${SESSION_FILE:-$HOME/notes.vim}

open() {
  vim \
    -S $SESSION_FILE \
    -c ":cd $NOTES_DIR" \
    -c ":command Z execute \"e \`openssl rand -hex 4\`.md\"" \
    -c ":command SaveSession execute \"mks! $SESSION_FILE\"" \
    -c ":command -nargs=1 FindRecursive execute \"vim \" . <f-args> . \" ** | cw\"" \
    -c ":command -nargs=1 FindThere execute \"vim \" . <f-args> . \" * | cw\"" \
    -c ":command CopyPath execute \":let @\\\"=@%\"";
}

search() {
  local command="find $NOTES_DIR -type f"

  for word in $1; do
    command="$command -exec grep -qi $word {} ';'";
  done

  eval "$command -exec echo {} ';'";
}

if [ $# -eq 0 ]; then
  open;
elif [ $# -eq 2 ] && [ $1 == "search" ]; then
  search "$2";
fi
