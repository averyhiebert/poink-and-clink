# Makefile for making web-template and zipping it for distribution etc.
#
# Dependencies:
#  aseprite (must be in path)
#  inklecate (not used YET) (must be in path)


# Make the example project.
example:
	cd example-project && make clean
	cd ..
	cp -r web-template example-project/html
	rm example-project/html/story.js
	cd example-project && make
	cd ..

.PHONY: clean example

docs: example docs-src
	cp -r example-project/html docs-src/media/demo
	mkdocs build

clean:
	# Remove data from web template (I leave story.js 'cause I'm lazy)
	-rm web-template/audio/*
	-rm web-template/images/*
	cd example-project && make clean
	cd ..
	rm -rf example-project/html
	rm -r docs
	rm -r docs-src/media/demo


