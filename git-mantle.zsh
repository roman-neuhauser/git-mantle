#!/usr/bin/env zsh
# vim: ts=2 sts=2 sw=2 et fdm=marker cms=\ #\ %s

set -o no_unset
set -o err_return

function complain
{
  print ${@[2,-1]} >&2
  exit $1
}

function get-revhash # {{{
{
  git rev-list --max-count=1 "$@"
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

declare base head upstream public

mantle_upstream="$(git config mantle.upstream || :)"
mantle_upstream=${mantle_upstream:-upstream}
upstream=${mantle_upstream%%/*}
if [[ $mantle_upstream == ?*/?* ]]; then
  base=${mantle_upstream#*/}
else
  base=HEAD
fi

mantle_public="$(git config mantle.public || :)"
mantle_public=${mantle_public:-origin}
public=${mantle_public%%/*}
if [[ $mantle_public == ?*/?* ]]; then
  head=${mantle_public#*/}
else
  head=HEAD
fi

if (( $# > 1 )); then
  # slashless `base` is a *remote* name
  upstream=$1
  if [[ $upstream == ?*/?* ]]; then
    base=${upstream#*/}
    upstream=${upstream%%/*}
  fi
  shift
fi
if (( $# > 0 )); then
  # slashless `head` is a *branch* name
  head=$1
  if [[ $head == ?*/?* ]]; then
    public=${head%%/*}
    head=${head#*/}
  fi
fi

if [[ $base == HEAD ]]; then
  base=$(git symbolic-ref refs/remotes/$upstream/HEAD) || exit 1
  base=${base#refs/remotes/*/}
fi
if [[ $head == HEAD ]]; then
  head=$(git symbolic-ref HEAD)
  head=${head#refs/*/}
fi

declare bspec=$upstream/$base
declare hspec=$public/$head

declare bhash hhash

bhash="$(get-revhash ${bspec#./} -- || exit 1)"
hhash="$(get-revhash ${hspec#./} -- || exit 1)"

declare mbase="$(git merge-base $bhash $hhash)" \
|| complain $? "fatal: no commits in common between $base and $head"

# rev-list --count is a post-1.7.1 feature
declare -i nhashes="$(git rev-list $hhash --not $bhash | wc -l)"

(( $nhashes )) || complain 1 "fatal: '$bspec..$hspec' is an empty range"

declare purl="$(git config --get remote.$public.url)"
[[ -z $purl ]] && purl='?'

declare -A cmessages
declare -a parents
# git-rev-list --format (or --pretty) prepends each commit
# with "commit %H\n" so there's no need to request %H again
git rev-list --reverse --format='tree %T%nparent %P%ntitle %s' $hhash --not $bhash \
| while read k v; do
    case $k in
    commit) cid=$v ;;
    tree)   tid=$v ;;
    parent)
      pid=($=v)
      if (( $#pid > 1 )); then
        complain 1 "fatal: '$bspec..$hspec' contains a merge"
      fi
      parents+=($tid $cid "$pid")
    ;;
    title)  cmessages+=($tid $v) ;;
    esac
  done

declare -i i=0
declare -i seqwidth=$#nhashes
declare -i totseqwidth=$((1 + 2*seqwidth))
declare -a objects
for tid cid pid in $parents; do
  # git-diff-tree -r omits non-leaf paths,
  # that's nice as i don't want those anyway
  # -M is the only spelling of --find-renames
  # available in git-1.7.1
  git diff-tree -M -r $pid $cid \
  | while IFS=$'\t' read meta srcpath dstpath; do
      print $meta | read srcperms dstperms srchash dsthash mode
      objpath=$srcpath
      if [[ -n $dstpath ]]; then
        objpath+=" -> $dstpath"
      fi
      objects+=($tid $dsthash $objpath)
    done
done

print -f 'repo = %s\n' $purl
print -f 'head = %s %s\n' $hhash $hspec
print -f 'base = %s %s\n' $bhash $bspec

if [[ -n $do_stat ]]; then
  print
  git diff-tree --summary $do_stat $hhash --not $mbase
  print
fi

# each commit in the range is represented by a heading:
#   X/Y tree-id commit-id commit-title
# followed by a (possibly empty) series of lines for each file
# affected by this commit:
#     object-id path
# or, if the file is being moved in this commit:
#     object-id srcpath "->" dstpath
for tid cid ignored in $parents; do
  print -f "%*d/%*d %s %s %s\n" -- \
    $seqwidth $((++i)) $seqwidth $nhashes \
    $tid[1,8] $cid[1,8] $cmessages[$tid]
  for _tid oid pth in $objects; do
    [[ $_tid == $tid ]] || continue
    print -f "%*s %s %s\n" $totseqwidth '' $oid[1,8] $pth
  done
done
