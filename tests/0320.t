Implicit `base` and `head`: miconfigured upstream
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

  $ git config --local mantle.upstream omg/wtf
  $ git config --local mantle.public rn/\*
  $ git mantle
  fatal: bad revision 'omg/wtf'
  [1]
