Fully explicit base and head: head not found in public
======================================================

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout

  $ git config --get mantle.upstream
  [1]
  $ git config --get mantle.public
  [1]


test
****

::

  $ git mantle up/master rn/feature
  fatal: bad revision 'rn/feature'
  [1]
