// 滑槽拼接 - 方向2：前后方向
// B部分：65mm × 209mm × 2.8mm
// 滑舌从前向后

// 参数
width = 65;      // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// 滑槽参数（与A部分匹配）
slot_depth = 3.3;     // 滑舌长度 (mm，比槽长0.3mm)
slot_height = 2.8;    // 滑舌高度 (mm，等于厚度）
slot_length = 200;    // 滑舌长度 (mm)
slot_offset = 10;      // 滑舌距离边缘 (mm)
tolerance = 0.3;       // 配合公差

// 圆角矩形模块（左侧不倒角）
module rounded_rect_left_flat(w, h, r, t) {
    hull() {
        translate([0, 0, 0]) cylinder(h = t, r = 0.01, $fn = 4);
        translate([0, h, 0]) cylinder(h = t, r = 0.01, $fn = 4);
        translate([w - r, h - r, 0]) cylinder(h = t, r = r, $fn = 32);
        translate([w - r, r, 0]) cylinder(h = t, r = r, $fn = 32);
    }
}

// 创建主体
difference() {
    union() {
        // 面板主体
        color("LightGray") {
            rounded_rect_left_flat(width, height, corner_radius, thickness);
        }

        // 滑舌（在左侧，前后方向）
        color("Red") {
            translate([0, -0.1, slot_offset])
            cube([slot_depth, 3, slot_length]);
        }
    }
}

// 装配预览（打印时可注释掉）
/*
color("LightGray", 0.3)
translate([-slot_depth, 0, 0])
import("part_A_slot_frontback.stl");
*/
