# Makefile to build PDF and Markdown cv from YAML.
#
# Brandon Amos <http://bamos.io> and Ellis Michael <http://ellismichael.com>

BLOG_DIR=$(HOME)/repos/blog

TEMPLATES=$(shell find templates -type f)

BUILD_DIR=build
TEX=$(BUILD_DIR)/cv.tex
PDF=$(BUILD_DIR)/cv.pdf
MD=$(BUILD_DIR)/cv.md
#HTML=$(BUILD_DIR)/cv.html

ifneq ("$(wildcard cv.hidden.yaml)","")
	YAML_FILES = cv.yaml cv.hidden.yaml
else
	YAML_FILES = cv.yaml
endif

.PHONY: all public viewpdf stage jekyll push clean

#all: $(PDF) $(MD) $(HTML)
all: $(PDF) $(MD)
md: $(MD)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

public: $(BUILD_DIR) $(TEMPLATES) $(YAML_FILES) generate.py
	./generate.py -y cv.yaml

$(TEX) $(MD): $(BUILD_DIR) $(TEMPLATES) $(YAML_FILES) generate.py
	./generate.py -y $(YAML_FILES)

$(PDF): $(TEX)
	latexmk -pdf -cd- -jobname=$(BUILD_DIR)/cv $(BUILD_DIR)/cv
	latexmk -c -cd $(BUILD_DIR)/cv

$(HTML): $(PDF)
	pdftohtml -c $(BUILD_DIR)/cv.pdf $(BUILD_DIR)/cv.html

viewpdf: $(PDF)
	gnome-open $(PDF)

stage: $(PDF) $(MD)
	cp $(PDF) $(BLOG_DIR)/data/cv.pdf
	cp $(MD) $(BLOG_DIR)/cv.md
	cp $(HTML) $(BLOG_DIR)/cv.html

jekyll: stage
	cd $(BLOG_DIR) && jekyll server

push: stage
	git -C $(BLOG_DIR) add $(BLOG_DIR)/data/cv.pdf
	git -C $(BLOG_DIR) add $(BLOG_DIR)/cv.md
	git -C $(BLOG_DIR) commit -m "Update cv."
	git -C $(BLOG_DIR) push

clean:
	rm -rf $(BUILD_DIR)/cv*
