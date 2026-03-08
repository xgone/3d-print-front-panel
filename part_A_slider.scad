// A部分：220mm × 209mm × 2.8mm
// 滑槽式拼接 - 滑槽
// 从上往下滑入固定

// 参数
width = 220;     // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// 滑槽参数
slot_depth = 3;       // 槽深度 (mm)
slot_height = 3;      // 槽高度 (mm)
slot_length = 200;    // 槽长度 (mm)
slot_offset = 10;      // 槽距离边缘 (mm)

// 定位销参数
pin_radius = 1.5;
pin_depth = 3;

// X 图案参数
x_max_height = 1.0;
x_width = 8;
x_diagonal = 120;

// 圆角矩形模块（右侧不倒角）
module rounded_rect_right_flat(w, h, r, t) {
    hull() {
        translate([r, r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([w, h, 0]) cylinder(h = t, r = 0.01, $fn = 4);
        translate([w, 0, 0]) cylinder(h = t, r = 0.01, $fn = 4);
    }
}

// 创建主体
difference() {
    union() {
        // 面板主体
        color("LightGray") {
            rounded_rect_right_flat(width, height, corner_radius, thickness);
        }

        // X 图案
        color("DarkGray") {
            translate([width/2, height/2, 0])
            x_pattern();
        }
    }

    // 滑槽（在右侧，从上往下）
    color("Red") {
        // 主滑槽
        translate([width - slot_depth, slot_offset, -0.1])
        cube([slot_depth + 0.2, slot_length, slot_height + 0.2]);

        // 顶部定位孔（防止滑出）
        translate([width - slot_depth - 0.1, slot_offset, thickness/2])
        rotate([0, -90, 0])
        cylinder(h = slot_depth + 0.2, r = pin_radius, $fn = 16);
    }
}

// X 图案模块
module x_pattern() {
    segments = 30;
    segment_length = x_diagonal / segments;

    union() {
        for (i = [-segments/2:segments/2-1]) {
            dist_ratio = abs(i) / (segments/2);
            current_height = x_max_height * (1 - dist_ratio);

            translate([0, 0, thickness])
            rotate([0, 0, 45])
            translate([i * segment_length, -x_width/2, 0])
            cube([segment_length + 0.1, x_width, current_height]);
        }

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
