# Poink-and-Clink: A Point & Click Framework for Ink 

Poink-and-Clink ("Poink" for short) is a drop-in replacement for the default web export functionality of [Ink](https://www.inklestudios.com/ink/), adding simple point & click game functionality.  You can find the [github repo here](https://github.com/averyhiebert/poink-and-clink).

The goal is to make it easy to upgrade a "text-adventure"-like Ink story by adding the ability to selectively display layers of an image (including animations) and select choices by clicking on the image; in other words, a minimal set of functionality for writing a point & click adventure in Ink.  And if you do your art in [Aseprite](https://www.aseprite.org/), there's an export script to streamline the workflow further.


## Getting Started

The [quickstart tutorial](tutorial) shows how to convert a simple text-based ink game into [this demo game](media/demo).

## API Reference / list of tags

Most features in Poink are implemented using tags (following the precedent set by the default web export functionality in Inky).  For a list of supported tags, check [the API reference](API).

## Design Philosophy

Poink is constructed around the following design pillars in mind:

 - **Drawing and Writing:** Developing a point & click game should involve *mostly* drawing and writing.  You should be able to spend all your time in a drawing program (particularly Aseprite) or in an interactive-narrative-editor (Inky), with as little external programming/configuration as possible.
 - **Fully playable as text:** Poink is supposed to support prototyping a game in pure text (i.e. playable in Inky) and then progressively adding graphics without removing the full playability of the text content.  Done properly, this should *hopefully* result in games that are screenreader accessible (see section below, though), and that can still be ported to another game engine without much additional effort.
 - **Simple, quick games:** Poink is obviously not as feature-rich as a dedicated engine like Adventure Game Studio. The intended use case is relatively simple games where using a system like that would be overkill. Think jam games, flash-esque games, prototypes, interactive web comics.  For highly complex and feature-rich games you might want to go somewhere else.

## Limitations

Here are some things you *can't* do easily in Poink:

 - 3rd-person characters walking around in an environment (unless you animate it yourself frame-by-frame).
 - Complex inventory logic, i.e. combining items and "using" arbitrary items on arbitrary objects (unless you write it yourself in Ink).
 - Always-present UI elements, i.e. pause menu or "show inventory" button (unless you write it yourself in HTML/CSS/JS)
    - (There are *ok-ish* workarounds for this in Poink, depending on what you're trying to accomplish)

But if you don't want any of these features, Poink may be for you! And it should still be relatively simple to modify the JavaScript to add custom functionality, as you could with an Inky web export.

## A Note on Screenreader Accessibility

I have tried my best to make it so that everything is screenreader accessible, including providing the TEXTMODE tag, which allows text to be presented to screenreader users only.  Unfortunately, when there is no visible text on screen, screenreader navigation in Chrome (and to a lesser extent Firefox) seems to run into some difficulties.  If screenreader support is important to you, avoid relying on the TEXTMODE tag for now and try to convey all relevant information through visible text and hover text.

If someone who knows more about screenreaders is able to help with working out the bugs, that would be greatly appreciated!
