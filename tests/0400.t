renamed file
============

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

  $ tit mv README README.txt
  $ tit commit -m 'README is now README.txt'

  $ tit checkout -b rename
  $ tit push rn HEAD:feature

test
****

::

  $ git mantle up/master rn/feature
  repo = git@pub.example.org
  head = 7f78ba9858f68d5acfe6cc7cbf36fb280c7f09c7 rn/feature
  base = 319bf43334fbb706fdbeee1cbfa0d52ec3062930 up/master
  
   .gitignore | 1 +
   README     | 1 -
   README.txt | 1 +
   3 files changed, 2 insertions(+), 1 deletion(-)
   delete mode 100644 README
   create mode 100644 README.txt
  
  1/3 76a23b86 4fafaffe README fancier
      162441d0 README
  2/3 87990615 14f27d4f ignore vim swapfiles
      32682119 .gitignore
  3/3 2c842d2d 7f78ba98 README is now README.txt
      162441d0 README -> README.txt
