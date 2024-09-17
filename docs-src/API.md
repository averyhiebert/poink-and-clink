# API Reference 

## Clickable choices

A "clickable" choice can be created as follows:

```
 * [50,50,100,100 kitchen door]
    -> some_knot
```

This creates a rectangular clickable area whose top-left corner is at 50,50 and whose bottom-right corner is at 100,100 (in pixel coordinates), with the alt text and hover text "kitchen door."

In a small abuse of notation, a "click anywhere" option can be added as follows:
```
 * [,,, Click to continue...]
    -> some_knot
```

<details>
<summary>Additional details</summary>
<p>The alt/hover text is optional, but you really should include it (for code readability and for screenreader accessibility).</p>

<p>There should be <strong>no spaces</strong> between coordinates, and at least one space before the hover text.  </p>

<p>The origin (0,0) corresponds to the top left of the image, and the <em>y</em> axis increases in the downwards direction.  This should match with how pixel coordinates are displayed in most image editing software.</p>

<p>When two clickable areas overlap, the one that was added *first* takes precedence.</p>
</details>

----------


## SCENE
```
# SCENE: image.png
```
Set the current contents of the canvas to the specified image.  Completely replaces any images that may have been displayed previously.

Useful to call once when changing to a new scene.

## IM\_SHOW

```
# IM_SHOW: image.png
```
Adds the specified image into the scene *on top* of any existing images.

## IM\_HIDE

```
# IM_HIDE: image.png
```
Removes the specified image from the scene.

## IM\_REPLACE

```
# IM_REPLACE: image1.png image2.png
```
Replaces image1 with image2, preserving order of all images.
If image1 does not already exist, image2 is simply added to the scene.

## IM\_PREFIX

```
# IM_PREFIX: images/
```
Set a prefix to be added automatically to all image filename arguments.
Useful for grouping images by scene.

## TEXTMODE
```
Textual description of image # TEXTMODE
```
For accessibility and text-based prototyping in Inky, you can use the `TEXTMODE` tag for text that will not be displayed to the player in the final export (but will remain accessible to screenreaders).

## Default Inky Tags

The following tags are supported as in Inky default export:

```
# CLEAR
# RESTART
# CLASS: classname
# TITLE: My Cool Game
# AUDIO: file.mp3
# AUDIOLOOP: file.mp3
```

`AUDIOLOOP` functions slightly differently from Inky: specifying the name of a file that is already playing will not restart the loop.



## Global Configuration 

Some global settings can be configured using global tags (tags at the top of the ink file)

### CANVAS\_SHAPE
This setting is **MANDATORY**.

```
# CANVAS_SHAPE: 200 200
```
Informs the canvas what size the images are going to be (in pixels).  If you don't set this correctly then the playing area will not display correctly.

### CLEAR\_AFTER\_CHOICES
```
# CLEAR_AFTER_CHOICES: true
```
If set to true, the text will be cleared every time a choice is picked. True by default, as this makes sense for point & click-type games in most cases, although you may sometimes prefer traditional ink behaviour.

### REPLACE\_UNDERSCORES
```
# REPLACE_UNDERSCORES: false
```
If set to true, all underscores in text produced by the Ink story will be replaced with spaces (useful if you want to be lazy and reuse variable names as display text.  I would normally not encourage this, but Ink in particular makes it annoying to set display text for some things, so I allow it.)

### SKIP\_CHOICE\_TEXT
```
# SKIP_CHOICE_TEXT: false
```
If set to true, the first line of text after a choice is made will be skipped.  This basically lets you leave out the `[ ]`, *if* you're certain that you would be using it all the time anyways (might save a small number of keystrokes, but to be honest it's probably not worth it).

