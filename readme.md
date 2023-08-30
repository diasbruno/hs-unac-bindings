#  haskell bindings for unac(3) _[hackage](https://hackage.haskell.org/package/unac-bindings)_

![tests](https://github.com/diasbruno/hs-unac-bindings/actions/workflows/haskell.yml/badge.svg)


this package doesn't bind (yet) all functionalities
of unac(3), but the most used one `unac_string`.

## usage

```hs
unacString utf8Encode "été" == unacStringUtf8 "été" == Right "ete"
```

if you get `Left (x :: Int)`, this means that an error happened.
to further investigate the error, you will need to handle by yourself (for now)
using `errno` and do the appropriate handling.

## license

Unlicense

see [LICENSE](https://github.com/diasbruno/hs-unac-bindings/blob/master/LICENSE)
