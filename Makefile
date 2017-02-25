all: csiu-cv.pdf csiu-resume.pdf csiu-ref.pdf index.html

index.html: css/main.css csiu-cv.tex
	pandoc --from=latex --to=html -c $^ |\
	sed -E 's|\[?[0-9]em\]?||g;' |\
	sed -e ':a' -e 'N' -e '$$!ba' \
		-e 's|<span><br />\n</span>||g; s|<p><span></span></p>\n||g' |\
	sed 's|^<p><span></span> |<p><span id="tab"></span>\&#8627;\&nbsp;|' \
	> $@

%.pdf: %.tex
	pdflatex $< && rm $*.log
