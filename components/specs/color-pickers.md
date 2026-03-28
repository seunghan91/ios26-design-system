# Color Picker — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:26010")`

---

## 1. 개요

iOS 26 Color Picker는 사용자가 색상을 선택할 수 있는 시스템 제공 UI 컴포넌트다. 7가지 뷰 모드(탭)를 제공하며, 각 모드는 용도에 따라 선택한다.

| 모드 | 설명 | 주요 용도 |
|------|------|---------|
| **Grid** | 색상 격자 — 미리 정의된 컬러 팔레트 | 빠른 색상 선택 |
| **Spectrum** | 스펙트럼 그라디언트 + Hue Bar | 정밀 색상 선택 |
| **Sliders** | RGB 또는 HSB 슬라이더 | 수치 기반 색상 입력 |
| **Eyedropper** | 화면 픽셀 색상 추출 | 기존 색상 복제 |
| **Favorites** | 최근 사용 + 저장 색상 | 자주 쓰는 색상 관리 |
| **Hex Input** | 16진수 직접 입력 | 정확한 색상 코드 입력 |
| **Opacity** | 불투명도 슬라이더 | 알파 채널 조정 |

**Figma Node**: `507:26010` — COMPONENT_SET

---

## 2. 전체 패널 치수

```
┌─────────────────────────────────────────┐
│  [Grid][Spec][Slider][Eye][Fav][Hex][Op]│ ← 탭 바, 높이 44pt
├─────────────────────────────────────────┤
│                                         │
│         [ 모드별 콘텐츠 영역 ]           │ ← 가변 높이
│                                         │
├─────────────────────────────────────────┤
│  미리보기 색상 박스 + Hex 표시           │ ← 높이 44pt
└─────────────────────────────────────────┘
  ← 전체 너비: 320pt 고정 →
```

| 항목 | 값 |
|------|-----|
| **전체 너비** | 320pt (고정) |
| **높이** | 가변 — 모드마다 다름 (하단 참조) |
| **코너 반경** | 12pt (`radius.lg`) |
| **패딩 (내부)** | 수평 16pt, 수직 16pt |
| **탭 바 높이** | 44pt |
| **하단 미리보기 영역 높이** | 44pt |

### 모드별 콘텐츠 높이

| 모드 | 콘텐츠 높이 | 총 패널 높이 |
|------|------------|------------|
| **Grid** | 약 280pt (12열 × 여러 행) | 384pt |
| **Spectrum** | 220pt | 324pt |
| **Sliders** | 176pt (4슬라이더 × 44pt) | 280pt |
| **Eyedropper** | 200pt (안내 + 루페 뷰) | 304pt |
| **Favorites** | 120pt (최근 + 저장 슬롯) | 224pt |
| **Hex Input** | 80pt (텍스트 필드) | 184pt |
| **Opacity** | 80pt (슬라이더 1개) | 184pt |

---

## 3. 모드별 상세 스펙

### 3.1 Grid 모드

```
┌──────────────────────────────────────────┐
│ ●  ●  ●  ●  ●  ●  ●  ●  ●  ●  ●  ●   │ ← 행 1 (기본색)
│ ●  ●  ●  ●  ●  ●  ●  ●  ●  ●  ●  ●   │ ← 행 2 (명도 변화)
│ ...                                      │ (총 12+ 행)
└──────────────────────────────────────────┘
```

| 항목 | 값 |
|------|-----|
| **열 수** | 12열 |
| **스와치 크기** | 24×24pt |
| **스와치 간격** | 4pt |
| **행 간격** | 4pt |
| **선택 표시** | 체크마크 오버레이 (흰색/검정 자동) |
| **선택 링** | 2pt `accents.blue` 테두리 |
| **코너 반경 (스와치)** | 4pt (`radius.xs`) |
| **전체 그리드 너비** | (24 × 12) + (4 × 11) = 332pt → 패딩으로 맞춤 |

