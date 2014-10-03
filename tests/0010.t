Fully explicit base and head: base not found in upstream
========================================================

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

  $ echo foo > foo
  $ tit commit -m 'added foo'
  $ tit push up HEAD:master

  $ echo bar > bar
  $ tit commit -m 'added bar'
  $ tit push rn HEAD:feature

test
****

::

  $ git mantle up/fubar rn/feature
  fatal: bad revision 'up/fubar'
  [1]
