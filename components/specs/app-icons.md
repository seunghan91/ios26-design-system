# App Icons — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="2402:17543")`

---

## 1. 개요

iOS 26 App Icon은 앱의 첫인상이자 홈 화면의 핵심 시각 요소다. iOS 26에서 도입된 가장 큰 변화는 **라이트 / 다크 / 틴트 3가지 어피어런스 모드 아이콘 지원**이다. 시스템 다크 모드, 라이트 모드, 그리고 사용자 지정 틴트 컬러에 각각 대응하는 아이콘을 App Store Connect에 제출할 수 있다.

| 항목 | 값 |
|------|-----|
| **Figma Node** | `2402:17543` — COMPONENT_SET, 2 variants |
| **섹션 그룹** | App Icons |
| **신규 특징 (iOS 26)** | Light / Dark / Tint 모드 아이콘 지원 |
| **코너 형태** | Squircle (Superellipse, iOS 시스템 자동 클리핑) |
| **알파 채널** | 금지 (App Store Connect 제출 규칙) |

> iOS 26 이전에는 라이트 모드 아이콘 1개만 제출하면 됐지만, iOS 26부터 다크/틴트 아이콘을 별도로 제출하지 않으면 시스템이 라이트 아이콘을 자동으로 탈채색(desaturate)하여 사용한다. 정교한 브랜딩을 원한다면 세 가지 모두 직접 제작하는 것이 권장된다.

---

## 2. 치수 (Sizes)

### iPhone — 전체 크기 목록

| 용도 | pt (포인트) | @1x px | @2x px | @3x px |
|------|------------|--------|--------|--------|
| App Store 제출 | — | — | — | **1024×1024** |
| 홈 화면 | 60×60pt | 60×60 | 120×120 | **180×180** |
| Spotlight 검색 | 40×40pt | 40×40 | 80×80 | 120×120 |
| 설정 앱 | 29×29pt | 29×29 | 58×58 | 87×87 |
| 알림 | 20×20pt | 20×20 | 40×40 | 60×60 |

> 실제 렌더링 크기는 기기 픽셀 밀도(PPI)에 따라 @2x(Retina) 또는 @3x(Super Retina XDR)가 사용된다. iPhone 6s 이후 모든 기기는 @3x 이상.

### iPad — 전체 크기 목록

| 용도 | pt | @1x px | @2x px |
|------|----|--------|--------|
| 홈 화면 | 76×76pt | 76×76 | 152×152 |
| 홈 화면 (iPad Pro) | 83.5×83.5pt | — | **167×167** |
| Spotlight | 40×40pt | 40×40 | 80×80 |
| 설정 앱 | 29×29pt | 29×29 | 58×58 |
| 알림 | 20×20pt | 20×20 | 40×40 |

### Mac — 전체 크기 목록

| 크기 | @1x px | @2x px |
|------|--------|--------|
| 16×16pt | 16×16 | 32×32 |
| 32×32pt | 32×32 | 64×64 |
| 128×128pt | 128×128 | 256×256 |
| 256×256pt | 256×256 | 512×512 |
| 512×512pt | 512×512 | **1024×1024** |

> Mac 아이콘은 macOS가 자체적으로 라운드 코너를 적용하지 않는다. 디자이너가 직접 라운딩을 포함한 아이콘을 제작해야 한다.

### watchOS — 전체 크기 목록

| 크기 | 용도 |
|------|------|
| 1024×1024px | App Store |
| 48×48pt @2x | 38mm |
| 55×55pt @2x | 42mm |
| 58×58pt @2x | 41mm (SE 2/3) |
| 66×66pt @2x | 44mm |
| 77×77pt @2x | 45mm / Ultra |
| 100×100pt @2x | 49mm (Ultra 2) |
| 87×87pt @2x | 설정 앱 (모든 크기) |

### tvOS — 전체 크기 목록

| 용도 | pt | @1x px | @2x px |
|------|----|--------|--------|
| 홈 화면 | 400×240pt | 400×240 | 800×480 |
| 상위 선반 | 1920×720pt | — | — |
| App Store | — | — | 1280×768 |

> tvOS 아이콘은 레이어드 구조(최대 5레이어)를 지원한다. 시차 효과(parallax)를 위해 전경/배경을 별도 레이어로 제작해야 한다.

---

## 3. Variants (iOS 26 신규)

