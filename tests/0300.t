Behavior with implicit `base` and `head`
========================================

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout
  $ git checkout -q hack


missing configuration
*********************

::

  $ git config --get mantle.upstream
  [1]
  $ git config --get mantle.public
  [1]
  $ git mantle
  usage: git-mantle [options] [[base] head]
  [1]


wrong configuration
*******************

::

  $ git config --local mantle.upstream omg/wtf
  $ git config --local mantle.public rn/\*
  $ git mantle
  fatal: bad revision 'omg/wtf'
  [1]

  $ git config --local mantle.upstream up/master
  $ git config --local mantle.public lol/\*
  $ git mantle
  fatal: bad revision 'lol/hack'
  [1]


branch not found in public
**************************

::

  $ git config --local mantle.upstream up/master
  $ git config --local mantle.public rn/\*
  $ git push -q rn hack:feature
  $ git mantle
  fatal: bad revision 'rn/hack'
  [1]


happy path
**********

::

  $ git push -q rn hack:hack
  $ git mantle
  repo = git@pub.example.org
  head = ab984c9 rn/hack
  base = 85b915e up/master
  
   .gitignore | 1 +
   README     | 2 +-
   2 files changed, 2 insertions(+), 1 deletion(-)
  
  # 76a23b86 043603cc README fancier
    162441d0 README
  # 87990615 ab984c9b ignore vim swapfiles
    32682119 .gitignore

