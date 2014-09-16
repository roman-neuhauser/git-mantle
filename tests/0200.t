Implicit `base`: missing configuration
======================================

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout
  $ git push -q rn hack:feature


test
****

::

  $ git config --get mantle.upstream
  [1]
  $ git mantle rn/feature
  fatal: ref refs/remotes/upstream/HEAD is not a symbolic ref
  [1]
