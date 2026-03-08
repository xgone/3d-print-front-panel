// 简单面板拼接预览
// 展示A部分和B部分的拼接效果

// 显示A部分（左侧）
color("LightGray") {
    import("part_A_220x209.stl");
}

// 显示B部分（右侧）- 拼接位置
color("LightGray") {
    translate([220, 0, 0])
    import("part_B_65x209.stl");
}

// 添加标注
translate([110, -15, 0])
color("Red")
text("A部分 (220mm)", size = 5, halign = "center", $fn = 32);

translate([220 + 32.5, -15, 0])
color("Blue")
text("B部分 (65mm)", size = 5, halign = "center", $fn = 32);

// 拼接线标注
translate([220, height + 10, 0])
color("Black")
text("拼接线（接缝处无倒角）", size = 4, halign = "center", $fn = 32);

// 总宽度标注
translate([142.5, height + 25, 0])
color("Green")
text("总宽度: 285mm", size = 4, halign = "center", $fn = 32);
