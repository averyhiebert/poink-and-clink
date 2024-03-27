//#TITLE: Test Project

#IM_SHOW: images/bg.png
Should be seeing: white background.

* A choice.
* 0,0,100,100 A clickable choice
-
#IM_SHOW: images/table.png
Should now see: background with table

* Ok
-
#IM_REPLACE: images/bg.png images/plant.gif
Background should now be replaced with plant.

* Ok
-
#IM_HIDE: images/table.png
Table should now be gone.

Done with all the choices.
* Ok
-
Table should be back #IM_REPLACE: nonsense.png images/table.png

* Ok
-
# NEW_SCENE: images/bg.png
Should be back to just background now.

End of test.

-> END