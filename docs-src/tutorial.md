# Quickstart Tutorial

In this tutorial I'll show how to take a simple ink story and "upgrade" it to a point & click game.  This tutorial assumes familiarity with Ink and Inky.

## Starting with a text game

Consider the following simple ink game:

<details>
<summary>main.ink</summary>
<code class="hljs shell">
# TITLE: Simple Ink Game

VAR fire_lit = false
VAR got_firewood = false
VAR player_is_cold = true

-> exterior

// A little helper tunnel, to give the player an opportunity to read text before it gets cleared
=== OK ===
+ [Ok]
    ->->

=== exterior ===
# CLEAR
You are stranded deep in the heart of a remote forest.
+ [dark forest]
    Towering pines obscure the night sky.
    {player_is_cold:
        You know the way home, but the trek will take hours and you are currently extremely cold and damp, on the verge of hypothermia.
        + [Attempt to walk home]
            You die of hypothermia before you make it home. You are then eaten by a Grue.
            GAME OVER.
            ++ [Try again?]
                # RESTART
                -> DONE
        + [Stay here for now] -> exterior
    -else:
        You know the way home, and now that you are warm and dry you believe you can make it home safely.
        + [Walk home]
            After many hours hiking through the forest you finally return to civilization.
            CONGRATULATIONS!
            ++ [Play again?]
                # RESTART
                -> DONE
    }
+ {not got_firewood}[pile of firewood]
    You find some firewood lying near the cabin.
    ~got_firewood = true
    -> OK -> exterior
+ [log cabin]
    There is an abandoned log cabin nearby.
    ++ [Enter the cabin]
        -> interior
    ++ [Back]
        -> exterior


