# Poink-and-Clink API


## Clickable choices

A "clickable" choice can be created as follows:

```
 * [0,0,100,100 kitchen door]
    -> some_knot
```

This creates a rectangular clickable area from 0,0 to 100,100 with the alt text and hover text "kitchen door."

The alt/hover text is optional, but I might change my mind about that (alt text is important for accessibility).

Note: no spaces between coordinates, at least one space before the hover text.

## Showing/hiding images

Images are shown/hidden using tags, more-or-less following conventions established by Inky web export.  All of the standard web image formats are supported (png, jpeg, gif).

```
# SCENE: image.png
```
Set the current contents of the screen to the specified image.  Completely replaces any images that may have been displayed previously.

Useful to call once when changing to a new scene.

```
# IM_SHOW: image.png
```
Adds the specified image into the scene *on top* of any existing images.

```
# IM_HIDE: image.png
```
Removes the specified image from the scene.

```
# IM_REPLACE: image1.png image2.png
```
Replaces image1 with image2, preserving order of all images.
If image1 does not already exist, image2 is simply added to the scene.

```
# IM_PREFIX: images/
```
Set a prefix to be added automatically to all image filename arguments.
Useful for grouping images by scene.
TODO: Implement this!


## Other tags

The following tags are supported as in Inky default export:

```
# CLEAR
# RESTART
# CLASS: classname
# AUDIO: file.mp3 // TODO Implement
```

The `AUDIOLOOP` tag is available, but functions slightly differently from Inky, in that calling AUDIOLOOP with the name of a file that is already playing will not restart the loop.
```
# AUDIOLOOP: file.mp3 // TODO Implement
```

For accessibility and text-based prototyping in Inky, you can use the `TEXTMODE` tag for text that will not be displayed to the player in the final export (but will remain accessible to screenreaders).
```
Textual description of image # TEXTMODE
```


## Global configuration options

Some global settings can be configured using global tags (tags at the top of the ink file)

```
# TITLE: Your Title Here
```
Sets the title of the web page.

```
# CLEAR_AFTER_CHOICES: false
```
If set to true, the text will be cleared every time a choice is picked.

```
# REPLACE_UNDERSCORES: false
```
If set to true, all underscores in text produced by the Ink story will be replaced with spaces (useful if you want to be lazy and reuse variable names as display text.  I would normally not encourage this, but Ink in particular makes it annoying to set display text for some things, so I allow it.)

```
# SKIP_CHOICE_TEXT: false
```
If set to true, the first line of text after a choice is made will be skipped.  This basically lets you leave out the `[ ]`, *if* you're certain that you would be using it all the time anyways (likely useful for certain styles of adventure game).


