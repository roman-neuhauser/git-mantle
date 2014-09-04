export GIT_PAGER=cat
export GIT_EDITOR=false
export GIT_SSH=false
export GIT_ASKPASS=false
export GIT_CONFIG_NOSYSTEM=1
export HOME="$PWD"
export XDG_CONFIG_HOME="$PWD"
export PATH="${TESTDIR%/*}:$PATH"

(

  set -eu

  git config --global user.email "git-mantle-tests@example.org"
  git config --global user.name  "git-mantle test suite"

  if [ x${MANTLE_REBUILD_FIXTURE+set} = xset ]; then
    git init -q upseed
    cd upseed

    touch .gitignore
    git add .gitignore
    git commit -q -m init
    echo fancy > README
    git add README
    git commit -q -m README
    git bundle create $TESTDIR/seed.bundle master
    cd ..

    git init -q coseed
    cd coseed
    git fetch -q -u $TESTDIR/seed.bundle master:master

    git checkout -q -b hack
    echo more fancy > README
    git add README
    git commit -q -m 'README fancier'

    echo '.*.sw?' >> .gitignore
    git add .gitignore
    git commit -q -m 'ignore vim swapfiles'

    git checkout -q -b rename
    git mv README README.txt
    git commit -q -m 'README is now README.txt'

    git bundle create $TESTDIR/checkout.bundle master hack rename
    cd ..
    rm -rf coseed
  fi

  git init -q --bare upstream
  cd upstream
  git fetch -q -u $TESTDIR/seed.bundle master:master
  cd ..

  git clone -q --bare upstream public

  git clone -q public checkout
  cd checkout
  git remote add -m master -t master up ../upstream
  git fetch -q up
  git fetch -q -u $TESTDIR/checkout.bundle master:master hack:hack rename:rename

  git remote rename origin rn
  git remote set-url rn git@pub.example.org
  git remote set-url --push rn ../public

) || {
  printf "$0 setup failed, aborting." >&2
  exit 11
}

