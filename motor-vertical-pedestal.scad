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

render()
  diff()
    cuboid([pedestal_width, pedestal_width, pedestal_thickness], rounding=pedestal_rounding, edges=["Z"], anchor=BOTTOM)
      position(TOP) {
        tag("remove") zcyl(l=pedestal_thickness, r=rod_radius, anchor=TOP);
        grid_copies(size=pedestal_width - (pillar_radius + pillar_rounding1) * 2, n=2) zcyl(l=pillar_length, r=pillar_radius, rounding1=-pillar_rounding1, rounding2=pillar_rounding1 / 2, anchor=BOTTOM);
        up(pillar_length) tag("remove") cuboid([pocket_width, pocket_width, pocket_depth], rounding=2, edges=["Z"], anchor=TOP);
      }
