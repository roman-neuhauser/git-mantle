Fully explicit base and head: base not found in upstream
========================================================

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

  $ git mantle up/fubar rn/feature
  fatal: bad revision 'up/fubar'
  [1]
