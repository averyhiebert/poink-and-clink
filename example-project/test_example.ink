#TITLE: Test Project
#CANVAS_WIDTH: 60%
#CANVAS_SHAPE: 200 200

#IM_PREFIX: images/example_scene.
#SCENE: bg.gif
Should be seeing: white background.

* A choice.
* 0,0,10,10 A clickable choice
-
#IM_SHOW: table.gif
Should now see: background with table.
Click anywhere to continue...
* [,,, Click to continue...]
* Ok
-
#IM_REPLACE: bg.gif plant.gif
Background should now be replaced with plant.

* Ok
-
#IM_HIDE: table.gif
Table should now be gone.

Done with all the choices.
* Ok
-
Table should be back #IM_REPLACE: nonsense.gif table.gif

* Ok
-
# SCENE: bg.gif
Should be back to just background now.

End of test.

-> END