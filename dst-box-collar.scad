include <BOSL2/std.scad>

collar_height = 120;
box_inner_width = 119.7;
box_inner_depth = 119.6;
guard_tolerance = 0.5;
isize = [box_inner_width - guard_tolerance * 2, box_inner_depth - guard_tolerance * 2];
wall_thickness = 1;
base_thickness = 1;
base_width = 15;

// render()
//   cuboid([wall_thickness, 20, wall_thickness]) {
//     position(LEFT)
//       xrot(-90)
//         fillet(l=collar_height - base_thickness, r=wall_thickness / 2, ang=135, anchor=FWD + LEFT, spin=90);
//     position(RIGHT)
//       xrot(-90)
//       xflip()
//         fillet(l=collar_height - base_thickness, r=wall_thickness / 2, ang=135, anchor=FWD + LEFT, spin=90);
//   }

$fn=100;
render()
  // Base of the collar
  rect_tube(h=base_thickness, isize=isize, wall=base_width - guard_tolerance, rounding=wall_thickness, irounding=0, anchor=BOTTOM)
    position(TOP)
      // Collar walls
      rect_tube(h=collar_height - base_thickness, isize=isize, wall=wall_thickness, anchor=BOTTOM) {
        edge_profile_asym(BOTTOM, corner_type="round")
          xflip() mask2d_roundover(4);
        // Reinforcement wedges at the edges
        attach(LEFT, BOTTOM)
          xcopies(isize[1] / 3) wedge([wall_thickness, collar_height - base_thickness, base_width - guard_tolerance - wall_thickness], center=true);
        attach(RIGHT, BOTTOM)
          xcopies(isize[1] / 3) wedge([wall_thickness, collar_height - base_thickness, base_width - guard_tolerance - wall_thickness], center=true);
        attach(FWD, BOTTOM)
          xcopies(isize[1] / 3) wedge([wall_thickness, collar_height - base_thickness, base_width - guard_tolerance - wall_thickness], center=true);
        attach(BACK, BOTTOM)
          xcopies(isize[1] / 3) wedge([wall_thickness, collar_height - base_thickness, base_width - guard_tolerance - wall_thickness], center=true);
        // Reinforcement wedges at the corners
        attach(LEFT + FWD, BOTTOM, inside=true)
          cuboid([wall_thickness, collar_height - base_thickness, wall_thickness]) {
            attach(BOTTOM, BOTTOM)
              wedge([wall_thickness, collar_height - base_thickness, base_width - guard_tolerance - wall_thickness], center=true);
            position(LEFT)
              xrot(-90)
                fillet(l=collar_height - base_thickness, r=wall_thickness / 2, ang=135, anchor=FWD + LEFT, spin=90);
            position(RIGHT)
              xrot(-90)
                xflip()
                  fillet(l=collar_height - base_thickness, r=wall_thickness / 2, ang=135, anchor=FWD + LEFT, spin=90);
          }
        attach(LEFT + BACK, BOTTOM, inside=true)
          cuboid([wall_thickness, collar_height - base_thickness, wall_thickness]) {
            attach(BOTTOM, BOTTOM)
              wedge([wall_thickness, collar_height - base_thickness, base_width - guard_tolerance - wall_thickness], center=true);
            position(LEFT)
              xrot(-90)
                fillet(l=collar_height - base_thickness, r=wall_thickness / 2, ang=135, anchor=FWD + LEFT, spin=90);
            position(RIGHT)
              xrot(-90)
                xflip()
                  fillet(l=collar_height - base_thickness, r=wall_thickness / 2, ang=135, anchor=FWD + LEFT, spin=90);
          }
        attach(RIGHT + BACK, BOTTOM, inside=true)
          cuboid([wall_thickness, collar_height - base_thickness, wall_thickness]) {
            attach(BOTTOM, BOTTOM)
              wedge([wall_thickness, collar_height - base_thickness, base_width - guard_tolerance - wall_thickness], center=true);
            position(LEFT)
              xrot(-90)
                fillet(l=collar_height - base_thickness, r=wall_thickness / 2, ang=135, anchor=FWD + LEFT, spin=90);
            position(RIGHT)
              xrot(-90)
                xflip()
                  fillet(l=collar_height - base_thickness, r=wall_thickness / 2, ang=135, anchor=FWD + LEFT, spin=90);
          }
        attach(RIGHT + FWD, BOTTOM, inside=true)
          cuboid([wall_thickness, collar_height - base_thickness, wall_thickness]) {
            attach(BOTTOM, BOTTOM)
              wedge([wall_thickness, collar_height - base_thickness, base_width - guard_tolerance - wall_thickness], center=true);
            position(LEFT)
              xrot(-90)
                fillet(l=collar_height - base_thickness, r=wall_thickness / 2, ang=135, anchor=FWD + LEFT, spin=90);
            position(RIGHT)
              xrot(-90)
                xflip()
                  fillet(l=collar_height - base_thickness, r=wall_thickness / 2, ang=135, anchor=FWD + LEFT, spin=90);
          }
      }
