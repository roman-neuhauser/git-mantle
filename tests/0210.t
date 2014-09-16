Implicit `base`: wrong configuration
====================================

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout
  $ git push -q rn hack:feature


test
****

::

  $ git config mantle.upstream omg/wtf
  $ git mantle rn/feature
  fatal: bad revision 'omg/wtf'
  [1]
