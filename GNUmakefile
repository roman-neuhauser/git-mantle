# vim: ft=make ts=8 sts=2 sw=2 noet

PREFIX ?=         /usr/local
BINDIR ?=         $(PREFIX)/bin
MANDIR ?=         $(PREFIX)/share/man
MAN1DIR ?=        $(MANDIR)/man1

CRAM =            cram
CRAM_OPTIONS =

GZIPCMD ?=        gzip
INSTALL_DATA ?=   install -m 644
INSTALL_DIR ?=    install -m 755 -d
INSTALL_SCRIPT ?= install -m 755
RST2HTML ?=       $(call first_in_path,rst2html.py rst2html)

SHELL =           $(call first_in_path,zsh)
name =            git-mantle

installed =       $(name).1.gz $(name)
artifacts =       $(installed) README.html PKGBUILD $(name).spec

sources =         git-mantle.zsh

version =         $(shell git describe --always --first-parent --long)

.DEFAULT_GOAL :=  most

.PHONY: all
all: $(artifacts)

.PHONY: most
most: $(installed)

.PHONY: clean
clean:
	$(RM) $(artifacts)

.PHONY: check
check: all
	$(CRAM) $(CRAM_OPTIONS) tests

.PHONY: html
html: README.html

.PHONY: install
install: $(installed)
	$(INSTALL_DIR) $(DESTDIR)$(BINDIR)
	$(INSTALL_DIR) $(DESTDIR)$(MAN1DIR)
	$(INSTALL_SCRIPT) $(name) $(DESTDIR)$(BINDIR)/$(name)
	$(INSTALL_DATA) $(name).1.gz $(DESTDIR)$(MAN1DIR)/$(name).1.gz

.PHONY: tarball
tarball: .git
	git archive \
	  --format tar.gz \
	  --prefix $(name)-$(version)/ \
	  --output $(name)-$(version).tar.gz \
	  HEAD
%.gz: %
	$(GZIPCMD) -cn $< | tee $@ >/dev/null

%.html: %.rest
	$(RST2HTML) --strict $< $@

$(name): $(name).zsh
	$(INSTALL_SCRIPT) $< $@

$(name).spec: $(name).spec.in
	version=$(version); pkgver=$${version#v}; \
	sed -e "/^Version:/s/__VERSION__/$$pkgver/" \
	    -e "/^Version:/s/-/./g" \
	    -e "/^%define _upstreamver /s/__VERSION__/$$version/" \
	    $< | tee $@ >/dev/null

PKGBUILD: PKGBUILD.in
	version=$(version); pkgver=$${version#v}; \
	sed -e "/^pkgver=/s/__VERSION__/$$pkgver/" \
	    -e "/^pkgver=/s/-/./g" \
	    -e "/^_upstreamver=/s/__VERSION__/$$version/" \
	    $< | tee $@ >/dev/null

define first_in_path
  $(or \
    $(firstword $(wildcard \
      $(foreach p,$(1),$(addsuffix /$(p),$(subst :, ,$(PATH)))) \
    )) \
  , $(error Need one of: $(1)) \
  )
endef

