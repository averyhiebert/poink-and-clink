// The "vanilla ink" version of a simple demo scene for the tutorial.
# TITLE: Simple Poink Game
# IM_PREFIX: images/
# CANVAS_WIDTH: 60%
//# CANVAS_WIDTH: 96px
# CANVAS_SHAPE: 96 64

-> exterior

=== OK ===
+ [Ok]
+ [,,,]
- ->->

VAR got_firewood = false
=== exterior ===
# CLEAR
#SCENE: forest.background.gif
{not got_firewood:
    #IM_SHOW: forest.woodpile.gif
}
You are lost deep in the heart of a remote forest.
Towering pines obscure the night sky.
+ [2,0,64,43 dark forest]
    Maybe you can find your way out.
    Wander into the thick overgrowth?
    ++ [Yes]
        You were eaten by a grue.
        GAME OVER.
        +++ [Restart]
            # RESTART
            -> exterior
    ++ [No]
        Good idea.
        -> OK -> exterior
+ {not got_firewood}[15,43,39,57 pile of firewood]
    You find some firewood lying near the cabin.
    ~got_firewood = true
    -> OK -> exterior
+ [74,0,96,46 log cabin]
    There is an abandoned log cabin nearby.
    Enter it?
    ++ [Yes]
        -> interior
    ++ [No]
        -> exterior


VAR fire_lit = false
=== interior ===
# CLEAR
# SCENE: interior.background.gif
You {|once again }find yourself inside {a|the} small cabin. It seems like it hasn't been inhabited in quite some time.
{fire_lit:
    A fire crackles in the fireplace.
    # IM_SHOW: interior.fireplace.burning.gif
- else:
    The fireplace is cold and dark.
}
+ {not fire_lit}[1,32,20,53 fireplace]
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
+ [30,10,61,45 window]
    It looks cold out there.
    -> OK -> interior
+ [64,21,88,53 door]
    -> exterior
