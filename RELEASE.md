TODO list for a new release on Github
-------------------------------------

- git checkout -b release

- in CHANGES.md, replace Unreleased by the new release number + date + summary of the most important changes

- update AUTHORS.md if needed

- if lambdapi.opam is generated by dune, do make to update it

- opam install dune-release

- repeat (dune-release distrib; fix problems)

- commit and push

- to delete an existing tag: git tag -d $tag; git push --delete origin $tag

- dune-release tag

- dune-release distrib

Using [dune-release](https://github.com/ocamllabs/dune-release)
---------------------------------------------------------------

- create new token public_repo on https://github.com/settings/tokens/new

- update ~/.config/dune/github.token

- dune-release publish distrib

- dune-release opam pkg

- dune-release opam submit

- once published on opam: push release on master

By hand (make lambdapi --version return "Unknown")
--------------------------------------------------

- git push origin $tag

- create new release on Github

- cd ~/src/opam-repository/packages/lambdapi

- git checkout master

- git fetch opam

- git merge opam/master

- git checkout -b $tag

- cp lambdapi-$tag lambdapi-$tag

- git add lambdapi-$tag

- wget https://github.com/Deducteam/lambdapi/archive/refs/tags/$tags.tar.gz

- sha256sum $tag.tar.gz

- sha512sum $tag.tar.gz

- edit lambdapi-$tag/opam

- git add -u

- git commit -m 'release lambdapi-$tag'

- git push -u deducteam $tag

- create pull request on https://github.com/Deducteam/opam-repository