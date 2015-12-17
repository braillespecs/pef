#!/bin/bash

if [ "$TRAVIS_REPO_SLUG" == "braillespecs/pef" ] && [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_BRANCH" == "master" ]; then

  echo -e "Publishing...\n"

  cp -R build/site $HOME

  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "travis-ci"
  git clone --quiet https://${GH_TOKEN}@github.com/braillespecs/braillespecs.github.io  > /dev/null

  cd braillespecs.github.io
  git rm -rf ./pef
  cp -Rf $HOME/site ./pef
  git add -f .
  git commit -m "Travis build of pef ($TRAVIS_BUILD_NUMBER) auto-pushed"
  git push -fq origin master > /dev/null

  echo -e "Published site to braillespecs.github.io/pef.\n"
  
fi
