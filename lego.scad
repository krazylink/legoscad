//
//User defined parameters
//

height=1; //Height in units
width=2; //Width in units
length=4; //Length in units


//
// Constant Paramaters
//
$fn=50;  //Up the number of faces to look nicer

pip_dia = 4.9; //Pip diamater
pip_height = 1.89; //Pip height
pip_offset = 3.93; //Pip offset from center

wall_thickness = 1.48; //Wall thickness

post_id = 4.07; //Post inner diameter
post_od = 6.38; //Post outter diameter
post_offset=7.98; //Offset between posts
post_center=7.92; // center of post


block_height=7.92; //1 block height unit. 
block_width=7.98; //1 block width unit


//Build the cube
difference() {
	cube([
	  block_width*width, 
	  block_width*length, 
	  block_height*height
	]);
	translate([(wall_thickness/2)*width, (wall_thickness/2)*length,0])
	cube([
	  (block_width-wall_thickness)*width, 
	  (block_width-wall_thickness)*length, 
	  (block_height-wall_thickness)*height
	]);
}

//Build the pips
for (l=[0:length-1]) {
	for (w=[0:width-1]) {
		translate([
		  pip_offset+((2*pip_offset)*w),
		  pip_offset+((2*pip_offset)*l),
		  block_height*height
		])
		cylinder(pip_height, pip_dia/2, pip_dia/2);
	}
}

//Build the posts
if (length>1 && width>1)
{
	for (l=[1:length-1]) {
		for (w=[1:width-1]) {
			difference() {
				translate([post_center*w, post_center*l,0])
				cylinder(
				  (block_height*height)-wall_thickness, 
				  post_od/2, 
				  post_od/2);
				translate([post_center*w, post_center*l, 0])
				cylinder(
				  (block_height*height)-wall_thickness, 
				  post_id/2, 
				  post_id/2);
			}
		}
	}
}