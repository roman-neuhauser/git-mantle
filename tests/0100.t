Short base and fully explicit head: head not found in public
============================================================

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
  $ tit push up HEAD:master


test
****

::

  $ git mantle up rn/feature
  fatal: bad revision 'rn/feature'
  [1]
