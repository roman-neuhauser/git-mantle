Implicit `base` and `head`: missing configuration
=================================================

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout
  $ git checkout -q hack


test
****

::

  $ git config --get mantle.upstream
  [1]
  $ git config --get mantle.public
  [1]
  $ git mantle
  usage: git-mantle [options] [[base] head]
  [1]