**색상 팔레트 구성**:
- 1행: 흑백 그라디언트 (검정 → 흰색)
- 2-7행: 빨강/주황/노랑/초록/파랑/보라 계열 6단계 명도
- 8행+: 시스템 색상 팔레트 (iOS 시스템 컬러)

### 3.2 Spectrum 모드

```
┌─────────────────────────────────────────┐
│                                         │
│  ◄ 색상 채도/명도 그라디언트 (2D) ►     │  높이 200pt
│                                         │
│             ●                           │  ← 선택 커서 (원형 핸들)
└─────────────────────────────────────────┘
│▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓│  ← Hue Bar, 높이 20pt
└─────────────────────────────────────────┘
```

| 항목 | 값 |
|------|-----|
| **그라디언트 패널 크기** | 320×200pt |
| **그라디언트 X축** | 채도 0→100% (왼쪽=흰색, 오른쪽=순색) |
| **그라디언트 Y축** | 명도 100→0% (위=밝음, 아래=검정) |
| **선택 커서** | 원형, 직경 20pt, 흰색 테두리 2pt, 그림자 |
| **Hue Bar 높이** | 20pt |
| **Hue Bar 코너 반경** | 10pt (pill) |
| **Hue 핸들** | 원형, 직경 24pt, 흰색 테두리 2pt |
| **간격 (그라디언트↔Hue Bar)** | 8pt |

### 3.3 Sliders 모드

RGB와 HSB 두 가지 하위 모드를 세그먼트 컨트롤로 전환한다.

```
┌─────────────────────────────────────────┐
│  [RGB]  [HSB]                           │ ← 세그먼트, 높이 32pt
│                                         │
│  R  ━━━━━━━━━━━●━━━━━━━   255           │ ← 슬라이더 44pt
│  G  ━━━━━━━━━━●━━━━━━━━━  128           │
│  B  ━━━━━━━━━●━━━━━━━━━━   64           │
│  A  ━━━━━━━━━━━━━━━━━━━●  100%          │ ← 불투명도
└─────────────────────────────────────────┘
```

| 항목 | 값 |
|------|-----|
| **슬라이더 행 높이** | 44pt (터치 타겟 확보) |
| **슬라이더 트랙 높이** | 4pt |
| **슬라이더 트랙 코너 반경** | 2pt |
| **슬라이더 썸 직경** | 22pt |
| **슬라이더 썸 그림자** | offset(0,1), blur 3pt, opacity 0.3 |
| **레이블 너비** | 16pt (R/G/B/H/S/B) |
| **값 표시 너비** | 40pt |
| **슬라이더 트랙 색상** | R=빨강 그라디언트, G=초록, B=파랑, A=체커 + 색상 |

**슬라이더 트랙 배경**:
- RGB Sliders: 각 축의 색상 그라디언트
- Opacity Slider: 체커보드 패턴 위에 현재 색상 → 투명 그라디언트

### 3.4 Eyedropper 모드

| 항목 | 값 |
|------|-----|
| **루페(돋보기) 뷰 크기** | 120×120pt, 코너 반경 12pt |
| **루페 내부 격자** | 11×11 픽셀 격자, 중앙 픽셀 강조 |
| **중앙 커서 크기** | 10×10pt 정사각형, 흰색 테두리 2pt |
| **안내 텍스트** | Body 17pt, `labels.secondary` |
| **색상 미리보기** | 48×48pt 원형, 루페 하단 |
| **UIKit API** | `UIColorPickerViewController` + `.eyedropper` |

### 3.5 Favorites 모드

```
┌──────────────────────────────────────────┐
│ 최근 사용 색상                            │ ← 섹션 헤더
│ ●  ●  ●  ●  ●  ●  ●  ●  ●  ●           │ ← 최근 10개 (스와치 28pt)
│                                          │
│ 저장된 색상                               │ ← 섹션 헤더
│ ●  ●  ●  ●  ●  ●  ●  ●  +              │ ← 저장 슬롯 (+ 버튼 포함)
└──────────────────────────────────────────┘
```

