Implicit `base` and `head`: misconfigured public
================================================

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


test
****

  $ git config mantle.upstream up/master
  $ git config mantle.public lol
  $ git mantle
  fatal: bad revision 'lol/hack'
  [1]
