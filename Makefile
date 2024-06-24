BASEDIR ?= ${CURDIR}
OUTDIR ?= ${BASEDIR}/out
SRCDIR ?= ${BASEDIR}/src
TEMPLATEDIR ?= ${BASEDIR}/templates

# SECTIONS_FILE ?= "${SRCDIR}/structure/sections"
# Section order here determines order in the generated doc.
SECTIONS = meta abstract intro state-of-the-art methodology results conclusions sustainability economics appendices bibliography

vpath %.md "${SRCDIR}/md"

pdf: tfg.pdf

tfg.pdf: mdfiles
	pandoc \
		--output "${OUTDIR}/tfg.pdf" \
		--template "${TEMPLATEDIR}/template.tex" \
		--pdf-engine xelatex \
		--number-sections \
	#	--variable key:value
		$(cat mdfiles)

mdfiles: $(SECTIONS)
	cat $< > $@

# sections: $(SECTIONS)
# 	cat $< > $@

$(SECTIONS): $(shell find $@ -type f -name "*.md")
	echo $< > $@


