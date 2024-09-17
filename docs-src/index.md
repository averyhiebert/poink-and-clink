# Poink-and-Clink: A Point & Click Framework for Ink 

Poink-and-Clink ("Poink" for short) is a drop-in replacement for the default web export functionality of [Ink](https://www.inklestudios.com/ink/), adding simple point & click game functionality.

The goal is to make it easy to upgrade a "text-adventure"-like Ink story by adding the ability to selectively display layers of an image (including animations) and select choices by clicking on the image; in other words, a minimal set of functionality for writing a point & click adventure in Ink.  And if you do your art in [Aseprite](https://www.aseprite.org/), there's an export script to streamline the workflow further.


## Getting Started

TODO Link to quickstart tutorial

## API Reference / list of tags

Most features in Poink are implemented using tags (following the precedent set by the default web export functionality in Inky).  For a list of supported tags, check HERE (TODO LINK).

## Design Philosophy

Poink is constructed around the following design pillars:

 - **Drawing and Writing:** Developing a point & click game should involve *mostly* drawing and writing.  You should be able to spend all your time in a drawing program (particularly Aseprite) or in an interactive-narrative-editor (Inky), with as little external programming/configuration as possible.
 - **Fully playable as text:** Poink is supposed to support prototyping a game in pure text (i.e. playable in Inky) and then progressively adding graphics without removing the full playability of the text content.  Done properly, this should *hopefully* result in games that are screenreader accessible (see section below, though), and that can still be ported to another game engine without much additional effort.
 - **Small, quick games:** It should be convenient to create *small* games quickly using Poink. Think jam games, old-school flash games, prototypes, interactive web comics.  For highly complex and feature-rich games you might want to go somewhere else.
 - **Extensibility:** As with conventional Inky web exports, you still have full control over the styling of the interface (via CSS) and the ability to add custom functionality by modifying the relatively-simple JavaScript code. (At some point in the future I would like to rework the JS with a proper API so that you can add variable observers, external functions, and custom line display without even touching `main.js`)

## Limitations

Here are some things you *can't* do easily in Poink:

 - 3rd-person characters walking around in an environment (unless you animate it yourself frame-by-frame).
 - Complex inventory logic, i.e. combining items and "using" arbitrary items on arbitrary objects (unless you write it yourself in Ink).
 - Always-present UI elements, i.e. pause menu or "show inventory" button (unless you write it yourself in HTML/CSS/JS)
    - (There are *ok-ish* workarounds for this in Poink, depending on what you're trying to accomplish)

But if you don't want any of these features, Poink may be for you! And it should still be relatively simple to modify the JavaScript to add custom functionality, as you could with an Inky web export.

## A Note on Screenreader Accessibility

I have tried my best to make it so that everything is screenreader accessible if you use the TEXTMODE tag.  Unfortunately, when there is no visible text onscreen, screenreader navigation in Chrome (and to a lesser extent Firefox) seems to run into some difficulties.  If screenreader support is important to you, avoid having moments when there is *no* text on screen.
