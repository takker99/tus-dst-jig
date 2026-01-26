include <BOSL2/std.scad>
include <BOSL2/walls.scad>

module clamp(rod_diameter = 20, tolerance = 0.5, thickness = 3, height = 30, anchor = CENTER, spin = 0, orient = UP) {
  outer_diameter = rod_diameter + tolerance + thickness * 2;
  attachable(anchor, spin, orient, size=[outer_diameter / 2, outer_diameter, height]) {
    left(outer_diameter / 4)
      right_half() tube(od=outer_diameter, h=height, wall=thickness);
    children();
  }
}

module dst_rod_stopper(distance_of_rod = 90, rod_diameter = 20, tolerance = 0.5, thickness = 3, bridge_thickness = 3, height = 30, anchor = CENTER, spin = 0, orient = UP) {
  w = distance_of_rod + rod_diameter;
  d = rod_diameter + tolerance + thickness * 2;

  attachable(anchor, spin, orient, size=[w, d, height]) {
    cuboid([distance_of_rod - tolerance, bridge_thickness, height]) {
      position(LEFT)
        right(thickness)
          clamp(rod_diameter=rod_diameter, tolerance=tolerance, height=height, thickness=thickness, anchor=RIGHT);
      attach(RIGHT, RIGHT)
        down(thickness)
          clamp(rod_diameter=rod_diameter, tolerance=tolerance, height=height, thickness=thickness);
    }
    children();
  }
}

$fa = 4;
$fs = 0.25;
render()
  dst_rod_stopper(distance_of_rod=90, rod_diameter=20, tolerance=0.5, thickness=2, bridge_thickness=1, height=70, anchor=BOTTOM);
