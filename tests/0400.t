diffstat-related behaviors
==========================

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
  $ git push -q rn HEAD:feature
  $ git mantle up/master rn/feature
  repo = git@pub.example.org
  head = 2ab371a rn/feature
  base = 85b915e up/master
  
   .gitignore | 1 +
   README     | 1 -
   README.txt | 1 +
   3 files changed, 2 insertions(+), 1 deletion(-)
  
  1/3 76a23b86 043603cc README fancier
      162441d0 README
  2/3 87990615 ab984c9b ignore vim swapfiles
      32682119 .gitignore
  3/3 2c842d2d 2ab371a4 README is now README.txt
