<p align="center">
  <img src="https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png" width="80" alt="iOS 26 icon" />
</p>

<h1 align="center">iOS 26 Design System</h1>

<p align="center">
  <strong>最全面的开源 iOS 26 / iPadOS 26 设计系统</strong><br/>
  令牌、组件、模板、分区、页面 — 从 Apple 官方 Figma Community Kit 提取
</p>

<p align="center">
  <a href="https://seunghan91.github.io/ios26-design-system/demo/">🔴 在线演示</a> ·
  <a href="./README.md">English</a> · <a href="./README.ko.md">한국어</a> · <a href="./README.ja.md">日本語</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/iOS_26-Liquid_Glass-007AFF?style=for-the-badge" alt="iOS 26" />
  <img src="https://img.shields.io/badge/框架-4个-34C759?style=for-the-badge" alt="4 frameworks" />
  <img src="https://img.shields.io/badge/组件-31个-FF9500?style=for-the-badge" alt="31 components" />
  <img src="https://img.shields.io/badge/页面-48个-FF2D55?style=for-the-badge" alt="48 pages" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="MIT" />
</p>

---

## 预览

> 以下每张截图均使用本项目的**真实设计令牌**渲染 — 非设计稿。

### 系统颜色

<p align="center">
  <img src="./docs/images/colors-light.png" width="720" alt="12 种系统颜色及十六进制值" />
</p>

### 字体排版

<p align="center">
  <img src="./docs/images/typography-light.png" width="720" alt="SF Pro 字体比例 — 11 种样式" />
</p>

### Liquid Glass & 材质

<p align="center">
  <img src="./docs/images/liquid-glass-light.png" width="720" alt="照片背景上的 Liquid Glass 效果" />
</p>

### 组件

<p align="center">
  <img src="./docs/images/components-light.png" width="720" alt="按钮、控件、列表、弹窗" />
</p>

### 间距 & 布局

<p align="center">
  <img src="./docs/images/spacing-light.png" width="720" alt="间距比例与圆角半径" />
</p>

### 动效 & 动画

<p align="center">
  <img src="./docs/images/animations-light.png" width="720" alt="Spring 动画曲线" />
</p>

---

## 为什么做这个项目

Apple 在 WWDC25 上发布了 **Liquid Glass** 和全新的设计语言。设计师拿到了 Figma 套件，**但开发者什么都没有。**

