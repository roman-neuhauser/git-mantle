Fully explicit base and head: mixed refspecs
============================================

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

  $ git mantle up/master ./hack | headeronly
  repo = ?
  head = ab984c9b99ffc420ceea6a8491f952275698d294 hack
  base = 85b915e100b621d1ec7783b6a9b8dc6b09233614 up/master
