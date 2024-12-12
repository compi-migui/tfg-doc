TIMESTAMP ?= $(shell date '+%Y-%m-%d-%H%M%S')
BASEDIR ?= ${CURDIR}
OUTDIR ?= ${BASEDIR}/out
SRCDIR ?= ${BASEDIR}/src
MDDIR ?= ${SRCDIR}/md
BUILDDIR ?= ${BASEDIR}/build
TEMPLATEDIR ?= ${SRCDIR}/templates
FIGURESDIR ?= ${SRCDIR}/figures
CITATIONSTYLEFILE ?= ${TEMPLATEDIR}/apa-6th-edition.csl
CITATIONSFILE ?= ${SRCDIR}/citations/zotero.bib

BINDIR ?= ${BASEDIR}/bin

export PATH := ${BINDIR}:${PATH}

mdfiles := $(shell find "${MDDIR}" -type f -name "*.md" | sort --version-sort)

# Disables implicit rules, makes for easier debugging
.SUFFIXES:

.PHONY: echo
pdf: tfg.pdf

echo: ${mdfiles}
	echo $^


tfg.pdf: ${mdfiles} pandoc pandoc-crossref
	mkdir -p ${OUTDIR}
	pandoc \
		--filter pandoc-crossref \
		--bibliography ${CITATIONSFILE} \
		--csl ${CITATIONSTYLEFILE} \
		--citeproc \
		--list-of-figures=false \
		--list-of-tables=false \
		--standalone \
		--pdf-engine xelatex \
		--output "${OUTDIR}/tfg.pdf" \
		--template "${TEMPLATEDIR}/eisvogel.latex" \
		--resource-path "${FIGURESDIR}" \
		--highlight-style "${TEMPLATEDIR}/pygments-with-bg.theme" \
		--number-sections \
		${mdfiles}

debug: ${mdfiles} pandoc pandoc-crossref
	pandoc \
		--filter pandoc-crossref \
		--bibliography ${CITATIONSFILE} \
		--csl ${CITATIONSTYLEFILE} \
		--citeproc \
		--list-of-figures=false \
		--list-of-tables=false \
		--standalone \
		--pdf-engine xelatex \
		-s \
		--output "${OUTDIR}/tfg.tex" \
		--template "${TEMPLATEDIR}/eisvogel.latex" \
		--resource-path "${FIGURESDIR}" \
		--highlight-style "${TEMPLATEDIR}/pygments-with-bg.theme" \
		--number-sections \
		${mdfiles}

draft: pdf
	cp "${OUTDIR}/tfg.pdf" "${OUTDIR}/tfg-draft-${TIMESTAMP}.pdf"
	tar -czf "${OUTDIR}/tfg-draft-archive-${TIMESTAMP}.tar.gz" Makefile "${OUTDIR}/tfg-draft-${TIMESTAMP}.pdf" "${SRCDIR}"


install: pandoc pandoc-crossref

pandoc:
ifeq (, $(shell which pandoc))
$(shell curl -L https://github.com/jgm/pandoc/releases/download/3.5/pandoc-3.5-linux-amd64.tar.gz | tar -zx pandoc-3.5/bin && mkdir -p bin && mv pandoc-3.5/bin/pandoc bin/ && rm -rf pandoc-3.5)
endif

pandoc-crossref:
ifeq (, $(shell which pandoc-crossref))
$(shell curl -L https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.18.0b/pandoc-crossref-Linux-X64.tar.xz | tar --xz -x pandoc-crossref && mkdir -p bin && mv pandoc-crossref bin/pandoc-crossref)
endif
