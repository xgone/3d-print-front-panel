// 机箱前面板 - A部分
// 尺寸: 220mm x 209mm x 2.8mm
// 接缝处无倒角
// 中心凸起 X 图案

// 参数
width = 220;     // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// X 图案参数
x_max_height = 1.0;  // X 中心最大凸起高度 (mm)
x_width = 8;         // X 线条宽度 (mm)
x_diagonal = 120;    // X 对角线长度 (mm)

// 圆角矩形模块 - 只在左侧、上侧、下侧倒角，右侧（接缝处）不倒角
module rounded_rect_one_side(w, h, r, t) {
    hull() {
        // 左下角
        translate([r, r, 0]) cylinder(h = t, r = r, $fn = 32);
        // 左上角
        translate([r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
        // 右上角（接缝处，不倒角）
        translate([w, h, 0])
        cylinder(h = t, r = 0.01, $fn = 4);
        // 右下角（接缝处，不倒角）
        translate([w, 0, 0])
        cylinder(h = t, r = 0.01, $fn = 4);
    }
}

// 创建面板
difference() {
    union() {
        // 面板主体
        color("LightGray") {
            rounded_rect_one_side(width, height, corner_radius, thickness);
        }

        // X 图案
        color("DarkGray") {
            translate([width/2, height/2, 0])
            x_pattern();
        }
    }
}

// X 图案模块 - 中心凸起向边缘渐变
module x_pattern() {
    segments = 30;  // 每条线分为多少段
    segment_length = x_diagonal / segments;

    union() {
        // 第一条对角线 (从左下到右上)
        for (i = [-segments/2:segments/2-1]) {
            // 距离中心的相对距离 (0 到 0.5)
            dist_ratio = abs(i) / (segments/2);

            // 当前段的高度：中心1mm，边缘0mm
            current_height = x_max_height * (1 - dist_ratio);

            translate([0, 0, thickness])
            rotate([0, 0, 45])
            translate([i * segment_length, -x_width/2, 0])
            cube([segment_length + 0.1, x_width, current_height]);
        }

        // 第二条对角线 (从左上到右下)
        for (i = [-segments/2:segments/2-1]) {
            dist_ratio = abs(i) / (segments/2);
            current_height = x_max_height * (1 - dist_ratio);

            translate([0, 0, thickness])
            rotate([0, 0, -45])
            translate([i * segment_length, -x_width/2, 0])
            cube([segment_length + 0.1, x_width, current_height]);
        }
    }
}
