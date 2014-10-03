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
  $ tit push up HEAD:master

  $ tit checkout -b hack

  $ echo more fancy > README
  $ tit commit -m 'README fancier'

  $ echo '.*.sw?' > .gitignore
  $ tit commit -m 'ignore vim swapfiles'

  $ tit push rn HEAD:feature

test
****

::

  $ git mantle ./master rn/feature | headeronly
  repo = git@pub.example.org
  head = 14f27d4fbbce37dd86f710678cd9b63a99f04c0a rn/feature
  base = 319bf43334fbb706fdbeee1cbfa0d52ec3062930 master
