SHELL = /bin/bash

basedir   = build
sourcedir = src

prefix    = $(HOME)/.vim
colorsdir = $(prefix)/colors

plugin   = darkdevel
version ?= $(shell git tag | sort | tail -1 | tr -d "[v\n]")
release ?= $(shell git log v$(version) --format="%ai" | head -1 | tr -d "\n")

scripts = $(basedir)/colors/$(plugin).vim
docs    = $(basedir)/README.mkd \
					$(basedir)/plugin-info.txt
vimball = $(plugin)-$(version).vba

vim 		= vim -ne
vimspec = $(vim) -s --noplugin +'source vimspec.vim' +'quit!'

.PHONY: build

all: build doc

build: $(scripts)

doc: $(docs)

install: build $(colorsdir)
	cp $(scripts) $(subst $(basedir),$(prefix),$(scripts))

uninstall:
	rm -rf $(subst $(basedir),$(prefix),$(scripts))

clean:
	rm -rf $(basedir)/*
	rm -rf $(vimball)*

dist: $(vimball)
	gzip $(vimball)

$(scripts):
	mkdir -p $(@D)
	cp $(sourcedir)/$(notdir $(@D))/$(@F) $(@)
	$(vimspec) $(@)

$(docs):
	cp $(subst $(basedir)/,,$(@)) $(@)
	$(vimspec) $(@)

$(colorsdir):
	mkdir -p $(@)

mkmanifest = for src in $(subst $(basedir)/,,$(^)); do echo $${src} >> manifest; done
mkvimball  = $(vim) manifest +'%MkVimball! $(vimball) .' +'quit!'

$(vimball): $(scripts) $(help)
	cd $(basedir) && rm -f manifest && $(mkmanifest) && $(mkvimball) && mv $(vimball) ..

