// 机箱前面板 - A块 (220mm × 209mm × 2.8mm)
// 燕尾榫拼接 (凸榫)

// 参数
width = 220;     // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// 燕尾榫参数
dovetail_width = 15;    // 燕尾宽度 (mm)
dovetail_depth = 6;     // 燕尾深度 (mm)
dovetail_angle = 45;    // 燕尾角度 (度)
dovetail_count = 4;     // 燕尾数量
tolerance = 0.35;        // 配合间隙 (mm)

// 计算燕尾实际尺寸
dovetail_offset = tan(dovetail_angle) * thickness;
dovetail_base_width = dovetail_width - 2 * dovetail_offset;

// 定位销参数
pin_radius = 1.5;
pin_height = 2.5;

// X 图案参数
x_max_height = 1.0;
x_width = 8;
x_diagonal = 120;

// 圆角矩形模块
module rounded_rect(w, h, r, t) {
    hull() {
        translate([r, r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([w - r, r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([w - r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
    }
}

// 单个凸燕尾
module dovetail_protrusion(y_pos) {
    half_width = dovetail_width / 2;
    half_offset = dovetail_offset / 2;
    base_half_width = half_width - half_offset;

    translate([width, y_pos, 0])
    rotate([0, -90, 0])
    linear_extrude(height = dovetail_depth, convexity = 3)
    polygon(points = [
        [0, -half_width],              // 左上角
        [0, half_width],               // 右上角
        [thickness, base_half_width],  // 右下角（燕尾）
        [thickness, -base_half_width]  // 左下角（燕尾）
    ]);
}

// 定位凸销
module alignment_pin(y_pos) {
    translate([width, y_pos, 0])
    rotate([0, -90, 0])
    cylinder(h = 3, r = pin_radius, $fn = 16);
}

// 创建主体
difference() {
    union() {
        // 前面板主体
        color("LightGray") {
            rounded_rect(width, height, corner_radius, thickness);
        }

        // X 图案
        translate([width/2, height/2, 0])
        x_pattern_scaled();

        // 燕尾凸起
        color("DarkGray") {
            for (i = [0:dovetail_count-1]) {
                dovetail_protrusion(30 + (i + 1) * ((height - 60) / (dovetail_count + 1)));
            }
        }

        // 定位凸销
        alignment_pin(15);
        alignment_pin(height - 15);
    }
}

// 缩放后的X图案
module x_pattern_scaled() {
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
