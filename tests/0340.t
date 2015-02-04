Implicit `base` and `head`: happy path
======================================

setup
*****

::

  $ . $TESTDIR/setup

  $ init-repos
  $ cd checkout

  $ touch .gitignore
  $ tit commit -m 'init'

  $ print -f '%s\n' fancy what ever > README
  $ tit commit -m 'README'
  $ tit push up HEAD:master

  $ tit checkout -b hack

  $ echo more fancy > README
  $ tit commit -m 'README fancier'

  $ echo '.*.sw?' > .gitignore
  $ tit commit -m 'ignore vim swapfiles'
  $ tit push rn hack:hack


test
****

::

  $ git config mantle.upstream up/master
  $ git config mantle.public rn

  $ git mantle
  repo = git@pub.example.org
  head = 65e734d2b76d2fd9af8f77d76855b2fb9dc3da18 rn/hack
  base = e62e1b451a9278bbe09118216d7e48bf78d54155 up/master
  
   .gitignore | +1 \+  (re)
   README     | +2 \+- (re)
   2 files changed, 2 insertions(+), 3 deletions(-)
  
  1/2 76a23b86 d05cb8aa README fancier
      162441d0 README
  2/2 87990615 65e734d2 ignore vim swapfiles
      32682119 .gitignore
