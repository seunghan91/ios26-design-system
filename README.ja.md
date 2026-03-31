<p align="center">
  <img src="https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png" width="80" alt="iOS 26 icon" />
</p>

<h1 align="center">iOS 26 Design System</h1>

<p align="center">
  <strong>最も包括的なオープンソース iOS 26 / iPadOS 26 デザインシステム</strong><br/>
  トークン、コンポーネント、テンプレート、セクション、ページ — Apple公式Figma Community Kitから抽出
</p>

<p align="center">
  <a href="https://seunghan91.github.io/ios26-design-system/demo/">🔴 ライブデモ</a> ·
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

## プレビュー

> 以下のスクリーンショットはすべて、このパッケージの**実際のデザイントークン**でレンダリングされています — モックアップではありません。

### システムカラー

<p align="center">
  <img src="./docs/images/colors-light.png" width="720" alt="12色のシステムカラーとHEX値" />
</p>

### タイポグラフィ

<p align="center">
  <img src="./docs/images/typography-light.png" width="720" alt="SF Pro タイプスケール — 11スタイル" />
</p>

### Liquid Glass & マテリアル

<p align="center">
  <img src="./docs/images/liquid-glass-light.png" width="720" alt="写真背景上のLiquid Glass" />
</p>

### コンポーネント

<p align="center">
  <img src="./docs/images/components-light.png" width="720" alt="ボタン、コントロール、リスト、アラート" />
</p>

### スペーシング & レイアウト

<p align="center">
  <img src="./docs/images/spacing-light.png" width="720" alt="スペーシングスケールと角丸" />
</p>

### モーション & アニメーション

<p align="center">
  <img src="./docs/images/animations-light.png" width="720" alt="Springアニメーションカーブ" />
</p>

---

## なぜ作ったのか

AppleはWWDC25で**Liquid Glass**と全く新しいデザイン言語を発表しました。デザイナーにはFigmaキットが提供されましたが、**開発者には何も提供されませんでした。**

