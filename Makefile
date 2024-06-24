BASEDIR ?= ${CURDIR}
OUTDIR ?= ${BASEDIR}/out
SRCDIR ?= ${BASEDIR}/src
BUILDDIR ?= ${BASEDIR}/build
TEMPLATEDIR ?= ${BASEDIR}/templates

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


