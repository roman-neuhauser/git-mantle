#!/usr/bin/env zsh
# vim: ts=2 sts=2 sw=2 et fdm=marker cms=\ #\ %s

set -o no_unset
set -o err_return

function query-git # {{{
{
  local fmt=$1; shift
  git show --no-patch --format=$fmt "$@"
} # }}}

declare do_stat=--stat=72 output=

while [[ $# -gt 0 && $1 == -* ]]; do
  case $1 in
  --output=*) output=${1#--output=} ;;
  --output)   shift; output=$1 ;;
  --stat* | --numstat)
              do_stat=$1 ;;
  esac
  shift
done

if [[ -n $output ]]; then
  exec > $output
fi

declare base head public

if [[ $# -eq 0 ]]; then
  base="$(git config mantle.upstream || :)"
  head="$(git config mantle.public || :)"
elif [[ $# -eq 1 ]]; then
  base="$(git config mantle.upstream || :)"
  head=$1
else
  base=$1
  head=$2
fi

if [[ -z $base || -z $head ]]; then
  print -f 'usage: %s [options] [[base] head]\n' ${0##*/} >&2
  exit 1
fi

public=${head%%/*}

if [[ $base != */* ]]; then
  base="$(git symbolic-ref --short refs/remotes/$base/HEAD)"
fi

if [[ $head == */\* ]]; then
  head="$public/$(git symbolic-ref --short HEAD)"
fi

bhash="$(query-git '%h' $base -- || exit 1)"
hhash="$(query-git '%h' $head -- || exit 1)"

if [[ $# -eq 0 ]]; then
#  declare head="$(git symbolic-ref -q --short HEAD)"
#  [[ -z $head ]] && exit 1
#  # git-rev-parse complains if HEAD has no tracking branch configured
#  declare pubr="$(git rev-parse --abbrev-ref 'HEAD@{upstream}')"
#  [[ -z $pubr ]] && exit 1
fi

declare purl="$(git config --get remote.$public.url)"

declare -A chashes cmessages

# repo = git@github.com:roman-neuhauser/anarchinst.git
# head = 6a91ccd3 readme-updates
# base = c7303d75 master
#
print -f 'repo = %s\n' $purl
print -f 'head = %s %s\n' $hhash $head
print -f 'base = %s %s\n' $bhash $base

if [[ -n $do_stat ]]; then
  print
  git diff $do_stat $head --not $base
  print
fi

# git-rev-list --format (or --pretty) prepends each commit
# with "commit %H\n".  it's easier to parse if we throw away
# this %H instance and request another one in the format string.
git rev-list --format='%T %H %s' $head --not $base \
| while read x y z; do
    [[ $x == commit ]] && continue
    chashes+=($x $y)
    cmessages+=($x $z)
  done

# git rev-list --objects has the same output as without --objects,
# followed by, for each commit:
#   <tree-id> SP LF
#   <blob-id> SP <path> LF
#   ...
# we skip the initial run of lines that just list the <commit-id>s
git rev-list --reverse --objects $head --not $base \
| tail -n +$((1 + $#chashes)) \
| while read x y; do
    if [[ -z $y ]]; then # this is a <tree-id> line
      local chash=$chashes[$x]
      local cmesg=$cmessages[$x]
      print -f '# %s %s %s\n' ${x:0:8} ${chash:0:8} $cmesg
      continue
    fi
    print -f '  %s %s\n' ${x:0:8} $y
  done