iOS 26에서는 동일한 아이콘을 **3가지 어피어런스 모드**로 제공한다.

| Variant | 배경 | 텍스트/아이콘 색상 | 적용 조건 |
|---------|------|------------------|----------|
| **Light** | 밝은 배경 | 어두운 색상 | 시스템 라이트 모드 |
| **Dark** | 어두운 배경 (권장: #1C1C1E 계열) | 밝은 색상 | 시스템 다크 모드 |
| **Tint** | 반투명 배경 (시스템 틴트 적용) | 시스템 틴트 컬러 기반 | 사용자 커스텀 틴트 설정 |

### Tint 모드 작동 방식

Tint 모드에서는 시스템이 아이콘의 **Tint 레이어**에 사용자가 선택한 틴트 컬러(예: 파란색, 빨간색)를 오버레이한다.

- Tint 아이콘은 **모노크로마틱(단색)** 또는 **Tint-safe 디자인**이어야 한다.
- 배경색을 지정하지 않으면 시스템 틴트 컬러가 배경으로 사용된다.
- 권장: 흰색 계열 전경 요소 + 투명 배경 (시스템이 틴트 적용)

### Dark 모드 디자인 원칙

```
Light: 밝은 배경 (#FFFFFF ~ #F2F2F7) + 채도 높은 아이콘 그래픽
Dark:  어두운 배경 (#1C1C1E ~ #2C2C2E) + 채도 조정된 동일 그래픽 (살짝 밝게)
Tint:  투명 배경 + 흰색 모노 그래픽 (시스템이 배경색/틴트 적용)
```

---

## 4. 색상 / Material

### 배경색 규칙

| 규칙 | 설명 |
|------|------|
| **알파 채널 금지** | App Store Connect는 알파(투명도) 채널이 있는 이미지를 거부한다. 반드시 RGB(불투명) PNG로 내보내야 한다. |
| **P3 색공간 권장** | Display P3 색공간으로 제작 시 더 넓은 색역 활용 가능. sRGB도 허용되지만 P3 권장. |
| **배경 단색 처리** | 투명 배경처럼 보이는 부분도 실제로는 #FFFFFF 또는 배경색으로 채워야 한다. |

### 안전한 배경색 (Dark 모드 권장)

| 용도 | 색상 토큰 | Hex |
|------|-----------|-----|
| Dark 모드 배경 | `colors.system.background.primary.dark` | `#000000` |
| Dark 모드 배경 (카드) | `colors.system.background.secondary.dark` | `#1C1C1E` |
| Dark 모드 배경 (레이어드) | `colors.system.background.tertiary.dark` | `#2C2C2E` |

### 코너 형태: Squircle (Superellipse)

iOS 아이콘 코너는 일반 `border-radius`(원형 아크)가 아닌 **Superellipse(초타원)** 수학 공식으로 클리핑된다.

```
방정식: |x/a|^n + |y/b|^n = 1, 여기서 n ≈ 5 (iOS squircle)
```

- iOS 시스템이 자동으로 클리핑하므로, **아이콘 원본 파일은 코너 클리핑 없이 정사각형**으로 제작한다.
- Figma에서는 "iOS App Icon" 클리핑 마스크를 사용하거나, SF Symbols Composer 사용을 권장.
- 아이콘 콘텐츠를 안전 영역(safe area) 내에 배치: 전체 크기의 약 **80% 이내**.

```
1024×1024 기준 안전 영역:
  여백: 각 방향 약 90px (총 여백 180px)
  콘텐츠 영역: 약 844×844px
```

---

## 5. 애니메이션

앱 아이콘 자체는 정적 이미지다. 단, 다음 상황에서 시스템 애니메이션이 적용된다.

| 상황 | 애니메이션 | 설명 |
|------|-----------|------|
| 앱 런치 | Scale + Fade | 아이콘에서 앱 화면으로 확대 전환 |
| 홈 화면 흔들기 모드 | Wobble (±6°, 1.5Hz) | 시스템 제공, 커스터마이즈 불가 |
| Spotlight 검색 | Fade in + scale | 검색 결과 진입 시 |
| 위젯 추가 시 | Spring scale | 드래그 앤 드롭 피드백 |

---

## 6. Accessibility (접근성)

| 항목 | 규칙 |
|------|------|
| **최소 터치 타겟** | 홈 화면 아이콘은 시스템이 60×60pt 이상 터치 영역 보장. 별도 구현 불필요. |
| **다크 모드 지원** | Dark 아이콘을 제공하지 않으면 시스템이 라이트 아이콘을 자동 탈채색. 브랜드 일관성 저하 가능. |
| **고대비 모드** | "Increase Contrast" 설정 시 아이콘 대비가 강조되지 않음. 아이콘 자체의 대비 확보 필요. |
| **VoiceOver** | 앱 이름이 자동으로 레이블로 사용됨. 별도 설정 불필요. |
| **색맹 접근성** | 색상에만 의존하는 아이콘 디자인 지양. 형태로도 구분 가능하도록 설계. |

---

## 7. 프레임워크별 구현

### UIKit / SwiftUI — Xcode Asset Catalog 구조

Xcode의 `Assets.xcassets` 내에 `AppIcon` 어셋 세트를 구성한다.

#### Xcode Asset Catalog 폴더 구조

```
Assets.xcassets/
└── AppIcon.appiconset/
    ├── Contents.json          ← 크기/배율/용도 매핑 정의
    ├── icon-1024.png          ← App Store (1024×1024, 알파 없음)
    ├── icon-60@2x.png         ← iPhone 홈 화면 @2x (120×120)
    ├── icon-60@3x.png         ← iPhone 홈 화면 @3x (180×180)
    ├── icon-40@2x.png         ← Spotlight @2x (80×80)
    ├── icon-40@3x.png         ← Spotlight @3x (120×120)
    ├── icon-29@2x.png         ← 설정 앱 @2x (58×58)
    ├── icon-29@3x.png         ← 설정 앱 @3x (87×87)
    ├── icon-20@2x.png         ← 알림 @2x (40×40)
    └── icon-20@3x.png         ← 알림 @3x (60×60)
```

#### iOS 26 다크/틴트 지원 — Contents.json 예시

```json
{
  "images": [
    {
      "filename": "icon-1024.png",
      "idiom": "universal",
      "platform": "ios",
      "size": "1024x1024"
    },
    {
      "appearances": [
        { "appearance": "luminosity", "value": "light" }
      ],
      "filename": "icon-60@3x-light.png",
      "idiom": "universal",
      "platform": "ios",
      "scale": "3x",
      "size": "60x60"
    },
    {
      "appearances": [
        { "appearance": "luminosity", "value": "dark" }
      ],
      "filename": "icon-60@3x-dark.png",
      "idiom": "universal",
      "platform": "ios",
      "scale": "3x",
      "size": "60x60"
    },
    {
      "appearances": [
        { "appearance": "luminosity", "value": "tinted" }
      ],
      "filename": "icon-60@3x-tinted.png",
      "idiom": "universal",
      "platform": "ios",
      "scale": "3x",
      "size": "60x60"
    }
  ],
  "info": {
    "author": "xcode",
    "version": 1
  }
}
```

> `"value": "tinted"` 는 iOS 18+에서 도입되었으며, iOS 26에서도 동일하게 사용된다.

#### Xcode 설정 (Info.plist)

```xml
<!-- iOS 26 App Icon 모드 지원 선언 -->
<key>CFBundleIcons</key>
<dict>
    <key>CFBundlePrimaryIcon</key>
    <dict>
        <key>CFBundleIconFiles</key>
        <array>
            <string>AppIcon</string>
        </array>
        <key>UIPrerenderedIcon</key>
        <false/>
    </dict>
</dict>
```

---

### SwiftUI — 런타임 아이콘 변경 (Alternative Icons)

```swift
import UIKit

// 대체 아이콘으로 변경 (설정 앱 내 옵션으로 제공하는 경우)
func changeAppIcon(to iconName: String?) {
    guard UIApplication.shared.supportsAlternateIcons else {
        print("대체 아이콘을 지원하지 않는 기기입니다.")
        return
    }

    UIApplication.shared.setAlternateIconName(iconName) { error in
        if let error = error {
            print("아이콘 변경 실패: \(error.localizedDescription)")
        } else {
            print("아이콘 변경 완료: \(iconName ?? "기본 아이콘")")
        }
    }
}

// 사용 예시
changeAppIcon(to: "AppIcon-Dark")   // 다크 테마 대체 아이콘
changeAppIcon(to: nil)              // 기본 아이콘으로 복원
```

#### Info.plist — 대체 아이콘 선언

```xml
<key>CFBundleIcons</key>
<dict>
    <key>CFBundlePrimaryIcon</key>
    <dict>
        <key>CFBundleIconFiles</key>
        <array><string>AppIcon</string></array>
    </dict>
    <key>CFBundleAlternateIcons</key>
    <dict>
        <key>AppIcon-Dark</key>
        <dict>
            <key>CFBundleIconFiles</key>
            <array><string>AppIcon-Dark</string></array>
            <key>UIPrerenderedIcon</key>
            <false/>
        </dict>
        <key>AppIcon-Tint</key>
        <dict>
            <key>CFBundleIconFiles</key>
            <array><string>AppIcon-Tint</string></array>
            <key>UIPrerenderedIcon</key>
            <false/>
        </dict>
    </dict>
</dict>
```

---

### Flutter — pubspec.yaml 설정

Flutter에서는 `flutter_launcher_icons` 패키지를 사용하여 모든 플랫폼 아이콘을 자동 생성한다.

#### pubspec.yaml

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.14.1

flutter_launcher_icons:
  # iOS 설정
  ios: true
  image_path_ios: "assets/icons/app_icon_1024.png"

  # iOS 26 다크/틴트 지원 (flutter_launcher_icons 0.14+)
  ios_dark_icon_image_path: "assets/icons/app_icon_dark_1024.png"
  ios_tinted_icon_image_path: "assets/icons/app_icon_tinted_1024.png"

  # Android 설정
  android: true
  image_path_android: "assets/icons/app_icon_1024.png"
  adaptive_icon_background: "#FFFFFF"
  adaptive_icon_foreground: "assets/icons/app_icon_foreground.png"

  # 아이콘 배경색 (iOS 알파 채널 방지)
  remove_alpha_ios: true
  background_color_ios: "#FFFFFF"
```

#### 아이콘 생성 명령어

```bash
# 아이콘 자동 생성 (모든 크기 일괄 생성)
dart run flutter_launcher_icons

# 특정 플랫폼만
dart run flutter_launcher_icons -f flutter_launcher_icons_ios.yaml
```

#### 생성되는 파일 위치

```
ios/Runner/Assets.xcassets/AppIcon.appiconset/
  ├── Icon-App-20x20@1x.png     (20×20)
  ├── Icon-App-20x20@2x.png     (40×40)
  ├── Icon-App-20x20@3x.png     (60×60)
  ├── Icon-App-29x29@1x.png     (29×29)
  ├── Icon-App-29x29@2x.png     (58×58)
  ├── Icon-App-29x29@3x.png     (87×87)
  ├── Icon-App-40x40@1x.png     (40×40)
  ├── Icon-App-40x40@2x.png     (80×80)
  ├── Icon-App-40x40@3x.png     (120×120)
  ├── Icon-App-60x60@2x.png     (120×120)
  ├── Icon-App-60x60@3x.png     (180×180)
  ├── Icon-App-76x76@1x.png     (76×76)   ← iPad
  ├── Icon-App-76x76@2x.png     (152×152) ← iPad
  ├── Icon-App-83.5x83.5@2x.png (167×167) ← iPad Pro
  └── Icon-App-1024x1024@1x.png (1024×1024) ← App Store
```

---

### Svelte (웹 근사치) — PWA 아이콘 설정

웹 앱의 경우 PWA manifest.json에서 여러 크기의 아이콘을 선언한다.

#### manifest.json

```json
{
  "name": "My App",
  "short_name": "MyApp",
  "icons": [
    {
      "src": "/icons/icon-192.png",
      "sizes": "192x192",
      "type": "image/png",
      "purpose": "any"
    },
    {
      "src": "/icons/icon-512.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "any maskable"
    }
  ],
  "theme_color": "#000000",
  "background_color": "#ffffff"
}
```

#### SvelteKit — 미디어쿼리 기반 다크 아이콘 (Safari 마스크 아이콘)

```html
<!-- app.html -->
<link rel="apple-touch-icon" href="/icons/icon-180.png" />
<!-- Safari 마스크 아이콘 (다크 모드 대응) -->
<link rel="mask-icon" href="/icons/icon-mask.svg" color="#000000" />

<!-- 다크 모드용 파비콘 (Chrome 지원) -->
<link rel="icon" href="/icons/favicon-dark.png"
      media="(prefers-color-scheme: dark)" />
<link rel="icon" href="/icons/favicon-light.png"
      media="(prefers-color-scheme: light)" />
```

---

## 8. 제출 요건 — App Store Connect

### 필수 조건

| 항목 | 요건 |
|------|------|
| **파일 포맷** | PNG (JPG 불가) |
| **색상 공간** | sRGB 또는 Display P3 |
| **알파 채널** | **금지** — 투명도 포함 시 업로드 거부 |
| **크기** | 1024×1024px (정확히) |
| **레이어** | 단일 레이어 병합 필수 |
| **해상도** | 72 DPI 이상 (권장: 72 DPI) |
| **파일명** | 영문/숫자/하이픈/언더스코어만 허용 |

### iOS 26 신규 제출 요건

| 항목 | 요건 |
|------|------|
| **다크 아이콘** | 별도 1024×1024px PNG 업로드 (선택사항, 미제출 시 자동 탈채색) |
| **틴트 아이콘** | 별도 1024×1024px PNG 업로드 (선택사항, 모노크로마틱 권장) |
| **Xcode 지원 버전** | Xcode 16+ 권장 (iOS 18+ SDK 포함) |

### Figma에서 내보내기 설정

```
내보내기 방법:
1. 1024×1024px 프레임에서 → Export as PNG
2. 색상 공간: Display P3 (Figma 설정: Preferences > Color Profile > Display P3)
3. 알파 없이 내보내기: 배경 레이어를 반드시 포함
4. 파일명: AppIcon-Light-1024.png, AppIcon-Dark-1024.png, AppIcon-Tint-1024.png

Figma Export 패널 설정:
  Format: PNG
  Size: 1x (1024px 기준)
  Include "Background Color": ON
```

---

## 9. 생성 도구

### 권장 도구

| 도구 | 용도 | 특징 |
|------|------|------|
| **Figma** | 벡터 아이콘 디자인 | iOS 26 다크/틴트 프리뷰 플러그인 존재 |
| **SF Symbols 6** (macOS 앱) | SF Symbol 기반 아이콘 생성 | iOS 26 심볼 최신 버전 포함 |
| **Sketch** | 벡터 아이콘 디자인 | iOS 템플릿 제공 |
| **Pixelmator Pro** | 래스터 후보정 | P3 색공간 지원 |
| **makeAppIcon.com** | 온라인 크기 자동 생성 | 1024px 1개 업로드 → 전체 크기 패키지 다운로드 |
| **IconKitchen** | Android/iOS 동시 생성 | Adaptive Icon 지원 |

### Figma 플러그인 권장

| 플러그인 | 기능 |
|---------|------|
| **App Icon Generator** | 1개 아이콘 → 전체 크기 자동 생성 |
| **iOS 26 Icon Preview** | 라이트/다크/틴트 홈 화면 미리보기 |
| **Stark** | WCAG 색상 대비 검사 |

### SF Symbols 기반 아이콘 — SwiftUI 코드

```swift
// SF Symbol을 앱 아이콘 미리보기에 사용하는 경우
// (실제 아이콘 파일은 Assets.xcassets에 PNG로 등록해야 함)
Image(systemName: "star.fill")
    .resizable()
    .scaledToFit()
    .symbolRenderingMode(.palette)
    .foregroundStyle(.white, .blue)
    .frame(width: 60, height: 60)
    .background(
        RoundedRectangle(cornerRadius: 13.5) // 60pt 기준 squircle 근사
            .fill(.blue)
    )
```

---

## 10. 자주 발생하는 문제 및 해결책

| 문제 | 원인 | 해결 |
|------|------|------|
| App Store Connect 업로드 실패 | 알파 채널 포함 | Photoshop: 이미지 > 병합 후 내보내기. Figma: 배경 레이어 추가 후 내보내기 |
| 다크 모드에서 아이콘이 탈채색됨 | 다크 아이콘 미제출 | Xcode Assets.xcassets에 Dark appearance 아이콘 추가 |
| Xcode에서 아이콘이 빈칸으로 표시 | 크기 불일치 | Contents.json에서 선언된 크기와 실제 파일 크기 일치 여부 확인 |
| 홈 화면 아이콘 품질 저하 | @2x만 제공 | @3x (180×180) PNG 추가 |
| Flutter 빌드 후 아이콘 미적용 | `flutter_launcher_icons` 미실행 | `dart run flutter_launcher_icons` 재실행 후 빌드 |
