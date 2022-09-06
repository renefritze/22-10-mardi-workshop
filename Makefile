
static_html/index.html: slides/fritze2022_2210mardiworkshop_slides.md slides/qr_self.png
	npm run html

slides/fritze2022_2210mardiworkshop_slides.pdf: static_html/index.html
	npm run pdf

install:
	npm install

html: static_html/index.html

pdf: slides/fritze2022_2210mardiworkshop_slides.pdf

watch:
	npm run watch

# this way we only re-run install if requirements change
venv/setup_by_make: requirements-dev.txt
	test -d venv || python3 -m venv venv
	. venv/bin/activate && python3 -m pip install -q -r requirements-dev.txt
	touch venv/setup_by_make

venv: venv/setup_by_make

slides/qr_%.png: venv
	. venv/bin/activate && python render_qr.py
	mv -f qr_*png slides/

clean:
	rm -f qr_*png
	mv static_html/edit .
	rm -rf static_html/*
	mv edit static_html/
