# Poink-and-Clink: A point & click framework for Ink.

Poink-and-Clink ("Poink" for short) is a drop-in replacement for the default web export template in Inky, adding support for simple point & click game functionality.  Perfect for *simple* first-person 2D point & click games, visual novels, or interactive fiction with occasional point & click elements.

An export script for Aseprite exists, to streamline the development process further.

## Design Philosophy

Poink is constructed around the following design pillars:
 - **Drawing and Writing:** Developing a point & click game should involve drawing art and writing a branching narrative, and *ideally nothing else*.  Spend all your time in a drawing program (I have Aseprite in particular in mind) or in Inky, with as little additional programming/configuring as possible.
 - **Fallback to text:** Poink is supposed to support a development process involving prototyping a game in pure text (i.e. playable in Inky), and then progressively adding graphics, while still maintaining a game that conceivably could be played in text-only format.  Done properly, this should *hopefully* result in games that are screenreader accessible, and that can potentially be ported to another game engine without much additional effort.
 - **Small, quick games:** It should be convenient to create small games quickly using Poink (at least once I get a good project template with build automation set up). Think jam games, webcomic-like games, old-school flash games.  For highly complex and feature-rich games you might want to go somewhere else.


## Limitations

Here are some things you *can't* do easily in Poink:
 - 3rd-person characters walking around in an environment (unless you animate it yourself frame-by-frame).
 - Complex inventory logic, i.e. combining items and "using" arbitrary items on arbitrary objects (unless you write it yourself in Ink).
 - Always-present UI elements, i.e. pause menu or "show inventory" button (unless you write it yourself in HTML/CSS/JS)

But if you don't want any of these features, Poink may be for you! And it should still be relatively simple to modify the JavaScript to add custom functionality, as you could with an Inky web export.

## Documentation

TODO add documentation.


## TODO
Before release:
 - finish lua
    - export coordinates
    - get hovertext from metadata
    - less messy handling of filenames/directory structure
 - scaling the main canvas
 - package CSS with the application
 - basic tutorial

## Roadmap

Things I hope to add eventually:
 - project template (with Makefile for easy build + better Aseprite workflow)
 - tutorials
    - "basic" + aseprite tutorial
    - project template tutorial
 - demo game project
 - Some sort of "fullscreen" option (hopefully achievable with just CSS?)
 - better support for custom JS without editing main.js
 - named image layers, for mild convenience
 - Improved accessibility / screenreader support
    - fix image map to only be used on one image at a time
    - actually test in Orca & resolve any issues identified
 - optional .ink library with helpful additional functionality.
 - better error checking / more informative error messages
    - (minimum: wrap the "tag processing" code in a try/catch and skip problematic lines, with error message in console.)
