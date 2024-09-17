# Poink-and-Clink: A point & click framework for Ink.

Poink-and-Clink ("Poink" for short) is a drop-in replacement for the default web export template in Inky, adding support for simple point & click game functionality.  Perfect for *simple* 2D point & click games, especially if you're doing the art in Aseprite (there's an export script!) 

## Documentation

TODO Add link to documentation, once it's set up.

## What's Possible / Demo Game

My game [The Restricted Archive](https://averyhiebert.itch.io/the-restricted-archive) was made in an older, private version of this engine.  I don't really want to release the code, since there are some pretty noticeable differences between the versions and I don't want to cause confusion, but it's still essentially an accurate depiction of what's possible in Poink.

## TODO
Before release:
 - basic tutorial
    - rewrite demo to have "warm yourself -> get out" ending.
    - add smoke to exterior scene where appropriate
 - remove CANVAS_WIDTH tag, make sizing solely depend on CSS

## Roadmap

Things I hope to add eventually, in approximate order of priority:
 - check whether the Aseprite script even works on Windows (edit if necessary)
 - Better CSS, including a fullscreen option
    - (I am not good at CSS, please help)
 - project template (with Makefile for easy build + better Aseprite workflow)
 - more tutorials
    - "basic" + aseprite tutorial
    - project template tutorial
 - better animation support
 - saving/loading, maybe??
 - better support for custom JS without editing main.js
 - Improved accessibility / screenreader support
    - actually test in Orca & resolve any issues identified
 - better error checking / more informative error messages
    - (at least wrapping the "tag processing" code in a try/catch and skipping problematic lines, with error message in console.)
