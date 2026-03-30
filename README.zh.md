<p align="center">
  <img src="https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png" width="80" alt="iOS 26 icon" />
</p>

<h1 align="center">iOS 26 Design System</h1>

<p align="center">
  <strong>最全面的开源 iOS 26 / iPadOS 26 设计系统</strong><br/>
  令牌、组件、模板、分区、页面 — 从 Apple 官方 Figma Community Kit 提取
</p>

<p align="center">
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

## 为什么做这个项目

Apple 在 WWDC25 上发布了 **Liquid Glass** 和全新的设计语言。设计师拿到了 Figma 套件，**但开发者什么都没有。**

这个项目填补了这个空白。我们从[官方 Figma Community Kit](https://www.figma.com/community/file/pDmGXdYu2k8xlf1SQoU9PW) 中提取了每一个令牌、每一个组件规格、每一个布局规则，并转化为可以在 **4 个框架**中**立即使用**的代码。

## 项目结构

```
ios26-design-system/
├── tokens/                    # 设计令牌（JSON）
│   ├── colors.json            # 79 个变量 × 4 种模式（Light/Dark/IC-Light/IC-Dark）
│   ├── typography.json        # 11 种样式 × 4 种变体 + Dynamic Type（7 级）
│   ├── materials.json         # Liquid Glass + 背景材质 + 滚动边缘
│   ├── spacing.json           # 8pt 网格、圆角、Safe Area、组件尺寸
│   └── animations.json        # Spring 曲线、持续时间、Liquid Glass 变形
│
├── components/specs/          # 31 个组件规格
│   ├── button.md              # 148 种变体（Content Area + Liquid Glass）
│   ├── tab-bar.md             # iPhone + iPad，Liquid Glass 指示器
│   ├── toolbar.md             # Top/Bottom/Sheet/iPad 变体
│   ├── list-row.md            # Row、Swipe、Header、Index Bar
│   ├── sheet.md               # Detent、Liquid Glass 抓手
│   ├── alert.md               # 标准 + 文本框
│   └── ...（还有 25 个）      # Figma 套件中的所有组件
│
├── templates/                 # 5 种布局组合模式
│   ├── standard-screen.md     # Status Bar + 导航 + 内容 + Tab Bar
│   ├── sheet-overlay.md       # Detent 25/50/100%，键盘避让
│   ├── navigation-stack.md    # Push/Pop，Large Title 折叠
│   ├── tab-bar-layout.md      # Liquid Glass 指示器变形
│   └── alert-modal.md         # 270pt 卡片，scale + fade 动画
│
├── sections/                  # 5 个屏幕区域规格
│   ├── status-bar.md          # 高度：54pt（iPhone）/ 24pt（iPad）
│   ├── navigation-region.md   # Standard 44pt / Large Title 96pt
│   ├── content-region.md      # Safe Area、滚动行为、分区间距
│   ├── overlay-region.md      # Sheet detent、Alert 定位、遮罩
│   └── system-region.md       # Home Indicator、灵动岛、键盘
│
├── pages/                     # 48 个完整页面方案
│   ├── iphone-examples/       # 25 个 iPhone 页面
│   └── ipad-examples/         # 23 个 iPad 页面
│
├── svelte/                    # Svelte 5 实现
├── svelte-inertia/            # Svelte 5 + Inertia.js + Rails 实现
├── rails/                     # Rails 8 + Hotwire 实现
└── flutter/                   # Flutter 3.x 实现
```

## 框架支持

| 框架 | 令牌 | 组件 | 状态 |
|------|------|------|------|
| **Svelte 5** | CSS Custom Properties | Runes 模式（`$props()`） | 可用 |
| **Svelte 5 + Inertia.js** | CSS Custom Properties | Svelte 5 + Rails 后端 | 可用 |
| **Rails 8 + Hotwire** | CSS + Stimulus | ERB 局部视图 + Turbo | 可用 |
| **Flutter 3.x** | Dart 常量 | Material + Cupertino 主题 | 可用 |

## 快速开始

### 设计令牌（框架无关 JSON）

所有令牌位于 `tokens/*.json`，可被任何构建工具使用：

```json
// tokens/colors.json — Liquid Glass 蓝色强调色
{
  "accents": {
    "blue": {
      "light": "#0088ff",
      "dark": "#0091ff",
      "icLight": "#1e6ef4",
      "icDark": "#5cb8ff"
    }
  }
}
```

### Svelte 5

```css
@import 'ios26/tokens.css';
@import 'ios26/typography.css';
@import 'ios26/materials.css';
```

```svelte
<button class="ios26-button ios26-liquid-glass-sm">
  完成
</button>
```

### Flutter

```dart
import 'theme/ios26/ios26.dart';

MaterialApp(
  theme: iOS26Theme.light(),
  darkTheme: iOS26Theme.dark(),
);
```

### Rails 8

```erb
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

- **Figma 文件**: [`pDmGXdYu2k8xlf1SQoU9PW`](https://www.figma.com/community/file/pDmGXdYu2k8xlf1SQoU9PW)
- **提取方式**: Figma MCP + 手动验证
- **模式**: Light、Dark、Increased Contrast Light、Increased Contrast Dark

## 架构

遵循 **Atomic Design** 方法论：

```
Tokens（原子）→ Components（分子）→ Templates（有机体）→ Sections → Pages
```

每一层引用下一层。组件规格引用令牌值，模板组合组件，页面使用模板。

## 贡献

欢迎贡献！需要帮助的领域：

- **新框架**: React Native、SwiftUI 封装、Jetpack Compose、Angular
- **暗色模式改进**: IC（高对比度）模式验证
- **无障碍审计**: WCAG AAA 合规检查
- **动画演示**: 各框架的 Liquid Glass 实时演示
- **更多页面**: 真实应用页面方案

提交大型 PR 之前，请先开 issue 讨论。

## 路线图

- [ ] NPM 包（`@ios26/tokens`）
- [ ] pub.dev Dart 包
- [ ] Storybook / Histoire 组件展示
- [ ] 交互式 Liquid Glass 演练场
- [ ] 令牌同步 Figma 插件
- [ ] React Native 实现
- [ ] SwiftUI 封装组件

## 许可证

MIT License。详见 [LICENSE](./LICENSE)。

设计令牌源自 Apple 公开的 Figma Community Kit。Apple、iOS、iPadOS、Liquid Glass 是 Apple Inc. 的商标。

---

<p align="center">
  <a href="https://dcode-labs.com">Dcode Labs</a> 出品<br/>
  <sub>如果对你有帮助，点个 Star 让更多人发现这个项目。</sub>
</p>
