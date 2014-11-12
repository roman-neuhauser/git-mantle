Fully explicit base and head: mixed refspecs
============================================

setup
*****

::

  $ . $TESTDIR/setup

  $ init-repos
  $ cd checkout

  $ git config --get mantle.upstream
  [1]
  $ git config --get mantle.public
  [1]

  $ touch .gitignore
  $ tit commit -m 'init'

  $ echo fancy > README
  $ tit commit -m 'README'
  $ tit push up HEAD:my/master

  $ tit checkout -b this/hack

  $ echo more fancy > README
  $ tit commit -m 'README fancier'

  $ echo '.*.sw?' > .gitignore
  $ tit commit -m 'ignore vim swapfiles'

test
****

::

  $ git mantle up/my/master ./this/hack | headeronly
  repo = ?
  head = 14f27d4fbbce37dd86f710678cd9b63a99f04c0a ./this/hack
  base = 319bf43334fbb706fdbeee1cbfa0d52ec3062930 up/my/master
