#TITLE: Test Project

#SCENE: bg.png
#AUDIOLOOP: audio/rhapsody_in_blue.mp3

Should be seeing: white background.

* A choice.
* 0,0,100,100 A clickable choice
-
#IM_SHOW: table.png
Should now see: background with table.
Click anywhere to continue...
* [,,, Click to continue...]
* Ok
-
#IM_REPLACE: bg.png plant.gif
Background should now be replaced with plant.

* Ok
-
#IM_HIDE: table.png
Table should now be gone.

Done with all the choices.
* Ok
-
Table should be back #IM_REPLACE: nonsense.png table.png

* Ok
-
# SCENE: bg.png
Should be back to just background now.

End of test.

-> END