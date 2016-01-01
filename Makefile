BROWSERIFY := browserify
BROWSERIFY_OPTIONS := -t babelify

dist_file := dist/fsm.js

js_src := $(wildcard src/*.js)
all_js := fsm.js $(js_src)
test_js := $(wildcard test/*.js)

.PHONY: lint test

all: lint dist/fsm.js

$(dist_file): fsm.js $(js_src)
	$(BROWSERIFY) $(BROWSERIFY_OPTIONS) fsm.js > $@

lint: eslint.marker
eslint.marker: $(all_js)
	eslint $^
	touch eslint.marker

test: $(all_js) $(test_js)
	xvfb-run karma start my.conf.js --single-run
