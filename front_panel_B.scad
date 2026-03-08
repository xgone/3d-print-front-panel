// 机箱前面板 - B块 (65mm × 209mm × 2.8mm)
// 带卡扣拼接结构 (凹槽)

// 参数
width = 65;      // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// 卡扣参数 (与A块匹配)
tab_width = 15;      // 卡扣宽度 (mm)
tab_height = 3.5;    // 卡扣高度 (mm)
tab_depth = 1.2;     // 卡槽深度 (比凸扣深0.2mm，留间隙)
tab_count = 4;       // 卡扣数量
tab_spacing = (height - 20) / (tab_count + 1);  // 卡扣间距

// 圆角矩形模块
module rounded_rect(w, h, r, t) {
    hull() {
        translate([r, r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([w - r, r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([w - r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
    }
}

// 卡扣凹槽 (在左侧边缘)
module tab_slot(y_pos) {
    translate([-0.1, y_pos - 0.25, thickness/2 - tab_height/2])
    union() {
        // 主凹槽
        cube([tab_depth + 0.2, tab_width + 0.5, tab_height + 0.5]);

        // 卡勾容纳槽
        translate([tab_depth, 0, tab_height - 1.5])
        cube([2.5, tab_width + 0.5, 2]);
    }
}

// 定位凹槽
module alignment_slot() {
    translate([-0.1, 10 - 0.25, thickness/2 - 1.25])
    cube([2.5, 8.5, 3]);

    translate([-0.1, height - 18 - 0.25, thickness/2 - 1.25])
    cube([2.5, 8.5, 3]);
}

// 创建主体
difference() {
    // 前面板主体
    color("LightGray") {
        rounded_rect(width, height, corner_radius, thickness);
    }

    // 卡扣凹槽
    color("DarkGray") {
        for (i = [0:tab_count-1]) {
            tab_slot(10 + (i + 1) * tab_spacing);
        }
    }

    // 定位凹槽
    alignment_slot();
}

// 装配辅助 (打印时可注释掉)
// translate([-5, 0, 0])
// color("LightGray", 0.3)
// import("front_panel_A.stl");
