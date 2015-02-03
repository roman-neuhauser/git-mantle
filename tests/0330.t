Implicit `base` and `head`: branch not found in public
======================================================

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
  $ tit push up HEAD:master

  $ tit checkout -b hack

  $ echo more fancy > README
  $ tit commit -m 'README fancier'

  $ echo '.*.sw?' > .gitignore
  $ tit commit -m 'ignore vim swapfiles'
  $ tit push rn hack:feature


test
****

::

  $ git config mantle.upstream up/master
  $ git config mantle.public rn

  $ git mantle
  fatal: bad revision 'rn/hack'
  [1]
