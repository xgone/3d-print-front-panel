// 机箱前面板 - B块 (65mm × 209mm × 2.8mm)
// 燕尾榫拼接 (凹槽)

// 参数
width = 65;      // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// 燕尾榫参数 (与A块匹配)
dovetail_width = 15;    // 燕尾宽度 (mm)
dovetail_depth = 6.2;   // 燕尾槽深度 (mm，比凸榫深0.2mm)
dovetail_angle = 45;    // 燕尾角度 (度)
dovetail_count = 4;     // 燕尾数量
tolerance = 0.35;        // 配合间隙 (mm)

// 计算燕尾实际尺寸
dovetail_offset = tan(dovetail_angle) * thickness;
dovetail_base_width = dovetail_width - 2 * dovetail_offset;

// 定位销参数
pin_radius = 1.8;       // 凹槽半径 (比凸销大0.3mm)
pin_height = 3;

// 圆角矩形模块
module rounded_rect(w, h, r, t) {
    hull() {
        translate([r, r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([w - r, r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([w - r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
    }
}

// 单个燕尾凹槽
module dovetail_slot(y_pos) {
    half_width = dovetail_width / 2 + tolerance/2;
    half_offset = dovetail_offset / 2;
    base_half_width = half_width - half_offset;

    translate([-0.1, y_pos, 0])
    rotate([0, -90, 0])
    linear_extrude(height = dovetail_depth + 0.2, convexity = 3)
    polygon(points = [
        [0, -half_width],
        [0, half_width],
        [thickness, base_half_width + tolerance/2],
        [thickness, -base_half_width - tolerance/2]
    ]);
}

// 定位凹槽
module alignment_slot(y_pos) {
    translate([-0.5, y_pos, 0])
    rotate([0, -90, 0])
    cylinder(h = pin_height, r = pin_radius, $fn = 16);
}

// 创建主体
difference() {
    // 前面板主体
    color("LightGray") {
        rounded_rect(width, height, corner_radius, thickness);
    }

    // 燕尾凹槽
    color("DarkGray") {
        for (i = [0:dovetail_count-1]) {
            dovetail_slot(30 + (i + 1) * ((height - 60) / (dovetail_count + 1)));
        }
    }

    // 定位凹槽
    alignment_slot(15);
    alignment_slot(height - 15);
}

// 装配预览 (打印时可注释掉)
// color("LightGray", 0.3)
// translate([-dovetail_depth, 0, 0])
// import("front_panel_A_dovetail.stl");
