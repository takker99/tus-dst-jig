include <BOSL2/std.scad>

module dst_spacer(outer_width = 170, outer_depth = 70, spacer_width = 10, spacer_thickness = 1, guide_flange = 5, guide_thickness = 0.5, handle_size = 15, anchor = CENTER, spin = 0, orient = UP) {
  guide_width = outer_width + guide_thickness * 2;
  guide_height = guide_flange * 2 + spacer_thickness;

  attachable(anchor, spin, orient, size=[guide_width + handle_size * 2, outer_depth + guide_thickness, guide_height]) {
    fwd((outer_depth - guide_thickness) / 2)
      // 幅方向のスペーサー
      cuboid([outer_width, spacer_width, spacer_thickness], anchor=FRONT + BOTTOM) {
        position(BACK)
          // 奥行方向のスペーサー
          xflip_copy(offset=outer_width / 2)
            cuboid([spacer_width, outer_depth - spacer_width, spacer_thickness], anchor=FRONT + RIGHT);
        position(FRONT) {

          // せん断箱固定用ガイド
          cuboid([guide_width + handle_size * 2, guide_thickness, guide_height], rounding=guide_thickness / 2, edges=["X", LEFT, RIGHT], anchor=BACK) {
            position(FRONT)
              xflip_copy(offset=guide_width / 2)
                cuboid([guide_thickness, outer_depth + guide_thickness, guide_height], rounding=guide_thickness / 2, edges=["Y", FRONT, BACK], except=[BACK + LEFT], anchor=FRONT + RIGHT);
            position(BACK) {
              support_size = handle_size * 0.95;
              xflip_copy(offset=guide_width / 2 + support_size / 2)
                fillet(l=2, r=support_size, ang=90, anchor=FRONT);
              // prismoid(size1=[support_size, spacer_thickness], size2=[0, spacer_thickness], shift=[-support_size / 2, 0], h=support_size);
            }
          }
        }
      }
    children();
  }
}

render()
  xrot(90)
    dst_spacer(outer_width=170.6, outer_depth=70, spacer_width=9, guide_thickness=1, spacer_thickness=1.775197557 + 0.3, anchor=FRONT, $fn=100);
    // 混合率0%は1.775197557+0.3, 30%は5.269788182+0.3とした
