# Tab Bar — iOS 26 페이지 레시피

> **References**
> - Components: `../../components/specs/tab-bar.md`
> - Tokens: `../../tokens/`
> - Sections: `../../sections/`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="3:70967")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | Tab Bar (2 Variants) |
| **디바이스** | iPhone 17 Pro, 402 × 874pt |
| **용도** | 앱 최상위 탐색 — 주요 섹션 간 전환 |
| **iOS 26 특이사항** | Liquid Glass 물방울 인디케이터, Morphing 애니메이션, Split Search 모드 |

iOS 26 Tab Bar의 가장 큰 변화는 **Liquid Glass 탭 인디케이터**다. 선택된 탭 아래에 반투명 유리질 배경 pill이 나타나며, 탭 간 전환 시 이 pill이 탄성 있는 spring 애니메이션으로 morph된다. 2가지 variant: Standard 5-tab과 Split Search mode.

---

## Variant 1: Standard 5-Tab with Liquid Glass

### 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │  ← Status Bar (54pt)
├─────────────────────────────────────────────┤
│                                              │
│   Main Content Area                          │
│   (Varies per selected tab)                  │
│                                              │
│                                              │
│                                              │
│                                              │
│                                              │
│                                              │
│                                              │
│                                              │
│                                              │
│                                              │
├─────────────────────────────────────────────┤  ← separator: nonOpaque (0.5pt)
│  ┌─────────────────────────────────────────┐│
│  │         Liquid Glass Indicator          ││  ← Indicator pill
│  │         ╔═══════╗                       ││    w: 64pt, h: 32pt
│  │  ★      ║  🏠   ║  🔔    👤    ⚙️     ││    r: 9999px (pill)
│  │  Home   ║ Feed  ║ Alerts Profile Settings││    blur(7px), fills.quaternary
│  │         ╚═══════╝                       ││
│  └─────────────────────────────────────────┘│  ← Tab Bar height: 49pt
│                                              │  ← + safe area bottom: 34pt
└─────────────────────────────────────────────┘
              ─────                               ← Home Indicator
```

### Dimensions

| 속성 | 값 | 토큰 |
|------|-----|------|
| Tab Bar 높이 | 49pt | `spacing.json > components.tabBar.height` |
| 인디케이터 포함 높이 | 83pt | `spacing.json > components.tabBar.heightWithIndicator` |
| Padding Bottom | 34pt (safe area) | `spacing.json > safeArea.iphone16Pro.bottom` |
| 탭 버튼 최소 너비 | 64pt | `spacing.json > components.tabBar.itemMinWidth` |
| 인디케이터 pill 높이 | 32pt | Figma 측정값 |
| 인디케이터 pill 너비 | 64pt | Figma 측정값 |
| 인디케이터 cornerRadius | 9999px (pill) | `spacing.json > radius.full` |
| 인디케이터 blur | 7px | `spacing.json > liquidGlass.frost.small` |

### Color Tokens

| 요소 | Light | Dark | 토큰 경로 |
|------|-------|------|----------|
| 선택된 탭 레이블 | `#000000` (a:1) | `#ffffff` (a:1) | `colors.json > labels.primary` |
| 비선택 탭 레이블 | `#999999` | `#7e7e7e` | `colors.json > miscellaneous.tabUnselected` |
| Indicator 배경 | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` | `colors.json > fills.quaternary` |
| Indicator blur | blur(7px) | blur(7px) | `spacing.json > liquidGlass.frost.small` |
| Tab Bar 배경 | `#ffffff` + blur | `#000000` + blur | `colors.json > backgrounds.primary` |
| 구분선 | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` | `colors.json > separators.nonOpaque` |

### Typography

| 요소 | Style | Size | Weight | Letter Spacing |
|------|-------|------|--------|---------------|
| 탭 레이블 (비선택) | caption2 | 11pt | Regular | 0.06 |
| 탭 레이블 (선택됨) | caption2 Emphasized | 11pt | Semibold | 0.06 |

### Liquid Glass Indicator Morphing Animation

```yaml
trigger: 탭 전환
duration: 0.45s                   # animations.json > liquidGlass.tabIndicator.duration
spring: snappy                    # response: 0.3, dampingRatio: 0.8
css: cubic-bezier(0.34, 1.56, 0.64, 1.0)

keyframes:
  0%:   width 64px, position: tab_A
  40%:  width 80px (stretched pill in travel direction)
  100%: width 64px, position: tab_B

properties:
  - width
  - height
  - border-radius (항상 9999px)
  - transform (translateX)
  - backdrop-filter: blur(7px)
```

```css
/* CSS 구현 */
@keyframes liquid-tab-move {
  0%   { width: 64px; border-radius: 9999px; }
  40%  { width: 80px; border-radius: 9999px; }
  100% { width: 64px; border-radius: 9999px; }
}

