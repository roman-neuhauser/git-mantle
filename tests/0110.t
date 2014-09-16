Short base and fully explicit head: base not found in upstream
==============================================================

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout

  $ git config --get mantle.upstream
  [1]
  $ git config --get mantle.public
  [1]
  $ git push -q rn hack:feature
  $ git remote add -t master fu ../upstream
  $ git fetch -q fu


test
****

::

  $ git mantle fu rn/feature
  fatal: ref refs/remotes/fu/HEAD is not a symbolic ref
  [128]