| 항목 | 값 |
|------|-----|
| **스와치 크기** | 28×28pt |
| **스와치 간격** | 8pt |
| **최근 사용 슬롯 수** | 최대 10개 (FIFO 방식) |
| **저장 슬롯 수** | 최대 8개 (+ 추가 버튼) |
| **섹션 헤더 높이** | 28pt, Subheadline 15pt Semibold |
| **코너 반경 (스와치)** | 6pt |
| **+ 버튼** | 스와치 크기 동일, `fills.tertiary` 배경, + 아이콘 |

### 3.6 Hex Input 모드

```
┌──────────────────────────────────────────┐
│  #  │  R R G G B B A A                   │ ← Hex 필드
│     └─────────────────────────────────── │
│  미리보기 ████                            │
└──────────────────────────────────────────┘
```

| 항목 | 값 |
|------|-----|
| **입력 필드 높이** | 44pt |
| **입력 필드 너비** | 288pt (320 - 32pt 패딩) |
| **코너 반경** | 8pt |
| **배경** | `fills.tertiary` |
| **플레이스홀더** | `#RRGGBB` 또는 `#RRGGBBAA` |
| **폰트** | Monospaced / SF Mono, 17pt |
| **지원 포맷** | `#RGB`, `#RRGGBB`, `#RRGGBBAA` |
| **자동 대문자** | 없음 (16진수 입력) |
| **키보드** | `UIKeyboardType.asciiCapable` |

### 3.7 Opacity 모드

별도 탭으로 불투명도(Alpha)만 조절하는 단독 슬라이더.

| 항목 | 값 |
|------|-----|
| **슬라이더 높이** | 44pt |
| **트랙 배경** | 체커보드 (투명 영역 표시) + 현재 색상 그라디언트 |
| **값 표시** | 0–100% 또는 0–255 (토글 가능) |

---

## 4. 색상 토큰 매핑

```json
// ../tokens/colors.json 참조
{
  "colorPicker": {
    "panel": {
      "background": "Colors/Background/Primary",
      "border": "Colors/Separator/Opaque",
      "tabBar": "Colors/Fill/Quaternary"
    },
    "tabItem": {
      "active": "Colors/Tint/Blue",
      "inactive": "Colors/Label/Tertiary"
    },
    "swatch": {
      "selectionRing": "Colors/Tint/Blue",
      "checkerLight": "#FFFFFF",
      "checkerDark": "rgba(0,0,0,0.1)"
    },
    "sliderThumb": {
      "fill": "#FFFFFF",
      "shadow": "rgba(0,0,0,0.30)"
    },
    "hexField": {
      "background": "Colors/Fill/Tertiary",
      "label": "Colors/Label/Primary",
      "placeholder": "Colors/Label/Tertiary"
    },
    "preview": {
      "background": "Colors/Fill/Quaternary"
    }
  }
}
```

| 요소 | Light | Dark |
|------|-------|------|
| **패널 배경** | `#FFFFFF` | `#1C1C1E` |
| **탭 바** | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` |
| **활성 탭** | `#0088FF` | `#0091FF` |
| **비활성 탭** | `rgba(60,60,67,0.3)` | `rgba(235,235,245,0.3)` |
| **선택 링** | `#0088FF` | `#0091FF` |
| **슬라이더 썸** | `#FFFFFF` + shadow | `#FFFFFF` + shadow |
| **Hex 필드 배경** | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |

---

## 5. 타이포그래피

```json
// ../tokens/typography.json 참조
{
  "colorPicker": {
    "tabLabel": {
      "fontStyle": "Caption1",
      "weight": "Medium",
      "size": "12pt",
      "letterSpacing": "0.07pt"
    },
    "sectionHeader": {
      "fontStyle": "Subheadline",
      "weight": "Semibold",
      "size": "15pt"
    },
    "sliderLabel": {
      "fontStyle": "Subheadline",
      "weight": "Regular",
      "size": "15pt"
    },
    "sliderValue": {
      "fontStyle": "Body",
      "weight": "Regular",
      "size": "17pt"
    },
    "hexInput": {
      "fontStyle": "Body Mono",
      "weight": "Regular",
      "size": "17pt"
    }
  }
}
```

