Fully explicit base and head: happy path
========================================

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

  $ echo more fancy > README
  $ tit commit -m 'README fancier'

  $ echo '.*.sw?' > .gitignore
  $ tit commit -m 'ignore vim swapfiles'

  $ tit push rn HEAD:fix/feature

test
****

::

  $ git mantle up/master rn/fix/feature
  repo = git@pub.example.org
  head = b35b17756cd46fbc48977114dc0110d6fe36c740 rn/fix/feature
  base = 4d87462ad031a7a165e39033f84b18935bc2d159 up/master
  
   .gitignore | +1 \+  (re)
   README     | +2 \+- (re)
   2 files changed, 2 insertions(+), 2 deletions(-)
  
  1/2 76a23b86 c38f7c05 README fancier
      162441d0 README
  2/2 87990615 b35b1775 ignore vim swapfiles
      32682119 .gitignore

