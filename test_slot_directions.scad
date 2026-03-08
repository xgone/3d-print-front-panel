// 滑槽拼接 - 不同方向测试
// A部分：220mm × 209mm × 2.8mm

// 参数
width = 220;     // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

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

// 滑槽方向1：上下方向
module slot_up_down() {
    color("Red")
    translate([width - 3, 20, -0.1])
    cube([3.2, 50, 3]);  // 深度3mm，高度50mm（从上往下）
}

// 滑槽方向2：前后方向
module slot_front_back() {
    color("Blue")
    translate([width - 3, 20, -0.1])
    cube([3.2, 3, 50]);  // 深度3mm，长度50mm（从前向后）
}

// 滑槽方向3：对角线方向
module slot_diagonal() {
    color("Green")
    translate([width - 3, 20, -0.1])
    rotate([0, 0, 45])
    cube([3.2, 40, 3]);  // 深度3mm，对角线40mm
}

// 创建主体 - 测试不同方向
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

    // 测试：只显示一种方向的滑槽
    // 方向1：上下方向
    slot_up_down();
    
    // 方向2：前后方向（注释掉方向1测试方向2）
    // slot_front_back();
    
    // 方向3：对角线方向（注释掉其他测试）
    // slot_diagonal();
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