=== interior ===
# CLEAR
You {|once again }find yourself inside {a|the} small cabin.{  It seems like it hasn't been inhabited in quite some time.|}
{fire_lit:
    A fire crackles in the fireplace.
- else:
    The fireplace is cold and dark.
}
+ [fireplace]
  {not fire_lit:
    The fireplace is unlit.
    {got_firewood:
        Would you like to light it?
        + [Yes]
            ~fire_lit = true
            -> interior
        + [No]
            -> interior
    - else:
        You could light it if you had some firewood.
        -> OK -> interior
    }
  - else:
    The fire warms your aching bones and dries your damp clothes.
    ~player_is_cold = false
    -> OK -> interior
  }
+ [window]
    It looks cold out there.
    -> OK -> interior
+ [door]
    -> exterior
</code>
</details>

<br>

This is a perfectly functional (if somewhat boring) text adventure game.  The player is able to navigate between two scenes (interior and exterior), get some firewood, light a fire, warm themselves by the fire, and then walk home.

We'll be adding graphics in a moment. For now, though, we can build the text-only version using the Poink template, in essentially the same way that you would export the story normally in Inky.

1. Download the Poink `web-template` directory.
2. Open Inky and copy-paste in the contents of `main.ink`
3. Select `File > Export story.js only...` and overwrite the story.js currently present in the web template.

That's it! If you view `index.html` in a browser you should be able to play the game.

## Adding background graphics

Now it's time to start adding graphics. We'll be using the following five images:

<details>
<summary>Images to be used</summary>
forest.background.gif:<br>
<img src="../media/forest.background.gif" alt="A log cabin in a forest"/><br>
forest.smoke.smoking.gif:<br>
<img src="../media/forest.smoke.smoking.gif" alt="Animation of smoke rising"/><br>
forest.woodpile.gif:<br>
<img src="../media/forest.woodpile.gif" alt="A small woodpile"/><br>
interior.background.gif:<br>
<img src="../media/interior.background.gif" alt="The interior of a log cabin (with door, window, and fireplace)"/><br>
interior.fireplace.burning.gif:<br>
<img src="../media/interior.fireplace.burning.gif" alt="Animation of a wood fire burning"/>
</details>
<br>

Save these images into a folder called `images`, and put the `images` folder inside of the `web-template` folder.

Two of the images are opaque backgrounds, and the other three are mostly-transparent sprites meant to be layered on top of one of the backgrounds and selectively shown or hidden depending on the world state.

Note that all the images have the same dimensions (96 by 64 pixels) - this is mandatory, and it's a requirement that simplifies the display logic a lot, without impacting expressivity too much, in my opinion.

To start with, we have to add some tags at the top of the ink file:
```
# TITLE: Simple Poink Game
# CANVAS_SHAPE: 96 64
# IM_PREFIX: images/
```

The `CANVAS_SHAPE` tag tells Poink the dimensions of the images we're using, and is mandatory if you want to use the graphical features (which is the entire point of Poink).

`IM_PREFIX` is just a handy shortcut that'll add `images/` to the start of all our image filenames, to save some time typing.

Now, we'll add a background image to each of the scenes.  At the top of each knot, simply add a `SCENE` tag, like so:

```
=== exterior ===
# CLEAR
# SCENE: forest.background.gif

...

=== interior ===
# CLEAR
# SCENE: interior.background.gif
```

If you re-export `story.js` now and view `index.html` again, you should now see background graphics for each knot.

## Adding sprites / layers

Now let's make the graphics to change in response to the world state. Specifically, we'll show the woodpile sprite, but only if the player hasn't yet taken the wood, and we'll also show smoke rising from the cabin chimney if the fire is lit.

```
=== exterior ===
# CLEAR
# SCENE: forest.background.gif
{not got_firewood:
    # IM_SHOW: forest.woodpile.gif
}
{fire_lit:
    # IM_SHOW: forest.smoke.smoking.gif
}
You are stranded deep in the heart of a remote forest.
```

This is just using normal Ink if-statements to add an `IM_SHOW` tag when the appropriate conditions are met.  As you might expect, `IM_SHOW` simply shows an image, on top of any existing images already in the scene.  (In contrast, the `SCENE` tag we saw already will replace *all* existing images, like you would typically want to do when moving to a new scene).

Similarly, presumably we want to show the fire burning in the interior scene:
```
=== interior ===
# CLEAR
# SCENE: interior.background.gif
You {|once again }find yourself inside {a|the} small cabin.{  It seems like it hasn't been inhabited in quite some time.|}
{fire_lit:
    # IM_SHOW: interior.fireplace.burning.gif
    A fire crackles in the fireplace.
- else:
    The fireplace is cold and dark.
}
```

If you export the project again now, you should find that the graphics all respond appropriately to changes in the world state.

## Adding click functionality

So far we have an illustrated text adventure, but still no pointing or clicking. Let's fix that.

We can convert a text link into a clickable area of the image by adding coordinates defining a rectangle to the choice text, as follows:

```text
You are stranded deep in the heart of a remote forest.
+ [0,1,56,48 dark forest]
    ...
+ {not got_firewood}[57,42,69,48 pile of firewood]
    ...
+ [73,9,96,48 log cabin]

...

+ [73,28,96,48 fireplace]
    ...
+ [31,9,61,32 window]
    ...
+ [2,9,27,48 door]
    ...
```

The text after the coordinates will appear as hover text when the user hovers over the corresponding area of the image, and clicking on that area will select that choice.

If you build the template now, you should find that we have a basically fully-functional point & click game.

Coordinates are of the form (top-left x, top-left y, bottom-right x, bottom-right y).  Now, it may seem annoying to look up these coordinates manually, and it is; fortunately, if you use Aseprite then there's a script to do this automatically. Documentation for the Aseprite script should be available soon.

## Hiding text

Our game has graphics now, but it still has textual room descriptions ("You find yourself in the cabin," etc), which is unusual for a point & click game.  We could, of course, delete those descriptions and let the images (and clickable scenery descriptions) do the talking, but this would make prototyping/testing in Inky less pleasant, not to mention hiding important information from screenreader users.

Instead, you can just add the `TEXTMODE` tag to any lines that you don't want to appear when playing the game, like so:

```
You {|once again }find yourself inside {a|the} small cabin.{  It seems like it hasn't been inhabited in quite some time.|} # TEXTMODE
{fire_lit:
    # IM_SHOW: interior.fireplace.burning.gif
    A fire crackles in the fireplace. # TEXTMODE
- else:
    The fireplace is cold and dark. # TEXTMODE
}
```

We could do the same for the description of the exterior scene, althoug that one actually provides important context (the fact that you're stranded), so we'll conditionally add the tag only after the line has already been shown once:

```
You are stranded deep in the heart of a remote forest. #{|TEXTMODE}
```

That's everything! We now have a finished point & click game.  The final result should match [the playable demo here](../media/demo).

After all the changes we've made, the `main.ink` code should look like this:

```text
# TITLE: Simple Poink Game
# IM_PREFIX: images/
# CANVAS_SHAPE: 96 64

VAR fire_lit = false
VAR got_firewood = false
VAR player_is_cold = true

-> exterior

// A little helper tunnel, to give the player an opportunity to read text before it gets cleared
=== OK ===
+ [Ok]
    ->->

=== exterior ===
# CLEAR
# SCENE: forest.background.gif
# {not got_firewood: IM_SHOW: forest.woodpile.gif }
# {fire_lit: IM_SHOW: forest.smoke.smoking.gif }
You are stranded deep in the heart of a remote forest. #{|TEXTMODE}
+ [0,1,56,48 dark forest]
    Towering pines obscure the night sky.
    {player_is_cold:
        You know the way home, but the trek will take hours and you are currently extremely cold and damp, on the verge of hypothermia.
        + [Attempt to walk home]
            You die of hypothermia before you make it home. You are then eaten by a Grue.
            GAME OVER.
            ++ [Try again?]
                # RESTART
                -> DONE
        + [Stay here for now] -> exterior
    -else:
        You know the way home, and now that you are warm and dry you believe you can make it home safely.
        + [Walk home]
            After many hours hiking through the forest you finally return to civilization.
            CONGRATULATIONS!
            ++ [Play again?]
                # RESTART
                -> DONE
    }
+ {not got_firewood}[57,42,69,48 pile of firewood]
    You find some firewood lying near the cabin.
    ~got_firewood = true
    -> OK -> exterior
+ [73,9,96,48 log cabin]
    There is an abandoned log cabin nearby.
    ++ [Enter the cabin]
        -> interior
    ++ [Back]
        -> exterior


=== interior ===
# CLEAR
# SCENE: interior.background.gif
You {|once again }find yourself inside {a|the} small cabin.{  It seems like it hasn't been inhabited in quite some time.|} # TEXTMODE
{fire_lit:
    # IM_SHOW: interior.fireplace.burning.gif
    A fire crackles in the fireplace. # TEXTMODE
- else:
    The fireplace is cold and dark. # TEXTMODE
}
+ [73,28,96,48 fireplace]
  {not fire_lit:
    The fireplace is unlit.
    {got_firewood:
        Would you like to light it?
        + [Yes]
            ~fire_lit = true
            -> interior
        + [No]
            -> interior
    - else:
        You could light it if you had some firewood.
        -> OK -> interior
    }
  - else:
    The fire warms your aching bones and dries your damp clothes.
    ~player_is_cold = false
    -> OK -> interior
  }
+ [31,9,61,32 window]
    It looks cold out there.
    -> OK -> interior
+ [2,9,27,48 door]
    -> exterior
```
