// 机箱前面板 - 简化版本 (无X图案)
// 尺寸: 285mm x 209mm x 2.8mm
// 四角倒角设计

// 参数
width = 285;     // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// 圆角矩形模块
module rounded_rect(w, h, r, t) {
    hull() {
        translate([r, r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([w - r, r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([w - r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
    }
}

// 创建前面板
color("LightGray") {
    rounded_rect(width, height, corner_radius, thickness);
}