---

## 6. 간격 토큰

```json
// ../tokens/spacing.json 참조
{
  "colorPicker": {
    "panelWidth": 320,
    "panelPaddingH": 16,
    "panelPaddingV": 16,
    "tabBarHeight": 44,
    "previewBarHeight": 44,
    "cornerRadius": 12,
    "grid": {
      "swatchSize": 24,
      "swatchGap": 4,
      "columns": 12
    },
    "favorites": {
      "swatchSize": 28,
      "swatchGap": 8
    },
    "slider": {
      "rowHeight": 44,
      "trackHeight": 4,
      "thumbDiameter": 22,
      "labelWidth": 16,
      "valueWidth": 40
    },
    "spectrum": {
      "gradientHeight": 200,
      "hueBarHeight": 20,
      "hueBarGap": 8,
      "cursorDiameter": 20
    }
  }
}
```

---

## 7. 애니메이션

```json
// ../tokens/animations.json 참조
{
  "colorPicker": {
    "tabTransition": {
      "type": "spring",
      "stiffness": 380,
      "damping": 30,
      "duration": "~0.35s"
    },
    "swatchPress": {
      "type": "scale",
      "from": 1.0,
      "to": 0.92,
      "duration": "0.1s",
      "easing": "easeIn"
    },
    "swatchSelect": {
      "type": "spring",
      "from": 0.92,
      "to": 1.0,
      "stiffness": 500,
      "damping": 25
    },
    "sliderSnap": {
      "type": "spring",
      "stiffness": 400,
      "damping": 35
    },
    "cursorDrag": {
      "type": "linear",
      "followFinger": true,
      "haptic": "UIImpactFeedbackGenerator.FeedbackStyle.light"
    },
    "panelAppear": {
      "type": "spring",
      "from": { "opacity": 0, "scale": 0.9 },
      "to": { "opacity": 1, "scale": 1 },
      "stiffness": 350,
      "damping": 28
    }
  }
}
```

### 탭 전환 애니메이션

- 슬라이드 방식: 현재 뷰 → 수평 슬라이드 아웃, 새 뷰 → 슬라이드 인
- 높이가 다를 경우: 패널 높이 spring으로 자연스럽게 조절
- 트랙: `stiffness 380, damping 30`

### 슬라이더 드래그

- 실시간 색상 미리보기 업데이트 (60fps)
- 슬라이더 값 변경마다 `.selection` haptic
- 경계값(0, 255) 도달 시 `.rigid` haptic

---

## 8. 상태 정의

| 상태 | 시각적 표현 |
|------|-----------|
| **default** | 패널 표시, 첫 탭 활성 |
| **tab:active** | 탭 레이블 `accents.blue`, 하단 인디케이터 바 |
| **swatch:selected** | 선택 링 + 체크마크 오버레이 |
| **swatch:pressed** | scale 0.92, opacity 0.8 |
| **slider:dragging** | 썸 scale 1.1, 트랙 두께 6pt로 증가 |
| **hexInput:focused** | 필드 테두리 `accents.blue` 2pt |
| **hexInput:invalid** | 필드 테두리 `accents.red` 2pt, 흔들림 애니메이션 |
| **disabled** | 전체 opacity 0.4, 탭 불가 |

---

## 9. 접근성

| 항목 | 요구사항 |
|------|---------|
| **VoiceOver (Grid)** | `"빨강, 선택됨"` / `"파랑, 선택 안됨, 이중 탭으로 선택"` |
| **VoiceOver (Slider)** | `"빨강 채널, 슬라이더, 현재 값: 255"` |
| **VoiceOver (Hex)** | `"16진수 색상 입력 필드, #FF0000"` |
| **스와치 최소 타겟** | 44×44pt — 스와치 24pt 주변에 hit 영역 확장 |
| **색상 대비** | 선택 링: `accents.blue` — 배경 무관 충분한 대비 |
| **Dynamic Type** | 탭 레이블, 섹션 헤더는 Dynamic Type 적용 |
| **감소된 모션** | 탭 전환 — slide 없이 crossfade만 사용 |
| **색맹 지원** | 모든 스와치에 hex 값 VoiceOver 제공 |

