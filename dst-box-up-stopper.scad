include <BOSL2/std.scad>

$fa = 4;
$fs = 0.25;

id1 = 22;
id2 = 14;
height = 62;
offset = 5;
wall = 3;
curved_part_height = height - offset * 2;
handle_length = curved_part_height * 0.6;
inner = zrot(90, [[0, id1 / 2], [0 + handle_length, id1 / 2], [curved_part_height - handle_length, id2 / 2], [curved_part_height, id2 / 2]]);
outer = left(wall, inner);

// debug_bezier(inner, N=len(inner) - 1);
// debug_bezier(outer, N=len(outer) - 1);

render()
  union() {
    tube(id=id1, h=offset, wall=wall, anchor=BOTTOM);
    up(offset)
      rotate_extrude()
        polygon(concat(bezier_curve(inner), reverse(bezier_curve(outer))));
    up(offset + curved_part_height)
      tube(id=id2, h=offset, wall=wall, anchor=BOTTOM);
  }
