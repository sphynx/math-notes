SOURCES := tuple.md
TARGETS := $(patsubst %.md,%.html,$(SOURCES))

STYLES := tufte.css \
	pandoc.css \
	tufte-extra.css

.PHONY: all
all: $(TARGETS)

## Generalized rule: how to build a .html file from each .md
%.html: %.md tufte.html5 $(STYLES)
	pandoc \
		--katex \
		--section-divs \
		--from markdown+tex_math_dollars \
		--filter pandoc-sidenote \
		--to html5 \
		--template=tufte \
		$(foreach style,$(STYLES),--css $(notdir $(style))) \
		--output $@ \
		$<

.PHONY: clean deploy
clean:
	rm $(TARGETS)

deploy:
	rsync --checksum --progress -ave ssh ./* sphynx@iveselov.info:misc/math-notes
