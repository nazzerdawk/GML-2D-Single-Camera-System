/*
	Hello! This is a camera system I refined from a tutorial from PixelatedPope on Youtube. 
		(GMS2 Cameras: As Simple as Possible / https://www.youtube.com/watch?v=_g1LQ6aIJFk)  
	I wanted a camera object that was easy to import into other projects with minimal setup, and I wanted it to support zooming in/out,
	easy customization, and fewer "magic numbers" littering the code (Fine for a tutorial, less so for something I want to reuse).
	
	This only requires 4 events in a camera object, and has clearly delinieated properties the user can edit. 
	
	To set this up, simply place camera_init() in the create event, camera_update() in the end step event, and zoom_in() and zoom_out() in the events for 
		whatever keys you'd like assigned to them, such as + and -, < and >, or the mouse wheel up and down. 
	
	To adjust the behavior of the camera, the Properties struct inside of camera_init() contains the variables for the aspect ratio, the default zoom level, etc. 
	Important: replace  obj_character in the properties struct with the actual object you want the camera to follow. 
*/




function camera_init(){
	properties = {
		aspect_ratio_h : 16,				//horizontal factor of the resolution
		aspect_ratio_v : 9,					//vertical factor of the resolution
		zoom_level : 40, 					//Default zoom level for camera, higher means further away, lower means closer.
		zoom_increment : 20,				//How far to move the camera for each step of zooming in/out
		zoom_min : 20,						//The closest you can zoom in. For best results, use a multiple of the increment. 
		zoom_max : 300,						//The furthest you can zoom in. For best results, use a multiple of the increment. 
		zoom_speed : 15,					//how fast to adjust zoom. 100 means instant, 50 means half speed, 1 means zooming goes slowly. 
		object_following : obj_character,	//The object the camera follows. 
		tracking_speed : 15,				//How fast the camera follows the object. 100 means instant, 1 means it will drift VERY slowly. 
		camera_restrained : false,			//Can the camera move beyond the edges of the playfield?
		window_scale : 1.5					//The size of the game window. For wider aspect ratios, this is more impactful than for ones close to square. 
	}
	
	
	zoom_divisor = (properties.zoom_speed/100) 
	tracking_divisor = (properties.tracking_speed/100)
	view_width	= properties.aspect_ratio_h*properties.zoom_level
	view_height = properties.aspect_ratio_v*properties.zoom_level
	
	view_width_target = view_width
	view_height_target = view_height
	

	window_width = view_width*properties.window_scale
	window_height = view_height*properties.window_scale
	
	window_set_size(window_width,window_height);
	surface_resize(application_surface,window_width,window_height);
	window_center();
}
function camera_update(){
	var target = properties.object_following
	
	camera_set_zoom()	
	camera_set_view_size(view_camera[0],view_width,view_height)
	

	
	if instance_exists(target){
		drift_towards(target.x,target.y,tracking_divisor)
		if properties.camera_restrained = true
			keep_in_room()
		var cam_x = x-view_width/2;
		var cam_y = y-view_height/2;
		camera_set_view_pos(view_camera[0],cam_x,cam_y);
	}
}
function zoom_in(){
	if properties.zoom_level > properties.zoom_min
		properties.zoom_level -= properties.zoom_increment
	else
		properties.zoom_level = properties.zoom_min
}
function zoom_out(){
	if properties.zoom_level < properties.zoom_max
		properties.zoom_level += properties.zoom_increment
	else
		properties.zoom_level = properties.zoom_max
}




function drift_towards(_x,_y,distance_multiplier){
	//distance multiplier should be a decimal
	
	x = lerp(x,_x,distance_multiplier)
	y = lerp(y,_y,distance_multiplier)
	
}
function camera_set_zoom(){
	
	
	view_width_target = properties.aspect_ratio_h*properties.zoom_level
	view_height_target = properties.aspect_ratio_v*properties.zoom_level
	
	//Smoothly adjust zoom level to the target zoom level		
	if (view_width != view_width_target and view_height != view_height_target){
		view_width = lerp(view_width,view_width_target,zoom_divisor)
		view_height = lerp(view_height,view_height_target,zoom_divisor)
	}
}
function keep_in_room(){
	x = clamp(x,0,room_width-view_width)
	y = clamp(y,0,room_height-view_height)
}
function enable_view(){
	view_enabled = true;
	view_visible[0] = true;
}


camera_init()
