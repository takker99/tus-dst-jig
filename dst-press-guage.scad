
include <BOSL2/std.scad>

module dst_press_guide(width = 120, depth = 120, tolerance = 0.5, thickness = 1, guide_thickness = 0.5, guide_height = 5, handle_length = 40, anchor = CENTER, spin = 0, orient = UP) {
  w = width - tolerance;
  d = depth - tolerance;
  h = thickness + max(guide_thickness, handle_length);

  attachable(anchor, spin, orient, size=[w, d, h]) {
    down(h / 2)
      // 幅方向のスペーサー
      cuboid([w, d, thickness], anchor=BOTTOM)
        position(TOP) {
          // 奥行方向のスペーサー
          yflip_copy(offset=w / 2) cuboid([w, guide_thickness, guide_height], anchor=BOTTOM + BACK);
          // 幅方向のスペーサー
          xflip_copy(offset=w / 2) cuboid([guide_thickness, w, guide_height], anchor=BOTTOM + RIGHT);
          // 取っ手
          cyl(l=handle_length, d=10, rounding1=-5, rounding2=1.5, anchor=BOTTOM);
          grid_copies(spacing=w / 2, n=2)
            cyl(l=handle_length, d=10, rounding1=-5, rounding2=1.5, anchor=BOTTOM);
        }
    children();
  }
}

// 印刷時は以下を有効化する
// gitではファイルサイズが大きすぎてcommitできないため、無効化した状態でcommitしている
// $fa=0.1;
// $fs=0.1;
render()
  dst_press_guide(thickness=2, anchor=BOTTOM);
