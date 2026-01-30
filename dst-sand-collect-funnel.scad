include <BOSL2/std.scad>
x_clearance = 5;
y_clearance = 15;
tolerance = 0.5;

width1 = 265 + tolerance + x_clearance * 2;
width2 = 50;
center = (170 - width2) / 2;
left_shrink = 14 + x_clearance;
right_shrink = width1 - center * 2 - width2 - left_shrink;
neck_length = 70;
funnel_length = 30;

$fn = 64;
box = turtle(["xmove", width1, "ymove", -y_clearance, "xmove", -right_shrink, "xymove", [-center, -neck_length], "ymove", -funnel_length - 5, "xmove", -width2, "ymove", funnel_length + 5, "xymove", [-center, neck_length], "xmove", -left_shrink]);
rbox = round_corners(box, cut=2);
thickness = 2;

render()
  back_half(y=-(y_clearance + neck_length + funnel_length), s=700)
    difference() {
      offset_sweep(
        rbox, height=50, check_valid=false, steps=22,
        bottom=os_circle(r=2), top=os_circle(r=1)
      );
      up(thickness) {
        offset_sweep(
          offset(rbox, r=-thickness, closed=true, check_valid=false),
          height=48, steps=22, check_valid=false,
          bottom=os_circle(r=2), top=os_circle(r=-1, extra=1)
        );
        right(width1 / 2)
          cuboid([width1 - x_clearance * 2, 6, 60], anchor=BACK + BOTTOM);
      }
    }
