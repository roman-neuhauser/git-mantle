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

  $ print -f '%s\n' fancy whatever > README
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
  head = 07d8642f24d516a62310c057a86cefc6c0c0924c rn/feature
  base = 4d87462ad031a7a165e39033f84b18935bc2d159 up/master
  
   .gitignore | +1 \+ (re)
   README     | +1 \- (re)
   README.txt | +1 \+ (re)
   3 files changed, 2 insertions(+), 2 deletions(-)
   delete mode 100644 README
   create mode 100644 README.txt
  
  1/3 76a23b86 c38f7c05 README fancier
      162441d0 README
  2/3 87990615 b35b1775 ignore vim swapfiles
      32682119 .gitignore
  3/3 2c842d2d 07d8642f README is now README.txt
      162441d0 README -> README.txt
