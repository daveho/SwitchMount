// 3D printed switch mount for an Oslo Switch rocker switch.
// This seems to be a standard size requiring a 14mm by 29mm cutout.
// The mount is intended to be screwed to a horizontal surface
// using 6-32 machine screws.

$fn = 60;

cutout_w = 29;
cutout_h = 14;

// how much additional width and height the plate should have
// beyond the cutout for the switch
extend_w = 15;
extend_h = 10;

// front plate dimensions
plate_w = cutout_w + extend_w;
plate_h = cutout_h + extend_h;
plate_d = 2;

// thickness of triangular braces
brace_d = 3;

// side length (non-hypotenuse) of triangular braces
brace_len = cutout_h + 2;

// hole diameter and countersink diameter for 6-32 machine screw
n6_hole_diameter = 4;
n6_countersink_diameter = 8;

// Screw hole tab parameters
tab_len = n6_countersink_diameter + 4;
tab_h = brace_d;

// The front plate with the cutout for the switch
module plate() {
    difference() {
        cube([plate_w, plate_d, plate_h]);
        
        // cutout
        translate([extend_w/2, -plate_d/2, extend_h/2]) {
            cube([cutout_w, plate_d * 2, cutout_h]);
        }
    }
}

// Triangular brace
module brace() {
    translate([brace_d, 0, 0]) {
        rotate([0, -90, 0]) {
            linear_extrude(brace_d) {
                polygon([[0, 0], [brace_len, 0], [0, brace_len]]);
            }
        }
    }
}

// Tab with screw hole and countersink for attachment to bottom surface
module screw_tab() {
    difference() {
        cube([tab_len, tab_len, tab_h]);
        translate([tab_len/2, tab_len/2, -1]) {
            cylinder(h=tab_h+2, d=n6_hole_diameter);
        }
        translate([tab_len/2, tab_len/2, tab_h - 1]) {
            cylinder(h=2, d=n6_countersink_diameter);
        }
    }
}

// Entire switch mount
module switch_mount() {
    plate();
    translate([0, plate_d, 0]) {
        brace();
    }
    translate([plate_w - brace_d, plate_d, 0]) {
        brace();
    }
    translate([brace_d, plate_d, 0]) {
        screw_tab();
    }
    translate([plate_w - brace_d - tab_len, plate_d, 0]) {
        screw_tab();
    }
}

//plate();
//brace();
//screw_tab();

// rotate face down for printing
rotate([90, 0, 0]) {
    switch_mount();
}