.tab-indicator {
  transition:
    width 0.45s cubic-bezier(0.34, 1.56, 0.64, 1.0),
    transform 0.45s cubic-bezier(0.34, 1.56, 0.64, 1.0),
    border-radius 0.45s cubic-bezier(0.34, 1.56, 0.64, 1.0);
  backdrop-filter: blur(7px);
  -webkit-backdrop-filter: blur(7px);
}
```

### 탭 전환 시퀀스

```
1. 탭 B 탭 감지
2. 탭 B 레이블: tabUnselected → labels.primary (fade, 0.2s easeOut)
3. Liquid Glass indicator: 탭 A → 탭 B morph
   - 40% 지점: pill 늘어남 (64px → 80px width)
   - 100% 지점: 목표 위치에서 snap (80px → 64px)
   - duration: 0.45s, spring.snappy
4. 탭 A 레이블: labels.primary → tabUnselected (fade, 0.2s easeOut)
```

---

## Variant 2: Split Search Mode

### 화면 구성 분해

```
iPhone 17 Pro (402 × 874pt)
┌─────────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■               │
├─────────────────────────────────────────────┤
│                                              │
│   Search Results Content                     │
│   (검색 활성화 상태)                           │
│                                              │
│                                              │
├─────────────────────────────────────────────┤
│  ┌───────────────────────┬─────────────────┐│
│  │  Standard Tabs (3-4)  │  🔍 Search Tab  ││  ← Split layout
│  │  ╔════╗               │                 ││
│  │  ║ 🏠 ║  🔔   👤     │  Search          ││
│  │  ║Home║ Alert Profile │  (separate)     ││
│  │  ╚════╝               │                 ││
│  └───────────────────────┴─────────────────┘│
│                                              │
└─────────────────────────────────────────────┘
```

### Split Search 특징

| 속성 | 설명 |
|------|------|
| Separate Search | `True` — Search 탭이 오른쪽에 분리 배치 |
| 일반 탭 영역 | 나머지 탭들이 좌측에 그룹 |
| Search 탭 버튼 | `_Tab Bar Button - iPhone - Search` variant |
| Search 인디케이터 | 동일한 Liquid Glass pill |
| Search 활성화 | 탭 시 검색 UI로 전환 (SearchController 연동) |

### Minimized 모드 (스크롤 시)

| 속성 | 값 |
|------|-----|
| 트리거 | 콘텐츠 아래로 스크롤 |
| 애니메이션 | translateY(100% + safe-area-bottom), 0.3s appleEaseOut |
| CSS easing | `cubic-bezier(0.0, 0, 0.6, 1.0)` |
| 복귀 | 위로 스크롤 시 다시 표시 |

---

## Light / Dark 모드 차이

| 요소 | Light Mode | Dark Mode |
|------|-----------|-----------|
| Tab Bar 배경 | `rgba(255,255,255,0.85)` + blur(12px) | `rgba(0,0,0,0.85)` + blur(12px) |
| 구분선 | `rgba(0,0,0,0.12)` | `rgba(255,255,255,0.17)` |
| 선택 레이블 | `#000000` | `#ffffff` |
| 비선택 레이블 | `#999999` | `#7e7e7e` |
| Indicator bg | `rgba(116,116,128,0.08)` | `rgba(118,118,128,0.18)` |

---

## 인터랙션 노트

- **탭 전환**: 탭 버튼 탭 → Liquid Glass indicator morph + 콘텐츠 교체
- **롱프레스**: 탭 아이콘 롱프레스 → Context Menu (Quick Actions) 표시
- **Minimized**: 콘텐츠 스크롤 시 tab bar 자동 숨김, 역방향 스크롤로 복귀
- **Badge**: 탭 아이콘 우상단에 빨간 뱃지 (숫자 또는 점) 표시 가능
- **Highlighted 상태**: 탭 누름 시 인디케이터 scale 0.95, 레이블 opacity 0.6

---

## 접근성 고려사항

| 항목 | 요구사항 |
|------|---------|
| 최소 터치 타겟 | 44×44pt per tab button |
| ARIA role | `tab` (웹) / `UITabBarItem` (iOS) |
| 선택 상태 | `aria-selected="true/false"` / `.selected` trait |
| 레이블 대비 | 선택: `labels.primary` — WCAG AA 4.5:1 충족 |
| | 비선택: `#999999` — 대비 2.85:1 (informational) |
| Dynamic Type | caption2 — xSmall~Large: 11pt, xxLarge: 12pt |
| VoiceOver | "탭 이름, 탭, 총 N개 중 M번째" |
| Reduce Motion | morph 애니메이션 disable, 즉시 전환 |
| 최소 탭 수 | 2개 |
| 최대 탭 수 | 5개 (More 탭으로 확장 가능) |
