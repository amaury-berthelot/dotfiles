#/usr/bin/zsh

function fzjq {
  if [[ $# -eq 0 ]]; then
    cat /dev/stdin > .fzjq
    echo "" | fzf --preview "jq {q} < .fzjq"
    rm .fzjq
  elif [[ $# -eq 1 ]]; then
    echo "" | fzf --preview "jq {q} < $1"
  else
    echo "not valid"
  fi
}
