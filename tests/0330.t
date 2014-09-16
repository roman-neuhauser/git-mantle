Implicit `base` and `head`: branch not found in public
======================================================

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout
  $ git config --local mantle.upstream up/master
  $ git config --local mantle.public rn
  $ git checkout -q hack
  $ git push -q rn hack:feature


test
****

::

  $ git mantle
  fatal: bad revision 'rn/hack'
  [1]
