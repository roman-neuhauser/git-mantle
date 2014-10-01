merge in range
==============

setup
*****

::

  $ . $TESTDIR/tools.sh

  $ cd checkout
  $ git checkout -q -b add-script master

  $ echo script > script
  $ git add script
  $ git commit -q -m 'added an awesome script'
  $ git checkout -q hack
  $ git merge -q add-script
  $ git push -q rn hack:feature


test
****

  $ git mantle up rn/feature
  fatal: 'up/master..rn/feature' contains a merge
  [1]
