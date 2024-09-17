// The "vanilla ink" version of a simple demo scene for the tutorial.
# TITLE: Simple Poink Game

-> exterior

=== OK ===
+ [Ok]
    ->->

VAR got_firewood = false
=== exterior ===
# CLEAR
You are lost deep in the heart of a remote forest.
Towering pines obscure the night sky.
+ [dark forest]
    Maybe you can find your way out.
    Wander into the thick overgrowth?
    ++ [Yes]
        You were eaten by a grue.
        GAME OVER.
        +++ [Restart]
            # RESTART
            -> DONE
    ++ [No]
        Good idea.
        -> OK -> exterior
+ {not got_firewood}[pile of firewood]
    You find some firewood lying near the cabin.
    ~got_firewood = true
    -> OK -> exterior
+ [log cabin]
    There is an abandoned log cabin nearby.
    ++ [Enter the cabin.]
        -> interior
    ++ [Back]
        -> exterior


VAR fire_lit = false
=== interior ===
# CLEAR
You {|once again }find yourself inside {a|the} small cabin. It seems like it hasn't been inhabited in quite some time.
{fire_lit:
    A fire crackles in the fireplace.
- else:
    The fireplace is cold and dark.
}
+ {not fire_lit}[fireplace]
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
+ [window]
    It looks cold out there.
    -> OK -> interior
+ [door]
    -> exterior
