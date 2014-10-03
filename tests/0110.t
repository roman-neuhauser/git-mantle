Short base and fully explicit head: base not found in upstream
==============================================================

setup
*****

::

  $ . $TESTDIR/setup

  $ init-repos
  $ cd checkout

  $ git config --get mantle.upstream
  [1]
  $ git config --get mantle.public
  [1]

  $ touch .gitignore
  $ tit commit -m 'init'

  $ echo fancy > README
  $ tit commit -m 'README'
  $ tit push rn HEAD:feature


test
****

::

  $ git mantle fu rn/feature
  fatal: ref refs/remotes/fu/HEAD is not a symbolic ref
  [1]
