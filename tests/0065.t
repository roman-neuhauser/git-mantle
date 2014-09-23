Fully explicit base and head: <rev>^<n>, <rev>~<n>
==================================================

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

  $ git checkout -q rename
  $ # git log --oneline
  $ # git describe HEAD~2
  $ git mantle ./HEAD~2 ./HEAD | headeronly
  repo = ?
  head = 2ab371a4204e15ee16a75e9ae81cfc82a5714c07 rename
  base = 043603cc3cbecceaf0b350e40efc48f4c026b7cc HEAD~2

