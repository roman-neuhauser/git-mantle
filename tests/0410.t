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

  $ echo fancy > README
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
  head = 651e68ca3dceadcf9e816d17b999ce6586c0bcf8 rn/feature
  base = 319bf43334fbb706fdbeee1cbfa0d52ec3062930 up/master
  
   README         | +2 \+- (re)
   doc/.gitignore | +1 \+  (re)
   doc/index.rst  | +1 \+  (re)
   3 files changed, 3 insertions(+), 1 deletion(-)
   create mode 100644 doc/.gitignore
   create mode 100644 doc/index.rst
  
  1/3 76a23b86 4fafaffe README fancier
      162441d0 README
  2/3 99e35674 c14a5e1a ignore generated docs
      2d19fc76 doc/.gitignore
  3/3 078d299b 651e68ca begin docs
      66871fc6 doc/index.rst
