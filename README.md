# Poink-and-Clink: A point & click framework for Ink.

Poink-and-Clink ("Poink" for short) is a drop-in replacement for the default web export template in Inky, adding support for simple point & click game functionality.  Perfect for *simple* 2D point & click games, especially if you're doing the art in Aseprite (there's an export script!) 

## Documentation

Check out the [quickstart tutorial](averyhiebert.github.io/poink-and-clink/tutorial) or [read the full documentation here](averyhiebert.github.io/poink-and-clink).

## What's Possible / Demo Game

The quickstart tutorial walks through the steps of creating a small demo game, which can be [played here](averyhiebert.github.io/poink-and-clink/media/demo).

For a more substantial example (around 30 min. playtime), my game [The Restricted Archive](https://averyhiebert.itch.io/the-restricted-archive) was made in an early version of this engine.  I don't really want to release the code, since there are some pretty noticeable differences between the versions and I don't want to cause confusion, but it's still essentially an accurate depiction of what's possible in Poink (albeit lacking screenreader support, and featuring an alternate fullscreen layout).


## Roadmap

Things I hope to add eventually, in approximate order of priority:
 - check whether the Aseprite script even works on Windows?? (fix if necessary)
 - documentation for the Aseprite script
 - fullscreen CSS option
 - template repo to start projects quickly (with Makefile for easy build + better Aseprite export workflow)
 - support for "one-shot" animations
 - saving/loading, maybe?
 - Improved accessibility / screenreader support
    - Nav order after clicking link seems weird in Chrome but not Firefox?
    - TEXTMODE text seems to cause problems in Chrome (but links are fine)
        - only an issue when there is no visible text on screen
        - solution for now: don't rely on TEXTMODE for screenreader support.
 - better error checking / more informative error messages wrt tags
 - better support for custom CSS
 - better support for custom JS without editing main.js
