BASEDIR ?= ${CURDIR}
OUTDIR ?= ${BASEDIR}/out
SRCDIR ?= ${BASEDIR}/src
BUILDDIR ?= ${BASEDIR}/build
TEMPLATEDIR ?= ${BASEDIR}/templates
BINDIR ?= ${BASEDIR}/bin

export PATH := ${BINDIR}:${PATH}

mdfiles := $(shell find "${SRCDIR}" -type f -name "*.md" | sort --version-sort)

# Disables implicit rules, makes for easier debugging
.SUFFIXES:

.PHONY: echo

echo: ${mdfiles}
	echo $^

pdf: tfg.pdf

tfg.pdf: ${mdfiles}
	pandoc \
		--output "${OUTDIR}/tfg.pdf" \
		--template "${TEMPLATEDIR}/template.tex" \
		--pdf-engine xelatex \
		--number-sections \
	#	--variable key:value
		${mdfiles}

install: pandoc pandoc-crossref

pandoc:
ifeq (, $(shell which pandoc))
$(shell curl -L https://github.com/jgm/pandoc/releases/download/3.2/pandoc-3.2-linux-amd64.tar.gz | tar -zx pandoc-3.2/bin && mkdir -p bin && mv pandoc-3.2/bin/pandoc bin/ && rm -rf pandoc-3.2)
endif

pandoc-crossref:
ifeq (, $(shell which pandoc-crossref))
$(shell curl -L https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.16.0a/pandoc-crossref-Linux.tar.xz | tar --xz -x pandoc-crossref && mkdir -p bin && mv pandoc-crossref bin/pandoc-crossref)
endif
