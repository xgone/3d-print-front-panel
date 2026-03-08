# 机箱前面板 3D 模型

OpenSCAD 设计的机箱前面板 3D 打印模型，支持多种拼接工艺。

## 模型规格

**整体尺寸**
- 宽度：285mm
- 高度：209mm
- 厚度：2.8mm
- 四角倒角：5mm

**分割方案**
- A部分：220mm × 209mm × 2.8mm（左侧，含X图案）
- B部分：65mm × 209mm × 2.8mm（右侧）

## 文件说明

### 基础版本
- `front_panel_simple.scad` - 整体面板（无X图案）
- `part_A_220x209.scad` - A部分（220mm，含X图案）⭐ 当前版本
- `part_B_65x209.scad` - B部分（65mm）

### X图案参数
- 中心最大高度：1mm
- 边缘高度：0mm（渐变）
- 线条宽度：8mm
- 对角线长度：120mm

### 拼接工艺版本（参考）
- `front_panel_A_dovetail.scad` - 燕尾榫拼接（凸榫）
- `front_panel_B_dovetail.scad` - 燕尾榫拼接（凹槽）
- `front_panel_A.scad` - 卡扣拼接（凸扣）
- `front_panel_B.scad` - 卡扣拼接（凹槽）
- `front_panel.scad` - 完整面板（含X图案，未分割）

## 编译方法

```bash
# 编译为 STL
openscad part_A_220x209.scad -o part_A_220x209.stl --export-format binstl
openscad part_B_65x209.scad -o part_B_65x209.stl --export-format binstl

# 使用编译脚本
python3 /root/.openclaw/workspace/skills/public/openscad/scripts/compile_scad.py part_A_220x209.scad -o part_A_220x209.stl -q medium
```

## 打印设置

**推荐参数**
- 层高：0.2mm
- 外轮廓：3层
- 填充：15-20%
- 支撑：不需要
- 材料推荐：PLA 或 PETG

## 设计特点

- 接缝处采用90°直角拼接，拼接后看起来像一个整体
- A部分中心X图案，美观实用
- 仅A部分有X图案，B部分保持简洁
- 四角圆角设计，手感舒适

## 拼接工艺选择

当前版本为**基础分割版本**（无拼接结构），可根据需求选择：

1. **燕尾榫** - 优雅无缝，木工级质量
2. **卡扣** - 简单快速，可拆卸
3. **螺丝固定** - 最可靠，支持反复拆装
4. **胶水拼接** - 最简单，不可拆卸

需要添加拼接工艺时，参考 `front_panel_*_dovetail.scad` 和 `front_panel_A/B.scad` 的实现。

## 项目结构

```
3d-print/
├── part_A_220x209.scad       # A部分（当前版本）
├── part_B_65x209.scad        # B部分
├── front_panel_simple.scad   # 整体参考版
├── front_panel_A_dovetail.scad  # 燕尾榫参考
├── front_panel_B_dovetail.scad
├── front_panel_A.scad        # 卡扣参考
├── front_panel_B.scad
├── front_panel.scad          # 完整面板参考
└── README.md
```

## 下载 STL 文件

STL 文件已上传到 R2 存储桶，可通过以下链接下载：

- A部分：https://pub-e2f42181d1e643879b4cc1f8c765eacb.r2.dev/part_A_220x209.stl
- B部分：https://pub-e2f42181d1e643879b4cc1f8c765eacb.r2.dev/part_B_65x209.stl

## 许可证

MIT License
