<p align="center">
  <img src="https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png" width="80" alt="iOS 26 icon" />
</p>

<h1 align="center">iOS 26 Design System</h1>

<p align="center">
  <strong>最も包括的なオープンソース iOS 26 / iPadOS 26 デザインシステム</strong><br/>
  トークン、コンポーネント、テンプレート、セクション、ページ — Apple公式Figma Community Kitから抽出
</p>

<p align="center">
  <a href="./README.md">English</a> · <a href="./README.ko.md">한국어</a> · <a href="./README.zh.md">中文</a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/iOS_26-Liquid_Glass-007AFF?style=for-the-badge" alt="iOS 26" />
  <img src="https://img.shields.io/badge/フレームワーク-4種-34C759?style=for-the-badge" alt="4 frameworks" />
  <img src="https://img.shields.io/badge/コンポーネント-31個-FF9500?style=for-the-badge" alt="31 components" />
  <img src="https://img.shields.io/badge/ページ-48個-FF2D55?style=for-the-badge" alt="48 pages" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="MIT" />
</p>

---

## なぜ作ったのか

AppleはWWDC25で**Liquid Glass**と全く新しいデザイン言語を発表しました。デザイナーにはFigmaキットが提供されましたが、**開発者には何も提供されませんでした。**

このプロジェクトはそのギャップを埋めます。すべてのトークン、すべてのコンポーネント仕様、すべてのレイアウトルールを[公式Figma Community Kit](https://www.figma.com/community/file/pDmGXdYu2k8xlf1SQoU9PW)から抽出し、**4つのフレームワーク**で**今すぐ**使えるコードに変換しました。

## プロジェクト構成

```
ios26-design-system/
├── tokens/                    # デザイントークン（JSON）
│   ├── colors.json            # 79変数 × 4モード（Light/Dark/IC-Light/IC-Dark）
│   ├── typography.json        # 11スタイル × 4バリアント + Dynamic Type（7段階）
│   ├── materials.json         # Liquid Glass + Background Material + Scroll Edge
│   ├── spacing.json           # 8ptグリッド、角丸、Safe Area、コンポーネント寸法
│   └── animations.json        # Springカーブ、デュレーション、Liquid Glassモーフィング
│
├── components/specs/          # 31コンポーネント仕様
│   ├── button.md              # 148バリアント（Content Area + Liquid Glass）
│   ├── tab-bar.md             # iPhone + iPad、Liquid Glassインジケーター
│   ├── toolbar.md             # Top/Bottom/Sheet/iPadバリアント
│   ├── list-row.md            # Row、Swipe、Header、Index Bar
│   ├── sheet.md               # Detent、Liquid Glassグラバー
│   ├── alert.md               # 標準 + テキストフィールド
│   └── ...（25個追加）        # Figmaキットの全コンポーネント
│
├── templates/                 # 5つのレイアウト構成パターン
│   ├── standard-screen.md     # Status Bar + ナビゲーション + コンテンツ + Tab Bar
│   ├── sheet-overlay.md       # Detent 25/50/100%、キーボード回避
│   ├── navigation-stack.md    # Push/Pop、Large Title折りたたみ
│   ├── tab-bar-layout.md      # Liquid Glassインジケーターモーフィング
│   └── alert-modal.md         # 270ptカード、scale + fadeアニメーション
│
├── sections/                  # 5つの画面領域仕様
│   ├── status-bar.md          # 高さ：54pt（iPhone）/ 24pt（iPad）
│   ├── navigation-region.md   # Standard 44pt / Large Title 96pt
│   ├── content-region.md      # Safe Area、スクロール動作、セクション間隔
│   ├── overlay-region.md      # Sheet detent、Alert配置、ディミング
│   └── system-region.md       # Home Indicator、Dynamic Island、キーボード
│
├── pages/                     # 48の完成画面レシピ
│   ├── iphone-examples/       # 25のiPhone画面
│   └── ipad-examples/         # 23のiPad画面
│
├── svelte/                    # Svelte 5実装
├── svelte-inertia/            # Svelte 5 + Inertia.js + Rails実装
├── rails/                     # Rails 8 + Hotwire実装
└── flutter/                   # Flutter 3.x実装
```

## フレームワークサポート

| フレームワーク | トークン | コンポーネント | ステータス |
|--------------|---------|-------------|----------|
| **Svelte 5** | CSS Custom Properties | Runesモード（`$props()`） | 利用可能 |
| **Svelte 5 + Inertia.js** | CSS Custom Properties | Svelte 5 + Railsバックエンド | 利用可能 |
| **Rails 8 + Hotwire** | CSS + Stimulus | ERBパーシャル + Turbo | 利用可能 |
| **Flutter 3.x** | Dart定数 | Material + Cupertinoテーマ | 利用可能 |

## クイックスタート

### デザイントークン（フレームワーク非依存JSON）

すべてのトークンは`tokens/*.json`にあり、あらゆるビルドツールで利用可能です：

```json
// tokens/colors.json — Liquid Glassブルーアクセント
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
  完了
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
<%= render "shared/ios26/toolbar", title: "設定" %>
```

## コンポーネント仕様

各コンポーネント仕様に含まれる項目：

| 項目 | 説明 |
|------|------|
| **寸法** | 正確なwidth、height、padding（pt単位） |
| **バリアント** | 全軸：Size × Style × State × Mode |
| **トークンマッピング** | どのカラー/タイポグラフィトークンがどこに使われるか |
| **状態遷移** | Default → Pressed → Disabled |
| **アニメーション** | Springカーブ、デュレーション、イージング |
| **アクセシビリティ** | 最小44×44ptタッチターゲット、コントラスト比 |
| **フレームワーク別ノート** | 各フレームワーク実装ヒント |

### コンポーネント一覧（全31個）

| 分類 | コンポーネント |
|------|-------------|
| **コア** | Tab Bar、Toolbar、Button（148バリアント）、List Row |
| **フィードバック** | Alert、Sheet、Notifications、Progress Indicators |
| **コントロール** | Segmented Control、Toggle、Slider、Stepper、Text Field、Picker |
| **ナビゲーション** | Sidebar、Menu、Context Menu、Action Sheet、Popover |
| **システム** | Keyboard、Widget、App Icon、Face ID、Window、System UI |

## Liquid Glass

iOS 26を定義する視覚的特徴です。このデザインシステムは完全なLiquid Glass仕様を含みます：

```
Liquid Glass = Frosted blur + Refraction + Depth shadow + Light angle

パラメータ（Figma変数から抽出）：
├── lightAngle: -45°
├── opacity: 60%
├── refraction: 100%
├── frostRadius: 7px（small）/ 12px（medium）/ 14px（large）
├── depth: 16
├── splay: 6
└── shadowBlur: 40px（レイヤー）/ 80px（背景）
```

`animations.json`にはLiquid Glassモーフィングキーフレームが含まれています — 移動中に伸びる「水滴」タブインジケーターアニメーション：

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

## ソース

すべてのデータはApple公式の**iOS & iPadOS 26 Figma Community Kit**から抽出しました。

- **Figmaファイル**: [`pDmGXdYu2k8xlf1SQoU9PW`](https://www.figma.com/community/file/pDmGXdYu2k8xlf1SQoU9PW)
- **抽出方法**: Figma MCP + 手動検証
- **モード**: Light、Dark、Increased Contrast Light、Increased Contrast Dark

## アーキテクチャ

**Atomic Design**方法論に従います：

```
Tokens（原子）→ Components（分子）→ Templates（有機体）→ Sections → Pages
```

各レイヤーは下位レイヤーを参照します。コンポーネント仕様はトークン値を参照し、テンプレートはコンポーネントを組み合わせ、ページはテンプレートを使用します。

## コントリビューション

コントリビューションを歓迎します！ヘルプが必要な分野：

- **新フレームワーク**: React Native、SwiftUIラッパー、Jetpack Compose、Angular
- **ダークモード改善**: IC（高コントラスト）モードの検証
- **アクセシビリティ監査**: WCAG AAA準拠チェック
- **アニメーションデモ**: 各フレームワークでのLiquid Glassライブデモ
- **追加ページ**: 実際のアプリ画面レシピの追加

大きなPRを送る前に、まずissueを作成してディスカッションをお願いします。

## ロードマップ

- [ ] NPMパッケージ（`@ios26/tokens`）
- [ ] pub.dev Dartパッケージ
- [ ] Storybook / Histoireコンポーネントギャラリー
- [ ] インタラクティブLiquid Glassプレイグラウンド
- [ ] トークン同期Figmaプラグイン
- [ ] React Native実装
- [ ] SwiftUIラッパーコンポーネント

## ライセンス

MIT License。詳細は[LICENSE](./LICENSE)を参照。

デザイントークンはAppleの公開Figma Community Kitから派生しています。Apple、iOS、iPadOS、Liquid GlassはApple Inc.の商標です。

---

<p align="center">
  <a href="https://dcode-labs.com">Dcode Labs</a>制作<br/>
  <sub>お役に立てたら、スターで他の方にも見つけてもらえます。</sub>
</p>
