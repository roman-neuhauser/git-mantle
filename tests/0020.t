Fully explicit base and head: base not an ancestor of head
==========================================================

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout

  $ git config --get mantle.upstream
  [1]
  $ git config --get mantle.public
  [1]

  $ git push -q rn hack:feature


test
****

::

  $ git mantle rn/feature up/master
  fatal: 'rn/feature..up/master' is an empty range
  [1]
