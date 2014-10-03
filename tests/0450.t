merge in range
==============

setup
*****

::

  $ . $TESTDIR/setup

  $ init-repos
  $ cd checkout

  $ touch .gitignore
  $ tit commit -m 'init'
  $ tit push up HEAD:master

  $ echo fancy > README
  $ tit commit -m 'README'
  $ tit push rn HEAD:master

  $ tit checkout -b add-script HEAD~1

  $ echo script > script
  $ tit commit -m 'script'

  $ tit checkout master
  $ tit merge add-script
  $ tit push rn HEAD:feature


test
****

  $ git mantle up rn/feature
  fatal: 'up/master..rn/feature' contains a merge
  [1]
