renamed file
============

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout

  $ git config --get mantle.upstream
  [1]
  $ git config --get mantle.public
  [1]

  $ git checkout -q rename
  $ git push -q rn HEAD:feature

test
****

::

  $ git mantle up/master rn/feature
  repo = git@pub.example.org
  head = 2ab371a4204e15ee16a75e9ae81cfc82a5714c07 rn/feature
  base = 85b915e100b621d1ec7783b6a9b8dc6b09233614 up/master
  
   .gitignore | 1 +
   README     | 1 -
   README.txt | 1 +
   3 files changed, 2 insertions(+), 1 deletion(-)
   delete mode 100644 README
   create mode 100644 README.txt
  
  1/3 76a23b86 043603cc README fancier
      162441d0 README
  2/3 87990615 ab984c9b ignore vim swapfiles
      32682119 .gitignore
  3/3 2c842d2d 2ab371a4 README is now README.txt
      162441d0 README -> README.txt
