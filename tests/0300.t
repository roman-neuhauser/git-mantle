Implicit `base` and `head`: missing configuration
=================================================

setup
*****

::

  $ . $TESTDIR/setup

  $ init-repos
  $ cd checkout


test
****

::

  $ git config --get mantle.upstream
  [1]
  $ git config --get mantle.public
  [1]
  $ git mantle
  fatal: ref refs/remotes/upstream/HEAD is not a symbolic ref
  [1]
