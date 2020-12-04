Lambdapi, a proof assistant based on the λΠ-calculus modulo rewriting [![Gitter][gitter-badge]][gitter-link] [![Matrix][matrix-badge]][matrix-link]
=====================================================================

Lambdapi is a proof assistant based on the λΠ-calculus modulo rewriting,
mostly compatible with the proof checker Dedukti. More details are given
in the [documentation](https://lambdapi.readthedocs.io).

Installation via [Opam](http://opam.ocaml.org/)
---------------------

We will only publish a new version of `lambdapi` Opam package when the
development has reached a more stable test. For now, we advise you to
pin the development repository to get the latest bug fixes.

```bash
opam pin add lambdapi https://github.com/Deducteam/lambdapi.git
```
Dependencies and compilation
----------------------------

Lambdapi requires a Unix-like system. It should work on Linux as well as on
MacOS. It might also be possible to make it work on Windows with Cygwin or
with "bash on Windows".

List of dependencies (for version numbers refer to `lambdapi.opam`):
GNU make,
[ocaml](https://ocaml.org/) >= 4.07.0,
[dune](https://dune.build/),
[bindlib](https://github.com/rlepigre/ocaml-bindlib),
[earley](https://github.com/rlepigre/ocaml-earley),
[timed](https://github.com/rlepigre/ocaml-timed),
[menhir](http://gallium.inria.fr/~fpottier/menhir/),
[yojson](https://github.com/ocaml-community/yojson),
[cmdliner](https://erratique.ch/logiciel/cmdliner),
[why3](http://why3.lri.fr/),
[alcotest](https://github.com/mirage/alcotest) (for tests),
[alt-ergo](https://alt-ergo.ocamlpro.com/) (for tests),
[odoc](https://github.com/ocaml/odoc) (for documentation).

**Note on the use of Why3:** the command `why3 config --full-config`
must be run to update the Why3 configuration when a new prover is
installed (including on the first installation of Why3).

Using Opam, a suitable OCaml environment can be setup as follows.
```bash
opam switch 4.11.1
opam install dune bindlib earley timed menhir yojson cmdliner why3 alcotest alt-ergo odoc
why3 config --full-config
```

To compile Lambdapi, just run the command `make` in the source directory.
This produces the `_build/install/default/bin/lambdapi` binary, which can
be run on files with the `.dk` or `.lp` extension (use the `--help` option
for more information).

```bash
make               # Build lambdapi.
make doc           # Build the documentation.
make install       # Install the program.
make install_emacs # Install emacs mode, see note on UI.
make install_vim   # Install vim support, see note UI.
```

**Note:** you can run `lambdapi` without installing with `dune exec -- lambdapi`.

**Note on user interfaces:** more instructions on supported editors can be found
in the [documentation](https://lambdapi.readthedocs.io/en/latest/ui/ui.html).

The following commands can be used for cleaning up the repository:
```bash
make clean     # Removes files generated by OCaml.
make distclean # Same as clean, but also removes library checking files.
make fullclean # Same as distclean, but also removes downloaded libraries.
```

[gitter-badge]: https://badges.gitter.im/Deducteam/lambdapi.svg
[gitter-link]: https://gitter.im/Deducteam/lambdapi
[matrix-badge]: http://strk.kbt.io/tmp/matrix_badge.svg
[matrix-link]: https://riot.im/app/#/room/#lambdapi:matrix.org
