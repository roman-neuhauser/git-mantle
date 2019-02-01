Implicit `base`: missing configuration
======================================

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

  $ git config --get mantle.upstream
  [1]
  $ git mantle rn/feature
  fatal: ref refs/remotes/upstream/HEAD is not a symbolic ref
  [1]
