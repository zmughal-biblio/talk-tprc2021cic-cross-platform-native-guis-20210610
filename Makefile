all: slides.html

slides.html: slides.md
	pandoc -s --mathml -i -t slidy $< -o $@
