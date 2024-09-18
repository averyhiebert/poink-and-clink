// The "vanilla ink" version of a simple demo scene for the tutorial.
# TITLE: Simple Poink Game

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
