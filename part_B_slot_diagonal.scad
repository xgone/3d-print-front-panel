// 滑槽拼接 - 对角线方向
// B部分：65mm × 209mm × 2.8mm
// 滑舌：右上向左下

// 参数
width = 65;      // 宽度 (mm)
height = 209;    // 高度 (mm)
thickness = 2.8; // 厚度 (mm)
corner_radius = 5;  // 倒角半径 (mm)

// 滑槽参数（与A部分匹配）
slot_depth = 3.3;     // 滑舌长度 (mm，比槽长0.3mm)
slot_height = 2.8;    // 滑舌高度 (mm，等于厚度）
slot_length = 180;    // 滑舌长度 (mm) - 对角线
slot_offset_x = 10;   // 滑舌起点X偏移
slot_offset_y = 20;   // 滑舌起点Y偏移
slot_angle = 30;       // 滑舌对角线角度 (度)
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
    // 面板主体
    color("LightGray") {
        rounded_rect_left_flat(width, height, corner_radius, thickness);
    }

    // 对角线滑舌（右上向左下）
    color("Blue") {
        translate([slot_offset_x, slot_offset_y, 0])
        rotate([0, 0, -slot_angle])
        cube([slot_depth, slot_length, slot_height]);
    }
}

// 装配预览（打印时可注释掉）
/*
color("LightGray", 0.3)
translate([-slot_depth, 0, 0])
import("part_A_slot_diagonal.stl");
*/
