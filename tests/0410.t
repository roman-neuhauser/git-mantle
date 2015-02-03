commit details skip (sub)trees
==============================

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

  $ mkdir doc
  $ echo '*.html' > doc/.gitignore
  $ tit commit -m 'ignore generated docs'

  $ echo 'best manual ever' > doc/index.rst
  $ tit commit -m 'begin docs'

  $ tit push rn HEAD:feature

test
****

::

  $ git mantle up/master rn/feature
  repo = git@pub.example.org
  head = 3d61c88a55666fe8c20b32e3f2fce6d64581667a feature
  base = 4d87462ad031a7a165e39033f84b18935bc2d159 up/master
  
   README         | +2 \+- (re)
   doc/.gitignore | +1 \+  (re)
   doc/index.rst  | +1 \+  (re)
   3 files changed, 3 insertions(+), 2 deletions(-)
   create mode 100644 doc/.gitignore
   create mode 100644 doc/index.rst
  
  1/3 76a23b86 c38f7c05 README fancier
      162441d0 README
  2/3 99e35674 ea64e7c4 ignore generated docs
      2d19fc76 doc/.gitignore
  3/3 078d299b 3d61c88a begin docs
      66871fc6 doc/index.rst
