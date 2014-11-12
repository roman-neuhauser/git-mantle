Fully explicit base and head: local refspecs
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

  $ tit checkout -b my/master

  $ touch .gitignore
  $ tit commit -m 'init'

  $ echo fancy > README
  $ tit commit -m 'README'

  $ tit checkout -b random/hack

  $ echo more fancy > README
  $ tit commit -m 'README fancier'

  $ echo '.*.sw?' > .gitignore
  $ tit commit -m 'ignore vim swapfiles'

test
****

::

  $ git mantle ./my/master ./random/hack | headeronly
  repo = ?
  head = 14f27d4fbbce37dd86f710678cd9b63a99f04c0a ./random/hack
  base = 319bf43334fbb706fdbeee1cbfa0d52ec3062930 ./my/master
