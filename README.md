# GML-2D-Single-Camera-System
A single-camera implementation for Game Maker Studio 2. Fully self-contained in one object with only two events (four if you count zoom in/out buttons). 



Hello! This is a camera system I refined from a tutorial from PixelatedPope on Youtube. 
GMS2 Cameras: As Simple as Possible / https://www.youtube.com/watch?v=_g1LQ6aIJFk)  
I wanted a camera object that was easy to import into other projects with minimal setup, and I wanted it to support zooming in/out,
easy customization, and fewer "magic numbers" littering the code (Fine for a tutorial, less so for something I want to reuse).

This only requires 4 events in a camera object, and has clearly delinieated properties the user can edit. 

To set this up, simply place camera_init() in the create event, camera_update() in the end step event, and zoom_in() and zoom_out() in the events for 
whatever keys you'd like assigned to them, such as + and -, < and >, or the mouse wheel up and down. 

To adjust the behavior of the camera, the Properties struct inside of camera_init() contains the variables for the aspect ratio, the default zoom level, etc. 
Important: replace  obj_character in the properties struct with the actual object you want the camera to follow. 


!!!IMPORTANT!!! !!!IMPORTANT!!! !!!IMPORTANT!!!
This requires GMS2. I specifically used GameMaker LTS v2022.0.1.30, but it should probably work with pretty much all versions of GMS2/GameMaker
beyond Game Maker Studio 1. 
!!!IMPORTANT!!! !!!IMPORTANT!!! !!!IMPORTANT!!!
