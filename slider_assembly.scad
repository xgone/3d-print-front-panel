// 滑槽式拼接装配预览
// B部分滑舌从上往下滑入A部分滑槽

// 参数
width_A = 220;
width_B = 65;
height = 209;
thickness = 2.8;
slot_depth = 3;

// 显示A部分（滑槽）
color("LightGray") {
    import("part_A_slider.stl");
}

// 显示B部分（滑舌）- 滑入状态
color("LightGray") {
    translate([width_A - slot_depth, 0, 0])
    import("part_B_slider.stl");
}

// 添加标注
translate([width_A/2, -20, 0])
color("Red")
text("A部分 (滑槽)", size = 4, halign = "center", $fn = 32);

translate([width_A - slot_depth/2 + width_B/2, -20, 0])
color("Blue")
text("B部分 (滑舌)", size = 4, halign = "center", $fn = 32);

// 滑槽说明
translate([width_A/2, height + 15, 0])
color("Black")
text("滑槽式拼接 | 从上往下滑入", size = 3, halign = "center", $fn = 32);

// 滑动方向
translate([width_A/2, height/2, 0])
color("Green")
cylinder(h = 3, r = 0.5, $fn = 16);

translate([width_A/2, height/2 + 10, 0])
color("Green")
text("滑动方向 ↓", size = 2, halign = "center", $fn = 32);

// 参数
translate([width_A/2, height + 25, 0])
color("DarkGray")
text("滑槽: 3mm深 × 3mm高 × 200mm长 | 顶部定位销", size = 2, halign = "center", $fn = 32);

// 优点
translate([width_A/2, height + 35, 0])
color("Green")
text("✓ 简单直接，易于拆装", size = 2.5, halign = "center", $fn = 32);
