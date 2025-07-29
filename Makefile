
# generated with CMTools 0.0.3 85e1a08

#
# Simple Makefile for Golang based Projects built under POSIX.
#
PROJECT = doitools

GIT_GROUP = caltechlibrary

#PROGRAMS = <PROGRAM_LISTS_GOES_HERE>

RELEASE_DATE = $(shell date +%Y-%m-%d)

RELEASE_HASH=$(shell git log --pretty=format:'%h' -n 1)

MAN_PAGES_1 = $(shell ls -1 *.1.md | sed -E 's/.1.md/.1/g')

MAN_PAGES_3 = $(shell ls -1 *.3.md | sed -E 's/.3.md/.3/g')

MAN_PAGES_7 = $(shell ls -1 *.7.md | sed -E 's/.7.md/.7/g')

HTML_PAGES = $(shell find . -type f | grep -E '.html$')

DOCS = $(shell ls -1 *.?.md)

PACKAGE = $(shell ls -1 *.go)

VERSION = $(shell grep '"version":' codemeta.json | cut -d\"  -f 4)

BRANCH = $(shell git branch | grep '* ' | cut -d  -f 2)

OS = $(shell uname)

#PREFIX = /usr/local/bin
PREFIX = $(HOME)

ifneq ($(prefix),)
	PREFIX = $(prefix)
endif

EXT =
ifeq ($(OS), Windows)
	EXT = .exe
endif

build: version.go CITATION.cff about.md

version.go: .FORCE
	cmt codemeta.json version.go

hash: .FORCE
	git log --pretty=format:'%h' -n 1

CITATION.cff: codemeta.json
	cmt codemeta.json CITATION.cff

about.md: codemeta.json $(PROGRAMS)
	cmt codemeta.json about.md

test: $(PACKAGE)
	go test

website: clean-website .FORCE
	make -f website.mak

publish: website .FORCE
	./publish.bash

status:
	git status

save:
	@if [ "$(msg)" != "" ]; then git commit -am "$(msg)"; else git commit -am "Quick Save"; fi
	git push origin $(BRANCH)

refresh:
	git fetch origin
	git pull origin $(BRANCH)

#publish: build website .FORCE
#	./publish.bash

clean:
	@if [ -f version.go ]; then rm version.go; fi
	@if [ -d bin ]; then rm -fR bin; fi
	@if [ -d dist ]; then rm -fR dist; fi
	@if [ -d man ]; then rm -fR man; fi
	@if [ -d testout ]; then rm -fR testout; fi

clean-website:
	@for FNAME in $(HTML_PAGES); do if [ -f "$${FNAME}" ]; then rm "$${FNAME}"; fi; done


.FORCE:
