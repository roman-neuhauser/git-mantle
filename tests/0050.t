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

  $ tit branch -M master my/master

  $ tit checkout -b feature

  $ echo more fancy > README
  $ tit commit -m 'README fancier'

  $ echo '.*.sw?' > .gitignore
  $ tit commit -m 'ignore vim swapfiles'

  $ tit push rn HEAD:this/feature

test
****

::

  $ git mantle ./my/master rn/this/feature | headeronly
  repo = git@pub.example.org
  head = 14f27d4fbbce37dd86f710678cd9b63a99f04c0a this/feature
  base = 319bf43334fbb706fdbeee1cbfa0d52ec3062930 ./my/master
