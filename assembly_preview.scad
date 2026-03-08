// 燕尾榫装配预览
// 展示A块和B块的拼接效果

// 参数
width_A = 220;
width_B = 65;
height = 209;
thickness = 2.8;

// 燕尾参数
dovetail_width = 15;
dovetail_depth = 6;
dovetail_angle = 45;
dovetail_offset = tan(dovetail_angle) * thickness;

// 显示A块（凸燕尾）
color("LightGray") {
    import("front_panel_A_dovetail.stl");
}

// 显示B块（凹燕尾）- 稍微偏移展示对齐
color("LightGray", 0.7) {
    translate([-dovetail_depth + 2, 0, 0])
    import("front_panel_B_dovetail.stl");
}

// 添加注释文本
translate([width_A/2, -20, 0])
color("Red")
text("A块 (凸燕尾)", size = 4, halign = "center", $fn = 32);

translate([-dovetail_depth + width_B/2, -20, 0])
color("Blue")
text("B块 (凹燕尾)", size = 4, halign = "center", $fn = 32);

// 燕尾榫说明
translate([width_A/2, height + 10, 0])
color("Black")
text("燕尾榫拼接 | 45度角度 | 6mm深度", size = 3, halign = "center", $fn = 32);
