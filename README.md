# Poink-and-Clink: A point & click framework for Ink.

Poink-and-Clink ("Poink" for short) is a drop-in replacement for the default web export template in Inky, adding support for simple point & click game functionality.  Perfect for *simple* 2D point & click games.

An export script for Aseprite exists, to streamline the development process further.

## Design Philosophy

Poink is constructed around the following design pillars:
 - **Drawing and Writing:** Developing a point & click game should involve drawing art and writing a branching narrative, and *ideally nothing else*.  Spend all your time in a drawing program (I have Aseprite in particular in mind) or in Inky, with as little external programming/configuration as possible.
 - **Fully playable as text:** Poink is supposed to support a development process involving prototyping a game in pure text (i.e. playable in Inky), and then progressively adding graphics without removing the full playability of the text content.  Done properly, this should *hopefully* result in games that are screenreader accessible, and that can still be ported to another game engine without much additional effort.  (Also good for game jams: if you start to realize that your graphical ambitions were a bit over-scoped you can still settle for a more text-based but still presentable version of the game.)
 - **Small, quick games:** It should be convenient to create small games quickly using Poink (at least once I get a good project template with build automation set up). Think jam games, old-school flash games, prototypes, interactive web comics.  Think "somewhere in the range between Flickgame and Binksi" (inclusive).   For highly complex and feature-rich games you might want to go somewhere else.


## Limitations

Here are some things you *can't* do easily in Poink:
 - 3rd-person characters walking around in an environment (unless you animate it yourself frame-by-frame).
 - Complex inventory logic, i.e. combining items and "using" arbitrary items on arbitrary objects (unless you write it yourself in Ink).
 - Always-present UI elements, i.e. pause menu or "show inventory" button (unless you write it yourself in HTML/CSS/JS)
    - (There are *ok-ish* workarounds for this in pure Ink, depending on what you're trying to accomplish)

But if you don't want any of these features, Poink may be for you! And it should still be relatively simple to modify the JavaScript to add custom functionality, as you could with an Inky web export.

## Documentation

TODO add documentation.


## TODO
Before release:
 - basic tutorial

## Roadmap

Things I hope to add eventually:
 - project template (with Makefile for easy build + better Aseprite workflow)
 - tutorials
    - "basic" + aseprite tutorial
    - project template tutorial
 - good alternate CSS for "fullscreen"/embeddable layout.
 - better support for custom JS without editing main.js
 - named image layers, for mild convenience
 - Improved accessibility / screenreader support
    - fix image map to only be used on one image at a time
    - actually test in Orca & resolve any issues identified
 - better error checking / more informative error messages
    - (at least wrapping the "tag processing" code in a try/catch and skipping problematic lines, with error message in console.)
 - demo game
