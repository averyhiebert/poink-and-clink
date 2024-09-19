// The "vanilla ink" version of a simple demo scene for the tutorial.
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
You are stranded deep in the heart of a remote forest.
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
You {|once again }find yourself inside {a|the} small cabin.{  It seems like it hasn't been inhabited in quite some time.|}
{fire_lit:
    # IM_SHOW: interior.fireplace.burning.gif
    A fire crackles in the fireplace.
- else:
    The fireplace is cold and dark.
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
