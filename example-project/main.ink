// The non-Aseprite-script version of a simple demo scene for the tutorial.
# TITLE: Simple Poink Game
# IM_PREFIX: images/
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
+ [0,1,56,48 dark forest]
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
+ {not got_firewood}[57,42,69,48 pile of wood]
    You find some firewood lying near the cabin.
    ~got_firewood = true
    -> OK -> exterior
+ [73,9,96,48 log cabin]
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
You {|once again }find yourself inside {a|the} small cabin. It seems like it hasn't been inhabited in quite some time. # TEXTMODE
{fire_lit:
    A fire crackles in the fireplace. # TEXTMODE
    # IM_SHOW: interior.fireplace.burning.gif
- else:
    The fireplace is cold and dark. # TEXTMODE
}
+ {not fire_lit}[73,28,96,48 fireplace]
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
+ [31,9,61,32 window]
    It looks cold out there.
    -> OK -> interior
+ [2,9,27,48 door]
    -> exterior
