// 机箱前面板
// 尺寸: 285mm x 209mm x 2.8mm
// 四角倒角设计
// 中心凸起 X 图案

// 参数
width = 285;     // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// X 图案参数
x_max_height = 1.0;  // X 中心最大凸起高度 (mm)
x_width = 8;         // X 线条宽度 (mm)
x_diagonal = 120;    // X 对角线长度 (mm)

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

// X 图案模块 - 中心凸起向边缘渐变
module x_pattern() {
    center_x = width / 2;
    center_y = height / 2;

    // 使用分段堆叠实现沿X方向的渐变
    segments = 30;  // 每条线分为多少段
    segment_length = x_diagonal / segments;

    union() {
        // 第一条对角线 (从左下到右上)
        for (i = [-segments/2:segments/2-1]) {
            // 距离中心的相对距离 (0 到 0.5)
            dist_ratio = abs(i) / (segments/2);

            // 当前段的高度：中心1mm，边缘0mm
            current_height = x_max_height * (1 - dist_ratio);

            translate([center_x, center_y, thickness])
            rotate([0, 0, 45])
            translate([i * segment_length, -x_width/2, 0])
            cube([segment_length + 0.1, x_width, current_height]);
        }

        // 第二条对角线 (从左上到右下)
        for (i = [-segments/2:segments/2-1]) {
            dist_ratio = abs(i) / (segments/2);
            current_height = x_max_height * (1 - dist_ratio);

            translate([center_x, center_y, thickness])
            rotate([0, 0, -45])
            translate([i * segment_length, -x_width/2, 0])
            cube([segment_length + 0.1, x_width, current_height]);
        }
    }
}

// 添加 X 图案
color("DarkGray") {
    x_pattern();
}

// 简单的倒角版本备选（使用 chamfer）
// module chamfered_rect(w, h, c, t) {
//     minkowski() {
//         translate([c, c, 0]) cube([w - 2*c, h - 2*c, t]);
//         cylinder(h = c, r = c, $fn = 32);
//     }
// }
//
// chamfered_rect(width, height, corner_radius, thickness);
