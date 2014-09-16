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
  usage: git-mantle [options] [[base] head]
  [1]
