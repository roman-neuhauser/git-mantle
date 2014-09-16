Implicit `base` and `head`: misconfigured public
================================================

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout
  $ git checkout -q hack


test
****

  $ git config --local mantle.upstream up/master
  $ git config --local mantle.public lol
  $ git mantle
  fatal: bad revision 'lol/hack'
  [1]
