.DEFAULT_GOAL := test

bootstrap: configure

ifeq ("$(shell uname -s)","Darwin")
CABALFLAGS=--extra-lib-dirs=/opt/homebrew/Cellar/unac/1.8.0/lib
endif

configure:
	cabal v2-configure --enable-tests $(CABALFLAGS)

build:
	cabal v2-build $(CABALFLAGS)

test: build
	cabal v2-test $(CABALFLAGS)