这个项目填补了这个空白。我们从[官方 Figma Community Kit](https://www.figma.com/community/file/1527721578857867021) 中提取了每一个令牌、每一个组件规格、每一个布局规则，并转化为可以在 **4 个框架**中**立即使用**的代码。

## 安装

```bash
# 设计令牌（CSS 变量、JS/TS、Dart）
npm install @ios26_design_system/tokens

# 框架专属包
npm install @ios26_design_system/svelte          # Svelte 5
npm install @ios26_design_system/rails           # Rails 8 + Hotwire
npm install @ios26_design_system/svelte-inertia  # Svelte 5 + Inertia.js

# 组件规格、页面方案（文档/AI 上下文用）
npm install @ios26_design_system/metadata
```

## 项目结构

```
ios26-design-system/                 # pnpm monorepo + Turborepo
├── packages/
│   ├── tokens/                      # @ios26_design_system/tokens
│   │   ├── src/                     # 源 JSON（5 个文件）
│   │   │   ├── colors.json          # 79 个变量 × 4 种模式
│   │   │   ├── typography.json      # 11 种样式 × 4 种变体 + Dynamic Type
│   │   │   ├── materials.json       # Liquid Glass + 背景材质
│   │   │   ├── spacing.json         # 8pt 网格、圆角、Safe Area
│   │   │   └── animations.json      # Spring 曲线、Liquid Glass 变形
│   │   ├── dist/                    # 构建产物（自动生成）
│   │   │   ├── css/                 # CSS 自定义属性
│   │   │   ├── index.js / .cjs     # JS/TS 模块
│   │   │   └── dart/                # Flutter Dart 类
│   │   └── build.js                 # 令牌转换管线
│   │
│   ├── svelte/                      # @ios26_design_system/svelte
│   ├── rails/                       # @ios26_design_system/rails
│   ├── svelte-inertia/              # @ios26_design_system/svelte-inertia
│   ├── flutter/                     # pub.dev: ios26_design
│   └── metadata/                    # @ios26_design_system/metadata
│       ├── components/specs/        # 31 个组件规格
│       ├── templates/               # 5 种布局组合模式
│       ├── sections/                # 5 个屏幕区域规格
│       └── pages/                   # 48 个页面方案（iPhone + iPad）
│
├── skills/                          # Claude Code / AI 技能
│   └── ios26-design.md              # 完整的令牌 + 组件参考
│
├── turbo.json                       # 构建编排
└── pnpm-workspace.yaml              # Monorepo 工作区
```

## 框架支持

| 包 | 框架 | 令牌 | 组件 | 状态 |
|---|------|------|------|------|
| `@ios26_design_system/tokens` | 通用 | JSON, CSS, JS/TS, Dart | — | `npm install @ios26_design_system/tokens` |
| `@ios26_design_system/svelte` | Svelte 5 | CSS Custom Properties | Runes mode | `npm install @ios26_design_system/svelte` |
| `@ios26_design_system/svelte-inertia` | Svelte 5 + Inertia.js | CSS Custom Properties | + Rails 布局 | `npm install @ios26_design_system/svelte-inertia` |
| `@ios26_design_system/rails` | Rails 8 + Hotwire | CSS + Stimulus | ERB 局部视图 | `npm install @ios26_design_system/rails` |
| `@ios26_design_system/metadata` | 通用 | — | 31 个规格 + 48 个页面 | `npm install @ios26_design_system/metadata` |
| `ios26_design` | Flutter 3.x | Dart 常量 | Material + Cupertino | pub.dev（即将推出） |

## 快速开始

### 设计令牌（任意框架）

```bash
npm install @ios26_design_system/tokens
```

```js
// ES Module — 导入令牌对象
import { colors, typography, materials } from '@ios26_design_system/tokens';

// CSS — 作为自定义属性导入
import '@ios26_design_system/tokens/css';              // 颜色
import '@ios26_design_system/tokens/css/typography';   // 字体排版类
import '@ios26_design_system/tokens/css/materials';    // Liquid Glass 工具类
import '@ios26_design_system/tokens/css/animations';   // Spring 曲线 + 持续时间

// 原始 JSON — 用于自定义构建管线
import colors from '@ios26_design_system/tokens/json/colors';
```

### Svelte 5

```bash
npm install @ios26_design_system/svelte
```

```svelte
<script>
  import '@ios26_design_system/svelte/tokens.css';
  import '@ios26_design_system/svelte/typography.css';
  import '@ios26_design_system/svelte/materials.css';
</script>

<button class="ios26-button ios26-liquid-glass-sm">完成</button>
```

### Flutter

```dart
// pubspec.yaml: ios26_design: ^1.0.0
import 'package:ios26_design/ios26_theme.dart';

MaterialApp(
  theme: iOS26Theme.light(),
  darkTheme: iOS26Theme.dark(),
);
```

### Rails 8

```erb
<%# Gemfile or importmap: pin "@ios26_design_system/rails" %>
<%= stylesheet_link_tag "ios26/tokens" %>
<%= render "shared/ios26/toolbar", title: "设置" %>
```

## 组件规格

每个组件规格包含：

| 项目 | 说明 |
|------|------|
| **尺寸** | 精确的 width、height、padding（pt 单位） |
| **变体** | 所有轴：Size × Style × State × Mode |
| **令牌映射** | 哪个颜色/字体令牌用在哪里 |
| **状态转换** | Default → Pressed → Disabled |
| **动画** | Spring 曲线、持续时间、缓动 |
| **无障碍** | 最小 44×44pt 触摸目标、对比度 |
| **框架备注** | 各框架实现提示 |

### 组件列表（共 31 个）

| 分类 | 组件 |
|------|------|
| **核心** | Tab Bar、Toolbar、Button（148 种变体）、List Row |
| **反馈** | Alert、Sheet、Notifications、Progress Indicators |
| **控件** | Segmented Control、Toggle、Slider、Stepper、Text Field、Picker |
| **导航** | Sidebar、Menu、Context Menu、Action Sheet、Popover |
| **系统** | Keyboard、Widget、App Icon、Face ID、Window、System UI |

## 页面方案

每个页面方案将一个完整的页面分解为其模板 + 组件的组合：

**iPhone（25 个页面）：** 主页信息流、设置、列表、Sheet 表单、Alert、通知、键盘、小组件、锁屏、控制中心等。

**iPad（23 个页面）：** Split View、侧边栏、Popover、多任务、窗口、Form Sheet 等。

## Liquid Glass

iOS 26 标志性的视觉特征。本设计系统包含完整的 Liquid Glass 规格：

```
Liquid Glass = 磨砂模糊 + 折射 + 深度阴影 + 光照角度

参数（从 Figma 变量提取）：
├── lightAngle: -45°
├── opacity: 60%
├── refraction: 100%
├── frostRadius: 7px（small）/ 12px（medium）/ 14px（large）
├── depth: 16
├── splay: 6
└── shadowBlur: 40px（图层）/ 80px（背景）
```

`animations.json` 包含 Liquid Glass 变形关键帧 — 移动时拉伸的"水滴"标签指示器动画：

```json
{
  "liquidGlass": {
    "tabIndicator": {
      "duration": 0.45,
      "spring": "snappy",
      "cssApprox": "cubic-bezier(0.34, 1.56, 0.64, 1.0)"
    }
  }
}
```

## 数据来源

所有数据从 Apple 官方 **iOS & iPadOS 26 Figma Community Kit** 提取。

- **Figma Community Kit**: [iOS & iPadOS 26](https://www.figma.com/community/file/1527721578857867021)
- **Figma File Key**: `pDmGXdYu2k8xlf1SQoU9PW`（Figma API / MCP 访问用）
- **提取方式**: Figma MCP + 手动验证
- **模式**: Light、Dark、Increased Contrast Light、Increased Contrast Dark

## 架构

遵循 **Atomic Design** 方法论：

```
Tokens（原子）→ Components（分子）→ Templates（有机体）→ Sections → Pages
```

每一层引用下一层。组件规格引用令牌值，模板组合组件，页面使用模板。

## AI / Vibe 编程集成

本设计系统附带 **Claude Code 技能**，可为 AI 编程助手提供完整的 iOS 26 令牌、组件尺寸、动画参数和布局模式知识。

### 安装技能

```bash
# 下载并安装
curl -LO https://github.com/seunghan91/ios26-design-system/raw/main/skills/ios26-design.skill
claude install-skill ios26-design.skill
```

或手动复制技能文件夹：

```bash
git clone https://github.com/seunghan91/ios26-design-system.git
cp -r ios26-design-system/skills/ios26-design ~/.claude/skills/
```

### 技能提供内容

| 文件 | 内容 |
|------|------|
| `SKILL.md` | 令牌速查、组件尺寸、Liquid Glass 参数、动画曲线 |
| `references/tokens.md` | 完整的 79 色 × 4 模式令牌表 |
| `references/components.md` | 31 个组件规格（高度、圆角、内边距、变体） |
| `references/layouts.md` | 5 个模板 + 48 个页面方案摘要 |
| `references/frameworks.md` | Svelte 5、Rails 8、Flutter、Inertia.js 代码示例 |

技能在检测到 iOS 26、Liquid Glass 或 `@ios26_design_system/*` 导入时自动激活。

### 其他 AI 工具

技能文件是纯 Markdown — 同样可以作为 **Cursor Rules**、**Windsurf**、**GitHub Copilot** 或其他 AI 编程助手的上下文：

```bash
# Cursor — 复制为 .cursorrules
cp skills/ios26-design/SKILL.md .cursorrules

# 任意 AI 工具 — 将技能文件夹作为上下文引用
```

## 贡献

欢迎贡献！需要帮助的领域：

- **新框架**: React Native、SwiftUI 封装、Jetpack Compose、Angular
- **暗色模式改进**: IC（高对比度）模式验证
- **无障碍审计**: WCAG AAA 合规检查
- **动画演示**: 各框架的 Liquid Glass 实时演示
- **更多页面**: 真实应用页面方案

提交大型 PR 之前，请先开 issue 讨论。

## 路线图

- [x] npm monorepo（`@ios26_design_system/tokens`、`@ios26_design_system/svelte`、`@ios26_design_system/rails`、...）
- [x] 令牌构建管线（JSON → CSS / JS / Dart）
- [x] Claude Code AI 技能
- [x] GitHub Actions CI/CD
- [ ] pub.dev Dart 包
- [x] [带暗色模式切换的在线演示](https://seunghan91.github.io/ios26-design-system/demo/)
- [ ] Storybook / Histoire 组件展示
- [ ] 交互式 Liquid Glass 演练场
- [ ] React Native 实现
- [ ] SwiftUI 封装组件
- [ ] 设计系统查询 MCP 服务器

## 许可证

MIT License。详见 [LICENSE](./LICENSE)。

设计令牌源自 Apple 公开的 Figma Community Kit。Apple、iOS、iPadOS、Liquid Glass 是 Apple Inc. 的商标。

---

<p align="center">
  <a href="https://dcode-labs.com">Dcode Labs</a> 出品<br/>
  <sub>如果对你有帮助，点个 Star 让更多人发现这个项目。</sub>
</p>
