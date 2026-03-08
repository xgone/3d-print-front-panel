// 机箱前面板 - A块 (220mm × 209mm × 2.8mm)
// 带卡扣拼接结构 (凸扣)

// 参数
width = 220;     // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// 卡扣参数
tab_width = 15;      // 卡扣宽度 (mm)
tab_height = 3.5;    // 卡扣高度 (mm)
tab_depth = 1.0;     // 卡扣凸出深度 (mm)
tab_count = 4;       // 卡扣数量
tab_spacing = (height - 20) / (tab_count + 1);  // 卡扣间距

// X 图案参数 (原参数保持不变)
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

// 凸卡扣模块 (在右侧边缘)
module tab_protrusion(y_pos) {
    translate([width - 0.1, y_pos, thickness/2])
    union() {
        // 卡扣主体
        translate([0, 0, 0])
        cube([tab_depth, tab_width, tab_height]);

        // 导入斜坡 (便于卡入)
        translate([tab_depth, 0, 0])
        rotate([0, -45, 0])
        cube([1.5, tab_width, 1.5]);

        // 卡勾 (防止脱出)
        translate([tab_depth, 0, tab_height - 1])
        cube([1.5, tab_width, 1]);
    }
}

// 定位凸起 (防止上下滑动)
module alignment_protrusion() {
    translate([width - 0.1, 10, thickness/2])
    cube([2, 8, 2.5]);

    translate([width - 0.1, height - 18, thickness/2])
    cube([2, 8, 2.5]);
}

// 创建主体
difference() {
    union() {
        // 前面板主体
        color("LightGray") {
            rounded_rect(width, height, corner_radius, thickness);
        }

        // X 图案 (在面板中心)
        translate([width/2, height/2, 0])
        x_pattern_scaled();

        // 卡扣凸起
        color("DarkGray") {
            for (i = [0:tab_count-1]) {
                tab_protrusion(10 + (i + 1) * tab_spacing);
            }
        }

        // 定位凸起
        alignment_protrusion();
    }
}

// 缩放后的X图案 (适配A块尺寸)
module x_pattern_scaled() {
    segments = 30;
    segment_length = x_diagonal / segments;

    union() {
        // 第一条对角线
        for (i = [-segments/2:segments/2-1]) {
            dist_ratio = abs(i) / (segments/2);
            current_height = x_max_height * (1 - dist_ratio);

            translate([0, 0, thickness])
            rotate([0, 0, 45])
            translate([i * segment_length, -x_width/2, 0])
            cube([segment_length + 0.1, x_width, current_height]);
        }

        // 第二条对角线
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