---

## 10. 플랫폼별 구현

### UIKit

```swift
import UIKit

class ViewController: UIViewController, UIColorPickerViewControllerDelegate {

    @IBAction func showColorPicker(_ sender: UIButton) {
        let picker = UIColorPickerViewController()
        picker.title = "색상 선택"
        picker.supportsAlpha = true                // Opacity 탭 활성화
        picker.selectedColor = .systemBlue         // 초기 색상
        picker.delegate = self
        present(picker, animated: true)
    }

    // 색상이 변경될 때마다 실시간 호출
    func colorPickerViewControllerDidSelectColor(
        _ viewController: UIColorPickerViewController
    ) {
        let selectedColor = viewController.selectedColor
        print("선택된 색상: \(selectedColor)")
        view.backgroundColor = selectedColor
    }

    // 피커를 닫을 때 호출
    func colorPickerViewControllerDidFinish(
        _ viewController: UIColorPickerViewController
    ) {
        let finalColor = viewController.selectedColor
        print("최종 색상: \(finalColor)")
    }
}
```

### SwiftUI

```swift
import SwiftUI

struct ColorPickerDemo: View {
    @State private var bgColor = Color.systemBlue
    @State private var textColor = Color.white

    var body: some View {
        VStack(spacing: 24) {
            // 기본 ColorPicker — 시스템 피커 시트 표시
            ColorPicker("배경 색상", selection: $bgColor)

            // 알파 채널 포함
            ColorPicker("텍스트 색상", selection: $textColor, supportsOpacity: true)

            // supportsOpacity: false → Opacity 탭 숨김
            ColorPicker("불투명 색상", selection: $bgColor, supportsOpacity: false)

            // 미리보기
            RoundedRectangle(cornerRadius: 12)
                .fill(bgColor)
                .frame(height: 80)
                .overlay(
                    Text("미리보기")
                        .foregroundStyle(textColor)
                )
        }
        .padding()
    }
}
```

### Flutter (`flutter_colorpicker` 패키지)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDemo extends StatefulWidget {
  const ColorPickerDemo({super.key});

  @override
  State<ColorPickerDemo> createState() => _ColorPickerDemoState();
}

