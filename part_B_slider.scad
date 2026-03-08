// B部分：65mm × 209mm × 2.8mm
// 滑槽式拼接 - 滑舌
// 从上往下滑入A部分

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

// 定位销参数
pin_radius = 1.5;
pin_height = 2.8;

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

        // 滑舌（在左侧，从上往下滑入）
        color("Blue") {
            translate([0, slot_offset, 0])
            cube([slot_depth, slot_length, slot_height]);

            // 顶部定位销（防止滑出）
            translate([0, slot_offset, 0])
            cylinder(h = pin_height, r = pin_radius + tolerance, $fn = 16);
        }
    }
}

// 装配预览（打印时可注释掉）
/*
color("LightGray", 0.3)
translate([-slot_depth, 0, 0])
import("part_A_slider.stl");
*/
