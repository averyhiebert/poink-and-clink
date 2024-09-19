# Dependencies:
#  inklecate must be added to your path (v1.1.1 or earlier)
#  aseprite must be added to your path
ASE := $(wildcard *.ase)
ASE_EXPORT := $(patsubst %.ase,aseprite-export/ink/%.ink,${ASE})

all: html

html: html/images html/audio html/story.js

html/story.js:
	# Compile ink file with inklecate and convert to story.js
	inklecate -o story.json.temp main.ink
	echo "var storyContent = " > html/story.js
	cat story.json.temp >> html/story.js
	echo ";" >> html/story.js
	rm story.json.temp

# Technically not needed as there's no audio for the demo project,
#  just here for demo purposes.
html/audio:
	cp -r audio/* html/audio

html/images: $(ASE_EXPORT)
	cp -r aseprite-export/images/* html/images

# Note: I'm using the exported ink as the target, since the filename of exported images will vary depending on layers etc., but just to be clear, this step builds the exported images as well as the exported ink files.
aseprite-export/ink/%.ink: %.ase
	aseprite $^ -b --script-param SKIP_UI --script ../aseprite-script/poink_clink_export.lua
	touch $@

.PHONY: clean all

clean:
	-rm -rf aseprite-export
	-rm -rf html/images/*
	-rm -rf html/audio/*
	-rm -rf html/story.js
	-rm *.temp
