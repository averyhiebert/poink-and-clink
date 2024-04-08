# Dependencies:
#  inklecate must be added to your path (v1.1.1 or earlier)
#  aseprite must be added to your path
ASE := $(wildcard *.ase)
ASE_EXPORT := $(patsubst %.ase,aseprite-export/%.exported,${ASE})

all: html

html: html/images html/audio html/story.js

html/story.js:
	inklecate -o story.json.temp main.ink
	echo "var storyContent = " > html/story.js
	cat story.json.temp >> html/story.js
	echo ";" >> html/story.js
	rm story.json.temp

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
	-rm -rf html/story.js
	-rm aseprite-export/*.exported
	-rm *.temp

