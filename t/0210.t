Implicit `base`: wrong configuration
====================================

setup
*****

::

  $ . $TESTDIR/setup

  $ init-repos
  $ cd checkout

  $ touch .gitignore
  $ tit commit -m 'init'

  $ echo fancy > README
  $ tit commit -m 'README'
  $ tit push up HEAD:feature


test
****

::

  $ git config mantle.upstream omg/wtf
  $ git mantle rn/feature
  fatal: bad revision 'omg/wtf'
  [1]
