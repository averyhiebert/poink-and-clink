# Poink-and-Clink: A point & click framework for Ink.

Poink-and-Clink ("Poink" for short) is a drop-in replacement for the default web export template in Inky, adding support for simple point & click game functionality.  Perfect for *simple* 2D point & click games, especially if you're doing the art in Aseprite (there's an export script!) 

## Documentation

TODO Add link to documentation, once it's set up.

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
