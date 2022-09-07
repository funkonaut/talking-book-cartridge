//Author: Chris Correll
//Date: 9/5/2022
//Description: Joy Player replacement cartridge for easy flash drive swabbing

$fn = 40;
e=.01;

//cartridge
x = 95;
y = 57;
z = 9.75;
hole_r = 19/2;
hole_off = 5.25;
hole_h = z+e;
lip_off_x = 2.5;
lip_off_y = 2.5;
lip_off_z = .5;

//guide slots
slot_length = 48; 
slot_r = 5.5;

//cut out for flash drive
cut_x = 50.5;
cut_y = 19;
cut_z = 8.75; 
cut_hole_r = 9.5/2;
cut_hole_h = 8.75;
cut_hole_off = 15.25; 
//cut_off_x =
//cut_off_y
//cut_off_z = 1; //3.3 from top of cartridge to flash drive 2 from case outer to flash drive and 2.5 from cut out to top of cartridge so 4.5-3.3 offset need
drive_off_x = 12;
drive_off_y = 3.5;
drive_off_thick = 2;

module rounded_cube(w,l,z,rad1,rad2){
    hull(){
        translate([(w)/2-rad1,(l)/2-rad1,0])
        cylinder(h = z, r = rad1, center = true);
        translate([-((w)/2-rad2),-((l)/2-rad2),0])
        cylinder(h = z, r = rad2, center = true);
        translate([-((w)/2-rad1),(l)/2-rad1,0])
        cylinder(h = z, r = rad1, center = true);
        translate([(w)/2-rad2,-((l)/2-rad2),0])
        cylinder(h = z, r = rad2, center = true);  
    };
}

//stops for flash drive
union(){
translate([x/2+drive_off_thick/2-drive_off_x,drive_off_x-drive_off_y,-lip_off_z/2])
cube([drive_off_thick, drive_off_y, z-lip_off_z],center=true);
translate([x/2+drive_off_thick/2-drive_off_x,-drive_off_x+drive_off_y,-lip_off_z/2])
cube([drive_off_thick, drive_off_y, z-lip_off_z],center=true);

//cartridge
difference(){
//main cartridge with ridge
rounded_cube(x,y,z,10,10);
translate([0,0,z-lip_off_z])
rounded_cube(x-lip_off_x,y-lip_off_y,z,10,10);

//holder hole
translate([-x/2+hole_r+hole_off,0,0])
cylinder(r = hole_r, h = hole_h, center=true);

//flash drive slot
translate([x/2-cut_x/2,0,-z/2+cut_z/2])
cube([cut_x,cut_y,cut_z],center=true);

//hole change cut_z to 7.5 
//translate([cut_hole_off,0,-z/2+cut_hole_h/2])
//#cylinder(r = cut_hole_r, h = cut_hole_h, center=true);

//guide slots
translate([x/2-cut_x/2,-y/2,-z/2])
rotate([0,90,0])
cylinder(r=slot_r,h=slot_length,center=true);
translate([x/2-cut_x/2,y/2,-z/2])
rotate([0,90,0])
cylinder(r=slot_r,h=slot_length,center=true);
}
}