class _ColorPickerDemoState extends State<ColorPickerDemo> {
  Color _selectedColor = Colors.blue;

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('색상 선택'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 색상 휠 (Spectrum 모드와 유사)
              ColorPicker(
                pickerColor: _selectedColor,
                onColorChanged: (color) {
                  setState(() => _selectedColor = color);
                },
                pickerAreaHeightPercent: 0.7,
                enableAlpha: true,              // Opacity 슬라이더
                displayThumbColor: true,
                portraitOnly: false,
                paletteType: PaletteType.hsv,   // HSB 모드
              ),
              // Hex 입력 필드
              HexColorPicker(
                color: _selectedColor.value.toRadixString(16),
                onColorChanged: (hexColor) {
                  setState(() {
                    _selectedColor = Color(
                      int.parse(hexColor.replaceFirst('#', ''), radix: 16) + 0xFF000000,
                    );
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('완료'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showColorPicker(context),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: _selectedColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
    );
  }
}
```

### 웹 (기본 + 커스텀 패널)

```html
<!-- 네이티브 input[type="color"] — OS 기본 색상 피커 표시 -->
<input
  type="color"
  id="colorPicker"
  value="#0088FF"
  aria-label="색상 선택"
/>
```

```svelte
<!-- 커스텀 패널 (Svelte 5) — iOS 26 스타일 -->
<script lang="ts">
  type PickerMode = 'grid' | 'spectrum' | 'sliders' | 'eyedropper' | 'favorites' | 'hex' | 'opacity';

  let activeMode = $state<PickerMode>('grid');
  let selectedColor = $state('#0088FF');
  let alpha = $state(100); // 0-100

  const TABS: { id: PickerMode; label: string; icon: string }[] = [
    { id: 'grid',       label: '격자',    icon: '⊞' },
    { id: 'spectrum',   label: '스펙트럼', icon: '◐' },
    { id: 'sliders',    label: '슬라이더', icon: '≡' },
    { id: 'eyedropper', label: '스포이트', icon: '⌾' },
    { id: 'favorites',  label: '즐겨찾기', icon: '★' },
    { id: 'hex',        label: 'Hex',     icon: '#' },
    { id: 'opacity',    label: '불투명도', icon: '◫' },
  ];

  // Grid 팔레트 (기본 색상 배열)
  const PALETTE_COLORS = [
    // 흑백 행
    '#000000','#1C1C1E','#3A3A3C','#48484A','#636366','#8E8E93',
    '#AEAEB2','#C7C7CC','#D1D1D6','#E5E5EA','#F2F2F7','#FFFFFF',
    // 빨강 계열
    '#FF3B30','#FF453A','#FF6B6B','#FF8080','#FFAAAA','#FFD5D5',
    ...
  ];
</script>

<div
  class="color-picker-panel"
  style="width: 320px; border-radius: 12px; overflow: hidden;
         background: var(--color-bg-primary); box-shadow: 0 8px 24px rgba(0,0,0,0.25);"
>
  <!-- 탭 바 -->
  <div
    class="tab-bar"
    style="display: flex; height: 44px; background: var(--color-fill-quaternary);
           border-bottom: 1px solid var(--color-separator);"
    role="tablist"
  >
    {#each TABS as tab}
      <button
        role="tab"
        aria-selected={activeMode === tab.id}
        aria-label={tab.label}
        onclick={() => activeMode = tab.id}
        style="flex: 1; border: none; background: transparent; cursor: pointer;
               font-size: 12px; font-weight: 500;
               color: {activeMode === tab.id ? '#0088FF' : 'rgba(60,60,67,0.3)'};
               transition: color 0.15s ease;"
      >
        {tab.icon}
      </button>
    {/each}
  </div>

  <!-- 콘텐츠 영역 -->
  <div class="picker-content" style="padding: 16px;" role="tabpanel">
    {#if activeMode === 'grid'}
      <!-- Grid 콘텐츠 생략: 스와치 12열 × N행 -->
      <div
        style="display: grid; grid-template-columns: repeat(12, 24px);
               gap: 4px; justify-content: center;"
      >
        {#each PALETTE_COLORS as color}
          <button
            class="swatch"
            style="width: 24px; height: 24px; border-radius: 4px;
                   background: {color}; border: {selectedColor === color ? '2px solid #0088FF' : 'none'};
                   cursor: pointer; transition: transform 0.1s ease;"
            aria-label={color}
            aria-pressed={selectedColor === color}
            onclick={() => selectedColor = color}
          />
        {/each}
      </div>
    {:else if activeMode === 'hex'}
      <label for="hexInput" style="display: block; font-size: 15px; margin-bottom: 8px;">
        16진수 색상
      </label>
      <input
        id="hexInput"
        type="text"
        bind:value={selectedColor}
        placeholder="#RRGGBB"
        maxlength={9}
        style="width: 100%; height: 44px; padding: 0 12px;
               border-radius: 8px; border: none; font-size: 17px; font-family: monospace;
               background: var(--color-fill-tertiary); color: var(--color-label-primary);"
      />
    {/if}
  </div>

  <!-- 미리보기 바 -->
  <div
    style="height: 44px; display: flex; align-items: center;
           padding: 0 16px; gap: 12px; border-top: 1px solid var(--color-separator);"
  >
    <div
      style="width: 28px; height: 28px; border-radius: 6px;
             background: {selectedColor}; flex-shrink: 0;"
      aria-label="선택된 색상 미리보기"
    />
    <code style="font-size: 15px; color: var(--color-label-secondary);">
      {selectedColor}
    </code>
  </div>
</div>

<style>
  @media (prefers-color-scheme: dark) {
    .color-picker-panel {
      --color-bg-primary: #1C1C1E;
      --color-fill-quaternary: rgba(118,118,128,0.18);
      --color-fill-tertiary: rgba(118,118,128,0.24);
      --color-separator: rgba(84,84,88,0.65);
      --color-label-primary: #FFFFFF;
      --color-label-secondary: rgba(235,235,245,0.6);
    }
  }

  @media (prefers-color-scheme: light) {
    .color-picker-panel {
      --color-bg-primary: #FFFFFF;
      --color-fill-quaternary: rgba(116,116,128,0.08);
      --color-fill-tertiary: rgba(118,118,128,0.12);
      --color-separator: rgba(60,60,67,0.29);
      --color-label-primary: #000000;
      --color-label-secondary: rgba(60,60,67,0.6);
    }
  }

  .swatch:active {
    transform: scale(0.92);
  }

  .swatch:focus-visible {
    outline: 2px solid #0088FF;
    outline-offset: 2px;
  }

  @media (prefers-reduced-motion: reduce) {
    .swatch { transition: none; }
  }
</style>
```

---

## 11. 다크모드 대응

| 요소 | Light | Dark |
|------|-------|------|
| 패널 배경 | `#FFFFFF` | `#1C1C1E` |
| 탭 바 배경 | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` |
| 활성 탭 | `#0088FF` | `#0091FF` |
| 슬라이더 트랙 (기본) | `rgba(116,116,128,0.12)` | `rgba(118,118,128,0.24)` |
| Hex 필드 배경 | `rgba(118,118,128,0.12)` | `rgba(118,118,128,0.24)` |
| 구분선 | `rgba(60,60,67,0.29)` | `rgba(84,84,88,0.65)` |
| 텍스트 | `#000000` | `#FFFFFF` |
| 보조 텍스트 | `rgba(60,60,67,0.6)` | `rgba(235,235,245,0.6)` |

---

## 12. 엣지 케이스

- **Hex 유효성 검사**: `#RGB` 입력 → `#RRGGBB`로 자동 확장 (`#F00` → `#FF0000`)
- **Hex 길이 초과**: 최대 9자 (`#RRGGBBAA`) 제한
- **스와치 투명색**: 체커보드 패턴으로 투명도 시각화 필수
- **Eyedropper + Privacy**: macOS에서 스크린 녹화 권한 필요. 권한 없으면 시스템 팝업 표시
- **Dynamic Island과 Eyedropper**: Dynamic Island 영역은 스포이트 불가 (시스템 제한)
- **컬러스페이스**: `UIColor` 기본값은 `sRGB`. `Display P3` 색상은 별도 처리 필요

---

## 13. 체크리스트

- [ ] 패널 너비 320pt 고정
- [ ] 7개 탭 모두 구현 (Grid / Spectrum / Sliders / Eyedropper / Favorites / Hex / Opacity)
- [ ] Grid: 12열 × 24pt 스와치, 4pt 간격
- [ ] Spectrum: 320×200pt 그라디언트 + 20pt Hue Bar
- [ ] Sliders: RGB/HSB 토글, 각 행 44pt
- [ ] Hex: `#RRGGBB` / `#RRGGBBAA` 포맷 지원
- [ ] Favorites: 최근 10개 + 저장 8슬롯
- [ ] 탭 전환 spring 애니메이션 (stiffness 380, damping 30)
- [ ] 실시간 색상 미리보기 (60fps)
- [ ] 다크모드 토큰 대응
- [ ] VoiceOver 레이블 (`role="tab"`, `aria-selected`, 스와치 hex 값)
- [ ] 슬라이더 드래그 시 haptic 피드백
- [ ] 체커보드 배경 (투명 색상 표시)
