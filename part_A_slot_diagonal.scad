// 滑槽拼接 - 对角线方向
// A部分：220mm × 209mm × 2.8mm
// 滑槽：右上向左下

// 参数
width = 220;     // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// 滑槽参数
slot_depth = 3;       // 槽深度 (mm)
slot_height = 3;      // 槽高度 (mm)
slot_length = 180;    // 槽长度 (mm) - 对角线
slot_offset_x = 10;   // 槽起点X偏移
slot_offset_y = 20;   // 槽起点Y偏移
slot_angle = 30;       // 槽对角线角度（度）

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

    // 对角线滑槽（右上向左下）
    color("Red") {
        translate([width - 0.1, slot_offset_y, -0.1])
        rotate([0, 0, -slot_angle])
        translate([slot_depth, 0, 0])
        cube([slot_depth + 0.2, slot_length, slot_height + 0.2]);
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
