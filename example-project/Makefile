ASE := $(wildcard *.ase)
ASE_EXPORT := $(patsubst %.ase,aseprite-export/%.exported,${ASE})

all: html

html: html/images html/audio html/story.js

html/story.js:
	# TODO Inklecate export.
	touch $@

# TODO Correctly detect dependencies for audio
html/audio:
	cp -r audio/* html/audio

html/images: $(ASE_EXPORT)
	cp -r aseprite-export/images/* html/images

# I use ".exported" files as dummy files to correctly track which dependencies have been made
aseprite-export/%.exported: %.ase
	aseprite $^ -b --script-param SKIP_UI --script ../aseprite-script/poink_clink_export.lua
	touch $@

.PHONY: clean all

clean:
	-rm -rf aseprite-export
	-rm -rf html/images/*
	-rm -rf html/audio/*
	-rm aseprite-export/*.exported

