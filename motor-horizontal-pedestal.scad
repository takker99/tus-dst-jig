include <BOSL2/std.scad>

$fa = 4;
$fs = 0.25;

pedestal_height = 54; // やや緩めに設定。すき間は紙や布を挟んで調整する
pedestal_radius = 15 / 2; // 電磁クラッチ載荷装置のフランジの厚みが15mmくらい

path = [for (theta = [0:360]) [25 * cos(theta), 25 * sin(theta), 4 * cos(theta * 4)]];
render()
  diff() {
    cyl(l=pedestal_height, r=pedestal_radius, rounding=-pedestal_radius, anchor=BOTTOM);
    tag("remove") up(pedestal_height / 2) {
        cylindrical_extrude(or=pedestal_radius + 1, ir=pedestal_radius - 0.4)
          text(text=str("←l=", pedestal_height, "mm→"), size=5, halign="center", valign="center", spin=-90);
        cylindrical_extrude(or=pedestal_radius + 1, ir=pedestal_radius - 0.4, spin=180)
          text(text="Φ15mm", size=5, halign="center", valign="center");
      }
  }
