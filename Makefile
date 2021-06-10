## Config global
LATEXMK = latexmk $(LATEXMKRC_FLAGS) -f -pdf -silent -diagnostics
XELATEX_OPT := -e '$$pdflatex=q/xelatex -synctex=1 %O %S/'

## Config project

MINIMAL_TARGETS := slides.pdf
SLIDES_EXTRA_TARGETS := slides-notes.pdf

SLIDES_DEP := slides-content.tex preamble/common.tex preamble/meta.tex

ALL_TARGETS := $(MINIMAL_TARGETS) $(SLIDES_EXTRA_TARGETS)

all:  $(ALL_TARGETS) tags

slides-notes.pdf: LATEXMKRC_FLAGS += -jobname=slides-notes $(XELATEX_OPT)
slides-notes.pdf: slides-notes.tex $(SLIDES_DEP)

#slides-handout.pdf: LATEXMKRC_FLAGS += -jobname=slides-handout $(XELATEX_OPT)
#slides-handout.pdf: slides-handout.tex $(SLIDES_DEP)

slides.pdf: LATEXMKRC_FLAGS +=  $(XELATEX_OPT)
slides.pdf: slides.tex $(SLIDES_DEP)

slides-handout-2x3.pdf: slides-handout.pdf
	pdfjam-slides6up --suffix '2x3' --batch $<


cleanall::
	rm -Rf $(ALL_TARGETS)

%.pdf: %.tex
	-$(LATEXMK) $<

tags:
	ctags -R .

include ~/sw_projects/zmughal/scraps/scraps/build/latex/clean.mk
