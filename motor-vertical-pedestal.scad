include <BOSL2/std.scad>

$fa = 4;
$fs = 0.25;

machine_width = 170;
rod_clearance = 130;
rod_radius = 25 * 1.2; // 余裕をもって1.2倍しておく

pocket_depth = 15 + 2; // 電磁クラッチ載荷装置のフランジの厚みが15mmくらいなので、それより少し深くしておく
pocket_width = machine_width + 4;

pillar_radius = 15;
pillar_length = rod_clearance + pocket_depth;
pillar_rounding1 = 10;

pedestal_thickness = 2;
pedestal_width = machine_width + (pillar_radius + pillar_rounding1) * 4 / 3; // 支柱の2/3を載荷装置を載せるためのスペースにする
pedestal_rounding = pillar_radius + pillar_rounding1;

path = [for (theta = [0:360]) [25 * cos(theta), 25 * sin(theta), 4 * cos(theta * 4)]];

text_thickness = 0.4;

render()
  diff()
    cuboid([pedestal_width, pedestal_width, pedestal_thickness], rounding=pedestal_rounding, edges=["Z"], anchor=BOTTOM) {
      position(TOP) {
        tag("remove") zcyl(l=pedestal_thickness, r=rod_radius, anchor=TOP);
        grid_copies(size=pedestal_width - (pillar_radius + pillar_rounding1) * 2, n=2) zcyl(l=pillar_length, r=pillar_radius, rounding1=-pillar_rounding1, rounding2=pillar_rounding1 / 2, anchor=BOTTOM)
            tag("remove") {
              cylindrical_extrude(or=pillar_radius + 1, ir=pillar_radius - text_thickness)
                text(text=str("←l=", rod_clearance, "mm→"), size=10, halign="center", valign="center", spin=-90);
              cylindrical_extrude(or=pillar_radius + 1, ir=pillar_radius - text_thickness, spin=180)
                text(text=str("Φ", pillar_radius * 2, "mm"), size=10, halign="center", valign="center");
            }
        up(pillar_length) tag("remove") cuboid([pocket_width, pocket_width, pocket_depth], rounding=2, edges=["Z"], anchor=TOP);
      }
      position(TOP + FRONT) {
        back(2) tag("remove") text3d(text=str("←w=", pedestal_width, "mm→"), size=5, h=text_thickness, anchor=FRONT, atype="ycenter");
        back(2 + 8) tag("remove") text3d(text=str("←pocket size=", pocket_width, "mm→"), size=5, h=text_thickness, anchor=FRONT, atype="ycenter");
        back(2 + 8+8) tag("remove") text3d(text=str("pedestal thickness=", pedestal_thickness, "mm"), size=5, h=text_thickness, anchor=FRONT, atype="ycenter");
      }
      position(TOP) {
        fwd(rod_radius * 1.1) tag("remove") text3d(text=str("←Φ", rod_radius * 2, "mm→"), size=8, h=text_thickness, anchor=BACK, atype="ycenter");
      }
      back(2) tag("remove") text3d(text=str("←w=", pedestal_width, "mm→"), size=5, h=text_thickness, anchor=FRONT, atype="ycenter");
      position(TOP + BACK) {
        fwd(2) tag("remove") text3d(text=str("←w=", pedestal_width, "mm→"), size=5, h=text_thickness, anchor=FRONT, atype="ycenter", spin=180);
      }
      position(TOP + LEFT) {
        right(2) tag("remove") text3d(text=str("←w=", pedestal_width, "mm→"), size=5, h=text_thickness, anchor=FRONT, atype="ycenter", spin=-90);
      }
      position(TOP + RIGHT) {
        left(2) tag("remove") text3d(text=str("←w=", pedestal_width, "mm→"), size=5, h=text_thickness, anchor=FRONT, atype="ycenter", spin=90);
      }
    }
