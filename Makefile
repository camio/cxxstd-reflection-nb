%.pdf: %.pandoc
	mkdir -p pdf
	pandoc template/header.yaml $< template/footer.pandoc \
       --filter pandoc-citeproc \
       --filter template/diff.py \
       --filter template/tonytable.py \
       --highlight-style kate \
       --number-sections \
       --syntax-definition template/cpp.xml \
       --syntax-definition template/diff.xml \
       --template template/wg21.latex \
       --output pdf/$@

%.md: %.pandoc
	pandoc template/header.yaml $< template/footer.pandoc \
       --filter pandoc-citeproc \
       --filter template/diff.py \
       --filter template/tonytable.py \
       --webtex \
       --to gfm \
       --output github/$@

%.html: %.pandoc
	pandoc template/header.yaml $< template/footer.md \
       --self-contained \
       --filter pandoc-citeproc \
       --filter template/diff.py \
       --filter template/tonytable.py \
       --highlight-style kate \
       --number-sections \
       --syntax-definition template/cpp.xml \
       --syntax-definition template/diff.xml \
       --template template/wg21.html \
       --table-of-contents \
       --output html/$@

.PHONY: clean

clean:
	$(RM) -r pdf
