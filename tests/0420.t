repo url displayed w/o password
===============================

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

  $ tit push rn HEAD

test url with username and password
***********************************

::

  $ git config remote.rn.url https://fubar:snafu@pub.example.org

  $ git mantle up/master rn/hack | headeronly
  repo = https://fubar:REDACTED@pub.example.org
  head = c38f7c058b61a21a0ee2fe703a3f00fb8c4b480a rn/hack
  base = 4d87462ad031a7a165e39033f84b18935bc2d159 up/master

test url with username only
***************************

::

  $ git config remote.rn.url https://fubar@pub.example.org

  $ git mantle up/master rn/hack | headeronly
  repo = https://fubar@pub.example.org
  head = c38f7c058b61a21a0ee2fe703a3f00fb8c4b480a rn/hack
  base = 4d87462ad031a7a165e39033f84b18935bc2d159 up/master
