Behavior with short base and fully explicit head
================================================

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout

  $ git config --get mantle.upstream
  [1]

  $ git config --get mantle.public
  [1]


head not found in public
************************

::

  $ git mantle up rn/feature
  fatal: bad revision 'rn/feature'
  [1]


base not found in upstream
**************************

::

  $ git push -q rn hack:feature
  $ git remote add -t master fu ../upstream
  $ git mantle fu rn/feature
  fatal: ref refs/remotes/fu/HEAD is not a symbolic ref
  [128]


happy path
**********

::

  $ git mantle up rn/feature
  repo = git@pub.example.org
  head = ab984c9 rn/feature
  base = 85b915e up/master
  
   .gitignore | 1 +
   README     | 2 +-
   2 files changed, 2 insertions(+), 1 deletion(-)
  
  2/2 76a23b86 043603cc README fancier
      162441d0 README
  1/2 87990615 ab984c9b ignore vim swapfiles
      32682119 .gitignore


