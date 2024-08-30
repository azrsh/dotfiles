icd() {
  while true; do
    local dir="$(setopt -s nullglob; find .. .* * -maxdepth 0 -type d | peco)"
    if [ -n "${dir}" ]; then
      cd "${dir}"
    else
      return 0
    fi
  done
}
hcd() {
  local dir="$(cdr -l | awk '{ print $2 }' | peco)"
  if [ -n "${dir}" ]; then
    eval dir=${dir} # tilde expansion
    cd "${dir}"
  fi
}

tob() {
  cd "$(git rev-parse --show-toplevel)" && \
    for dir in $(git rev-parse --abbrev-ref HEAD | tr "/" " "); do
      cd "${dir}";
    done
}
tob2() {
  local list="$(cat \
    <(git ls-files --others --exclude-standard --full-name) \
    <(git diff --name-only --merge-base $(git symbolic-ref refs/remotes/origin/HEAD)))"
  local res=()
  while true; do
    local xor="$(echo "${list}" | awk 'BEGIN { FS="/" } { print $1 }' | uniq -u)"
    local and="$(echo "${list}" | awk 'BEGIN { FS="/" } { print $1 }' | uniq -d)"
    if [ -n "${xor}" ] || [ -z "${and}" ]; then
      break
    fi
    res+=("${and}")
    list="$(echo "${list}" | sed 's/^[^\/]*\///')"
  done
  cd "$(git rev-parse --show-toplevel)/$(IFS='/'; echo "${res[*]}")"
}
ghcd() {
  local repo="$(ghq list | peco)"
  if [ -n "${repo}" ]; then
    cd "$(ghq root)/${repo}"
  fi
}
gwcd () {
  local tree="$(git worktree list | peco)"
  if [ -n "${tree}" ]; then
    cd "$(echo "${tree}" | awk '{ print $1 }')"
  fi
}
gwcdc() {
  local branch="${1}"
  if [ -z "${branch}" ]; then
    echo "no branch name is provided"
    return 1
  fi

  local top="$(git rev-parse --show-toplevel 2> /dev/null)"
  if [ -z "${top}" ]; then
    echo "This is not Git directory"
    return 1
  fi

  local dir=".local/$(echo "${branch}" | tr '/' '-')"
  cd "${top}" && \
    git branch "${branch}" && \
    git worktree add "${dir}" "${branch}" && \
    cd "${dir}"
}

export EDITOR=vim
set -o vi

setopt share_history

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