このプロジェクトはそのギャップを埋めます。すべてのトークン、すべてのコンポーネント仕様、すべてのレイアウトルールを[公式Figma Community Kit](https://www.figma.com/community/file/1527721578857867021)から抽出し、**4つのフレームワーク**で**今すぐ**使えるコードに変換しました。

## インストール

```bash
# デザイントークン（CSS変数、JS/TS、Dart）
npm install @ios26_design_system/tokens

# フレームワーク別パッケージ
npm install @ios26_design_system/svelte          # Svelte 5
npm install @ios26_design_system/rails           # Rails 8 + Hotwire
npm install @ios26_design_system/svelte-inertia  # Svelte 5 + Inertia.js

# コンポーネント仕様、ページレシピ（ドキュメント/AIコンテキスト用）
npm install @ios26_design_system/metadata
```

## プロジェクト構成

```
ios26-design-system/                 # pnpmモノレポ + Turborepo
├── packages/
│   ├── tokens/                      # @ios26_design_system/tokens
│   │   ├── src/                     # ソースJSON（5ファイル）
│   │   │   ├── colors.json          # 79変数 × 4モード
│   │   │   ├── typography.json      # 11スタイル × 4バリアント + Dynamic Type
│   │   │   ├── materials.json       # Liquid Glass + Background Materials
│   │   │   ├── spacing.json         # 8ptグリッド、角丸、Safe Area
│   │   │   └── animations.json      # Springカーブ、Liquid Glassモーフィング
│   │   ├── dist/                    # ビルド出力（自動生成）
│   │   │   ├── css/                 # CSSカスタムプロパティ
│   │   │   ├── index.js / .cjs     # JS/TSモジュール
│   │   │   └── dart/                # Flutter Dartクラス
│   │   └── build.js                 # トークン変換パイプライン
│   │
│   ├── svelte/                      # @ios26_design_system/svelte
│   ├── rails/                       # @ios26_design_system/rails
│   ├── svelte-inertia/              # @ios26_design_system/svelte-inertia
│   ├── flutter/                     # pub.dev: ios26_design
│   └── metadata/                    # @ios26_design_system/metadata
│       ├── components/specs/        # 31コンポーネント仕様
│       ├── templates/               # 5つのレイアウト構成パターン
│       ├── sections/                # 5つの画面領域仕様
│       └── pages/                   # 48ページレシピ（iPhone + iPad）
│
├── skills/                          # Claude Code / AIスキル
│   └── ios26-design.md              # トークン + コンポーネント完全リファレンス
│
├── turbo.json                       # ビルドオーケストレーション
└── pnpm-workspace.yaml              # モノレポワークスペース
```

## フレームワークサポート

| パッケージ | フレームワーク | トークン | コンポーネント | ステータス |
|-----------|--------------|---------|-------------|----------|
| `@ios26_design_system/tokens` | すべて | JSON, CSS, JS/TS, Dart | — | `npm install @ios26_design_system/tokens` |
| `@ios26_design_system/svelte` | Svelte 5 | CSS Custom Properties | Runesモード | `npm install @ios26_design_system/svelte` |
| `@ios26_design_system/svelte-inertia` | Svelte 5 + Inertia.js | CSS Custom Properties | + Railsレイアウト | `npm install @ios26_design_system/svelte-inertia` |
| `@ios26_design_system/rails` | Rails 8 + Hotwire | CSS + Stimulus | ERBパーシャル | `npm install @ios26_design_system/rails` |
| `@ios26_design_system/metadata` | すべて | — | 31仕様 + 48ページ | `npm install @ios26_design_system/metadata` |
| `ios26_design` | Flutter 3.x | Dart定数 | Material + Cupertino | pub.dev（近日公開） |

## クイックスタート

### トークン（任意のフレームワーク）

```bash
npm install @ios26_design_system/tokens
```

```js
// ESモジュール — トークンオブジェクトをインポート
import { colors, typography, materials } from '@ios26_design_system/tokens';

// CSS — カスタムプロパティとしてインポート
import '@ios26_design_system/tokens/css';              // カラー
import '@ios26_design_system/tokens/css/typography';   // タイポグラフィクラス
import '@ios26_design_system/tokens/css/materials';    // Liquid Glassユーティリティ
import '@ios26_design_system/tokens/css/animations';   // Springカーブ + デュレーション

// Raw JSON — カスタムビルドパイプライン用
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

<button class="ios26-button ios26-liquid-glass-sm">完了</button>
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
<%# GemfileまたはImportmap: pin "@ios26_design_system/rails" %>
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

## ページレシピ

各ページレシピは、完成画面をテンプレート + コンポーネントに分解します：

**iPhone（25画面）:** ホームフィード、設定、リスト、Sheetフォーム、Alert、通知、キーボード、ウィジェット、ロック画面、コントロールセンターなど。

**iPad（23画面）:** Split View、サイドバー、Popover、マルチタスキング、ウィンドウ、Form Sheetなど。

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

- **Figma Community Kit**: [iOS & iPadOS 26](https://www.figma.com/community/file/1527721578857867021)
- **Figma File Key**: `pDmGXdYu2k8xlf1SQoU9PW`（Figma API / MCPアクセス用）
- **抽出方法**: Figma MCP + 手動検証
- **モード**: Light、Dark、Increased Contrast Light、Increased Contrast Dark

## アーキテクチャ

**Atomic Design**方法論に従います：

```
Tokens（原子）→ Components（分子）→ Templates（有機体）→ Sections → Pages
```

各レイヤーは下位レイヤーを参照します。コンポーネント仕様はトークン値を参照し、テンプレートはコンポーネントを組み合わせ、ページはテンプレートを使用します。

## AI / バイブコーディング統合

このデザインシステムには**Claude Codeスキル**が同梱されており、AIアシスタントにiOS 26のトークン、コンポーネント寸法、アニメーションパラメータ、レイアウトパターンの完全な知識を提供します。

### スキルのインストール

```bash
# ダウンロードしてインストール
curl -LO https://github.com/seunghan91/ios26-design-system/raw/main/skills/ios26-design.skill
claude install-skill ios26-design.skill
```

または手動でスキルフォルダをコピー：

```bash
git clone https://github.com/seunghan91/ios26-design-system.git
cp -r ios26-design-system/skills/ios26-design ~/.claude/skills/
```

### スキルの提供内容

| ファイル | 内容 |
|---------|------|
| `SKILL.md` | トークンクイックリファレンス、コンポーネント寸法、Liquid Glassパラメータ、アニメーションカーブ |
| `references/tokens.md` | 79色 × 4モードの完全トークンテーブル |
| `references/components.md` | 31コンポーネント仕様（高さ、角丸、パディング、バリアント） |
| `references/layouts.md` | 5テンプレート + 48ページレシピの概要 |
| `references/frameworks.md` | Svelte 5、Rails 8、Flutter、Inertia.jsのコード例 |

スキルはiOS 26、Liquid Glass、または`@ios26_design_system/*`のインポートを検出すると自動的にアクティベートされます。

### 他のAIツール向け

スキルファイルはプレーンMarkdownです — **Cursor Rules**、**Windsurf**、**GitHub Copilot**、その他のAIコーディングアシスタントのコンテキストとしても利用できます：

```bash
# Cursor — .cursorrules としてコピー
cp skills/ios26-design/SKILL.md .cursorrules

# 任意のAIツール — スキルフォルダをコンテキストとして参照
```

## コントリビューション

コントリビューションを歓迎します！ヘルプが必要な分野：

- **新フレームワーク**: React Native、SwiftUIラッパー、Jetpack Compose、Angular
- **ダークモード改善**: IC（高コントラスト）モードの検証
- **アクセシビリティ監査**: WCAG AAA準拠チェック
- **アニメーションデモ**: 各フレームワークでのLiquid Glassライブデモ
- **追加ページ**: 実際のアプリ画面レシピの追加

大きなPRを送る前に、まずissueを作成してディスカッションをお願いします。

## ロードマップ

- [x] npmモノレポ（`@ios26_design_system/tokens`、`@ios26_design_system/svelte`、`@ios26_design_system/rails`、...）
- [x] トークンビルドパイプライン（JSON → CSS / JS / Dart）
- [x] Claude Code AIスキル
- [x] GitHub Actions CI/CD
- [ ] pub.dev Dartパッケージ
- [x] [ダークモードトグル付きライブデモ](https://seunghan91.github.io/ios26-design-system/demo/)
- [ ] Storybook / Histoireコンポーネントギャラリー
- [ ] インタラクティブLiquid Glassプレイグラウンド
- [ ] React Native実装
- [ ] SwiftUIラッパーコンポーネント
- [ ] デザインシステムクエリ用MCPサーバー

## ライセンス

MIT License。詳細は[LICENSE](./LICENSE)を参照。

デザイントークンはAppleの公開Figma Community Kitから派生しています。Apple、iOS、iPadOS、Liquid GlassはApple Inc.の商標です。

---

<p align="center">
  <a href="https://dcode-labs.com">Dcode Labs</a>制作<br/>
  <sub>お役に立てたら、スターで他の方にも見つけてもらえます。</sub>
</p>
