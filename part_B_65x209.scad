// 机箱前面板 - B部分
// 尺寸: 65mm x 209mm x 2.8mm
// 接缝处无倒角

// 参数
width = 65;      // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// 圆角矩形模块 - 只在右侧、上侧、下侧倒角，左侧（接缝处）不倒角
module rounded_rect_one_side(w, h, r, t) {
    hull() {
        // 左下角（接缝处，不倒角）
        translate([0, 0, 0])
        cylinder(h = t, r = 0.01, $fn = 4);
        // 左上角（接缝处，不倒角）
        translate([0, h, 0])
        cylinder(h = t, r = 0.01, $fn = 4);
        // 右上角
        translate([w - r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
        // 右下角
        translate([w - r, r, 0]) cylinder(h = t, r = r, $fn = 32);
    }
}

// 创建面板
color("LightGray") {
    rounded_rect_one_side(width, height, corner_radius, thickness);
}
