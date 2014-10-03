Short base and fully explicit head: happy path
==============================================

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
  $ tit push rn hack:feature


test
****

::

  $ git mantle up rn/feature
  repo = git@pub.example.org
  head = 14f27d4fbbce37dd86f710678cd9b63a99f04c0a rn/feature
  base = 319bf43334fbb706fdbeee1cbfa0d52ec3062930 up/master
  
   .gitignore | 1 +
   README     | 2 +-
   2 files changed, 2 insertions(+), 1 deletion(-)
  
  1/2 76a23b86 4fafaffe README fancier
      162441d0 README
  2/2 87990615 14f27d4f ignore vim swapfiles
      32682119 .gitignore
