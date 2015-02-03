Implicit `base` and `head`: miconfigured upstream
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

  $ git config mantle.upstream omg/wtf
  $ git mantle
  fatal: bad revision 'omg/wtf'
  [1]
