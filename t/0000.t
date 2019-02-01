Fully explicit base and head: head not found in public
======================================================

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
  $ tit push rn HEAD:feature
  $ tit push up HEAD:master

test
****

::

  $ git mantle up/master rn/fix/feature
  fatal: bad revision 'rn/fix/feature'
  [1]
