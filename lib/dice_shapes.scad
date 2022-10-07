phi=((1+sqrt(5))/2);

d4_points= [
[1,1,1], //0
[1,-1,-1], //1
[-1,1,-1], //2
[-1,-1,1], //3
];
d4_faces = [
[2,1,0], //face1
[3,2,0], //face2
[1,2,3], //face3
[1,3,0], //face4
];

d6_points = [
[-1,-1,-1], //0
[1,-1,-1], //1
[1,1,-1], //2
[-1,1,-1], //3
[-1,-1,1], //4
[1,-1,1], //5
[1,1,1], //6
[-1,1,1], //7
];
d6_faces = [
[0,1,2,3], //face1
[7,4,0,3], //face6
[4,5,1,0], //face2
[6,7,3,2], //face5
[5,6,2,1], //face4
[7,6,5,4], //face3
];

d8_points = [
[1.5,0,0], //0
[-1.5,0,0], //1
[0,1.5,0], //2
[0,-1.5,0], //3
[0,0,1.5], //4
[0,0,-1.5], //5
];
d8_faces = [
[0,5,3], //face1
[0,3,4], //face2
[2,0,4], //face3
[0,2,5], //face4
[2,1,5], //face5
[1,2,4], //face6
[1,4,3], //face7
[1,3,5], //face8
];

d12_points = [
[1, 1, 1], //0
[1, -1, 1], //1
[1, 1, -1], //2
[1, -1, -1], //3
[-1, 1, 1], //4
[-1, -1, 1], //5
[-1, 1, -1], //6
[-1, -1, -1], //7
[0, (1/phi), phi], //8
[0, (1/phi), -phi], //9
[0, -(1/phi), phi], //10
[0, -(1/phi), -phi], //11
[(1/phi), phi, 0], //12
[(1/phi), -phi, 0], //13
[-(1/phi), phi, 0], //14
[-(1/phi), -phi, 0], //15
[phi, 0, (1/phi)], //16
[phi, 0, -(1/phi)], //17
[-phi, 0, (1/phi)], //18
[-phi, 0, -(1/phi)], //19
];
d12_faces = [
[8,0,16,1,10], //face1
[10,1,13,15,5], //face2
[8,10,5,18,4], //face3
[8,4,14,12,0], //face4
[16,0,12,2,17], //face5
[1,16,17,3,13], //face6
[19,7,11,9,6], //face7
[13,3,11,7,15], //face8
[17,2,9,11,3], //face9
[14,6,9,2,12], //face10
[4,18,19,6,14], //face11
[5,15,7,19,18], //face12
];

d20_points = [
[0, 1*1.7, phi*1.7], //0
[0, 1*1.7, -phi*1.7], //1
[0, -1*1.7, phi*1.7], //2
[0, -1*1.7, -phi*1.7], //3
[1*1.7, phi*1.7, 0], //4
[1*1.7, -phi*1.7, 0], //5
[-1*1.7, phi*1.7, 0], //6
[-1*1.7, -phi*1.7, 0], //7
[phi*1.7, 0, 1*1.7], //8
[phi*1.7, 0, -1*1.7], //9
[-phi*1.7, 0, 1*1.7], //10
[-phi*1.7, 0, -1*1.7], //11
];
d20_faces = [
[0,8,2], //face1
[1,3,9], //face2
[11,7,3], //face3
[11,6,10], //face4
[5,9,3], //face5
[4,6,1], //face6
[11,10,7], //face7
[8,9,5], //face8
[2,7,10], //face9
[1,6,11], //face10
[0,2,10], //face11
[0,6,4], //face12
[5,3,7], //face13
[4,1,9], //face14
[2,5,7], //face15
[8,4,9], //face16
[0,10,6], //face17
[2,8,5], //face18
[0,4,8], //face19
[1,11,3], //face20
];

module poly_with_text (points, faces, draw=true, draw_points=false, draw_text=false, text_depth=.2, font=undef) {
	if (draw_points)
		for (point=[0:1:len(points)-1])
			translate(points[point]) linear_extrude(height=.1) text(text=str(point), size=.5, halign="center", valign="center");
	difference() {
		if (draw)
			polyhedron(points, faces);
		if (draw_text) {
			for (face=[0:1:len(faces)-1]) {
				face_center = mean( 
				[
					for(i=[0:1:len(faces[face])-1])
					 points[faces[face][i]]
				]);
				translate(face_center*(1-text_depth))
				rotate([0,inclination_angle(face_center), azimuthal_angle(face_center)])
				if ((face+1==6) && len(faces)>6) //only print a dot on the 6 if the die is a d8 or higher.
					linear_extrude(text_depth+.5) text(str(face+1,"."), size=1, valign="center", halign="center");
				else if(face==len(faces)-1)
					linear_extrude(text_depth+.5) text("\u2699", size=1, valign="center", halign="center", font = "Dejavu Sans");

				else
					linear_extrude(text_depth+.5) text(str(face+1), size=1, valign="center", halign="center",font=font);

			}
		}
	}
}
