Fully explicit base and head: base not an ancestor of head
==========================================================

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

  $ tit push up HEAD:next/master
  $ tit push rn HEAD:fix/feature

test
****

::

  $ git mantle rn/fix/feature up/next/master
  fatal: 'rn/fix/feature..up/next/master' is an empty range
  [1]
