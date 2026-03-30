# iOS 26 Date/Time Picker — Component Spec

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:24680")`

---

## 1. 개요

iOS 26 Date/Time Picker는 사용자가 날짜와 시간을 선택하는 표준 UI 컴포넌트다. 두 가지 표시 모드를 제공한다.

- **Collapsed (인라인 버튼)**: 현재 선택된 날짜/시간을 버튼 형태로 인라인에 표시. 탭 시 Expanded 모드로 전환.
- **Expanded (드럼롤 피커)**: 세로 스크롤 가능한 wheel(drum roll) UI로 날짜·시간 선택.

---

## 2. Variants

| Variant 이름 | Node | 설명 |
|---|---|---|
| `Date and time - Collapsed` (Default) | `507:24680` | 날짜+시간 인라인 표시, 미확장 상태 |
| `Date and time - Collapsed` (Tinted) | — | Tinted 배경 버튼 스타일 |
| `Date and time - Pickers` (Date) | — | 날짜 드럼롤 확장 상태 |
| `Date and time - Pickers` (Time) | — | 시간 드럼롤 확장 상태 |

---

## 3. 치수 & 레이아웃

### 3.1 Collapsed 버튼

```
┌─────────────────────────────────┐
│  [  Jan 15, 2026  ]  [ 3:42 PM ]│  ← 높이: 34pt
└─────────────────────────────────┘
   ↑ 날짜 버튼         ↑ 시간 버튼
   min-width: 120pt    min-width: 80pt
   padding: 0 12pt     padding: 0 12pt
   corner-radius: 8pt
```

- **높이**: 34pt
- **최소 너비**: 날짜 버튼 120pt, 시간 버튼 80pt
- **패딩**: 수평 12pt
- **코너 반경**: 8pt
- **간격 (날짜↔시간)**: 8pt

### 3.2 Expanded Wheel

```
┌───────────────────────────────────────┐
│  January  │  15  │  2026             │  ← row 1 (dimmed)
│  February │  16  │  2027             │  ← row 2 (dimmed)
│ ─────────────────────────────────── │  ← 선택 영역 highlight
│   March   │  17  │  2028             │  ← row 3 (SELECTED, 중앙)
│ ─────────────────────────────────── │
│   April   │  18  │  2029             │  ← row 4 (dimmed)
│    May    │  19  │  2030             │  ← row 5 (dimmed)
└───────────────────────────────────────┘
 ↑ 전체 높이: 216pt (5행 × 43.2pt/행)
 ↑ 너비: 화면 가로폭 - 32pt (좌우 16pt 여백)
```

- **Wheel 전체 높이**: 216pt
- **행 높이**: 43.2pt (= 216 / 5)
- **선택된 행 위치**: 정중앙 (top offset: 86.4pt = 43.2 × 2)
- **열 구성 (날짜)**: 월(Month) | 일(Day) | 년(Year)
- **열 구성 (시간)**: 시(Hour) | 분(Minute) | 오전/오후(AM/PM)

### 3.3 내부 서브컴포넌트

| 컴포넌트 | Variants | 설명 |
|---|---|---|
| `_Week` | 1 | 주 선택 드럼 컬럼 |
| `_Day` | 5 | 요일별 날짜 표시 행 |
| `_Month Column` | — | 월 이름 스크롤 드럼 |
| `_Year Column` | — | 연도 스크롤 드럼 |
| `_Selection Overlay` | — | 선택 행 강조 오버레이 |

---

## 4. 색상 토큰

```json
// ../tokens/colors.json 참조
{
  "picker": {
    "collapsed": {
      "background": "Colors/Fill/Quaternary",
      "label": "Colors/Tint/Blue",
      "border": "transparent"
    },
    "wheel": {
      "containerBackground": "Colors/Background/Primary",
      "selectedRowBackground": "Colors/Fill/Quaternary",
      "selectedText": "Colors/Label/Primary",
      "dimmedText": "Colors/Label/Tertiary",
      "separatorLine": "Colors/Separator/Opaque"
    }
  }
}
```

- **Collapsed 버튼 배경**: `Colors/Fill/Quaternary` (연한 회색, 다크모드 대응)
- **Collapsed 레이블**: `Colors/Tint/Blue` (시스템 강조색)
- **Wheel 선택 행 배경**: `Colors/Fill/Quaternary`
- **비선택 행 텍스트**: `Colors/Label/Tertiary` (opacity 0.3 fade)
- **구분선**: `Colors/Separator/Opaque`

---

## 5. 타이포그래피

```json
// ../tokens/typography.json 참조
{
  "picker": {
    "collapsedLabel": {
      "fontStyle": "Body",
      "weight": "Regular",
      "size": "17pt"
    },
    "wheelItem": {
      "fontStyle": "Title3",
      "weight": "Regular",
      "size": "22pt"
    },
    "wheelItemSelected": {
      "fontStyle": "Title3",
      "weight": "Semibold",
      "size": "22pt"
    }
  }
}
```

- **Collapsed 텍스트**: Body (17pt, Regular)
- **Wheel 비선택 항목**: Title3 (22pt, Regular)
- **Wheel 선택 항목**: Title3 (22pt, Semibold)

---

## 6. 간격 토큰

```json
// ../tokens/spacing.json 참조
{
  "picker": {
    "collapsedPaddingH": 12,
    "collapsedPaddingV": 7,
    "collapsedCornerRadius": 8,
    "collapsedGap": 8,
    "wheelRowHeight": 43.2,
    "wheelTotalHeight": 216,
    "wheelColumnGap": 0,
    "containerPaddingH": 16
  }
}
```

---

## 7. 애니메이션

```json
// ../tokens/animations.json 참조
{
  "picker": {
    "drumScroll": {
      "type": "friction-decay",
      "deceleration": 0.998,
      "snapAlignment": "center"
    },
    "expandCollapse": {
      "type": "spring",
      "stiffness": 400,
      "damping": 35,
      "initialVelocity": 0,
      "duration": "~0.45s"
    },
    "selectionFeedback": {
      "type": "haptic",
      "style": "UIImpactFeedbackGenerator.FeedbackStyle.light"
    }
  }
}
```

### 7.1 드럼 스크롤 (Friction Decay)

- 손가락을 놓으면 마찰 감속으로 자연스럽게 멈춤
- 가장 가까운 행 중앙으로 스냅 (`snapAlignment: center`)
- 경계에서 rubber-band 효과 (최상단/최하단 초과 시)

### 7.2 Collapsed → Expanded 전환

1. 버튼이 scale-down (0.97) 후 원래 크기로 복귀
2. 아래 콘텐츠가 push-down (height 0 → 216pt, spring)
3. Wheel 컬럼들이 fade-in (opacity 0 → 1, delay 0.05s)

### 7.3 Expanded → Collapsed 전환

위의 역순. Wheel fade-out → height spring-collapse → 버튼 표시

---

## 8. 상태 정의

| 상태 | 시각적 변화 |
|---|---|
| `default` | Collapsed 버튼, 정상 표시 |
| `pressed` (Collapsed) | Fill 배경 darkened, scale 0.97 |
| `expanded` | Wheel 표시, 버튼 숨김 |
| `scrolling` | 드럼 회전 중, 선택 행 하이라이트 유지 |
| `disabled` | opacity 0.4, 탭 불가 |

---

## 9. 접근성

- **VoiceOver**: "March 17, 2028, double tap to edit" 형식 레이블
- **Wheel 탐색**: 스와이프 상하로 값 변경 (+1/-1)
- **Dynamic Type**: `UIFont.TextStyle.body` → Wheel은 `.title3` 사용, 최대 크기 제한 고려
- **WCAG 대비**: 선택 텍스트 `Colors/Label/Primary` 기준 4.5:1 이상

---

## 10. 플랫폼별 구현

### 10.1 UIKit

```swift
import UIKit

// Compact (Collapsed) 스타일
let datePicker = UIDatePicker()
datePicker.datePickerMode = .dateAndTime
datePicker.preferredDatePickerStyle = .compact

// Wheel (Expanded) 스타일
let wheelPicker = UIDatePicker()
wheelPicker.datePickerMode = .dateAndTime
wheelPicker.preferredDatePickerStyle = .wheels

// Inline 스타일 (달력 그리드)
let inlinePicker = UIDatePicker()
inlinePicker.datePickerMode = .date
inlinePicker.preferredDatePickerStyle = .inline

// 값 변경 감지
datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

@objc func dateChanged(_ sender: UIDatePicker) {
    print("Selected: \(sender.date)")
}
```

### 10.2 SwiftUI

```swift
import SwiftUI

struct DatePickerDemo: View {
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()

    var body: some View {
        VStack(spacing: 16) {
            // Compact (Collapsed) — 기본 스타일
            HStack {
                Text("날짜:")
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .labelsHidden()
                // iOS 26에서는 .compact가 기본값 (Liquid Glass 적용)
            }

            // Wheel 스타일로 강제
            DatePicker(
                "시간 선택",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)
            .frame(height: 216)
            .clipped()

            // Graphical (달력) 스타일
            DatePicker(
                "날짜 선택",
                selection: $selectedDate,
                in: Date()...,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
        }
        .padding()
    }
}
```

### 10.3 Flutter (Cupertino)

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime _selectedDate = DateTime.now();
  bool _isExpanded = false;

  void _showPicker(BuildContext context) {
    setState(() => _isExpanded = true);
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => Container(
        height: 216 + 44, // wheel + toolbar
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            // Toolbar
            SizedBox(
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('취소'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child: const Text('완료'),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() => _isExpanded = false);
                    },
                  ),
                ],
              ),
            ),
            // Drum Roll Picker (height: 216pt)
            SizedBox(
              height: 216,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: _selectedDate,
                onDateTimeChanged: (date) {
                  setState(() => _selectedDate = date);
                },
                use24hFormat: false,
                minuteInterval: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPicker(context),
      child: Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: CupertinoColors.quaternarySystemFill.resolveFrom(context),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            // 날짜 포맷
            '${_selectedDate.month}월 ${_selectedDate.day}일',
            style: TextStyle(
              color: CupertinoTheme.of(context).primaryColor,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
```

### 10.4 Svelte (커스텀 Wheel Picker)

```svelte
<script lang="ts">
  import { spring } from 'svelte/motion';
  import { onMount } from 'svelte';

  let selectedDate = new Date();
  let isExpanded = $state(false);

  // Wheel 데이터
  const months = ['January', 'February', 'March', 'April', 'May', 'June',
                  'July', 'August', 'September', 'October', 'November', 'December'];
  const days = Array.from({ length: 31 }, (_, i) => i + 1);
  const years = Array.from({ length: 10 }, (_, i) => 2024 + i);

  let selectedMonthIdx = $state(selectedDate.getMonth());
  let selectedDayIdx = $state(selectedDate.getDate() - 1);
  let selectedYearIdx = $state(0);

  const ROW_HEIGHT = 43.2;
  const VISIBLE_ROWS = 5;

  function createWheelHandler(getIdx: () => number, setIdx: (n: number) => void, max: number) {
    let startY = 0;
    let currentOffset = 0;

    return {
      onpointerdown: (e: PointerEvent) => {
        startY = e.clientY;
        (e.target as HTMLElement).setPointerCapture(e.pointerId);
      },
      onpointermove: (e: PointerEvent) => {
        const delta = startY - e.clientY;
        currentOffset = delta;
      },
      onpointerup: () => {
        const steps = Math.round(currentOffset / ROW_HEIGHT);
        const newIdx = Math.max(0, Math.min(max - 1, getIdx() + steps));
        setIdx(newIdx);
        currentOffset = 0;
      }
    };
  }

  const collapsedLabel = $derived(
    `${months[selectedMonthIdx]} ${days[selectedDayIdx]}, ${years[selectedYearIdx]}`
  );
</script>

<!-- Collapsed 버튼 -->
{#if !isExpanded}
  <button
    class="collapsed-btn"
    onclick={() => isExpanded = true}
    style="height: 34px; padding: 0 12px; border-radius: 8px;
           background: var(--color-fill-quaternary); border: none;
           color: var(--color-tint-blue); font-size: 17px; cursor: pointer;"
  >
    {collapsedLabel}
  </button>
{/if}

<!-- Expanded Wheel -->
{#if isExpanded}
  <div class="wheel-container"
       style="height: 216px; display: flex; overflow: hidden; position: relative;">
    <!-- 선택 영역 오버레이 -->
    <div class="selection-overlay"
         style="position: absolute; top: {ROW_HEIGHT * 2}px; left: 0; right: 0;
                height: {ROW_HEIGHT}px; background: var(--color-fill-quaternary);
                pointer-events: none; z-index: 1;" />

    <!-- 월 컬럼 -->
    <div class="wheel-column" style="flex: 2; overflow: hidden; touch-action: none;">
      <div class="wheel-track"
           style="transform: translateY({-(selectedMonthIdx - 2) * ROW_HEIGHT}px);
                  transition: transform 0.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);">
        {#each months as month, i}
          <div class="wheel-item"
               style="height: {ROW_HEIGHT}px; display: flex; align-items: center;
                      justify-content: center; font-size: 22px;
                      font-weight: {i === selectedMonthIdx ? 600 : 400};
                      opacity: {Math.abs(i - selectedMonthIdx) > 2 ? 0 : 1 - Math.abs(i - selectedMonthIdx) * 0.3};">
            {month}
          </div>
        {/each}
      </div>
    </div>

    <!-- 일 컬럼 -->
    <div class="wheel-column" style="flex: 1; overflow: hidden;">
      <div class="wheel-track"
           style="transform: translateY({-(selectedDayIdx - 2) * ROW_HEIGHT}px);
                  transition: transform 0.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);">
        {#each days as day, i}
          <div class="wheel-item"
               style="height: {ROW_HEIGHT}px; display: flex; align-items: center;
                      justify-content: center; font-size: 22px;
                      font-weight: {i === selectedDayIdx ? 600 : 400};
                      opacity: {Math.abs(i - selectedDayIdx) > 2 ? 0 : 1 - Math.abs(i - selectedDayIdx) * 0.3};">
            {day}
          </div>
        {/each}
      </div>
    </div>

    <!-- 년 컬럼 -->
    <div class="wheel-column" style="flex: 1.5; overflow: hidden;">
      <div class="wheel-track"
           style="transform: translateY({-(selectedYearIdx - 2) * ROW_HEIGHT}px);
                  transition: transform 0.2s cubic-bezier(0.25, 0.46, 0.45, 0.94);">
        {#each years as year, i}
          <div class="wheel-item"
               style="height: {ROW_HEIGHT}px; display: flex; align-items: center;
                      justify-content: center; font-size: 22px;
                      font-weight: {i === selectedYearIdx ? 600 : 400};
                      opacity: {Math.abs(i - selectedYearIdx) > 2 ? 0 : 1 - Math.abs(i - selectedYearIdx) * 0.3};">
            {year}
          </div>
        {/each}
      </div>
    </div>
  </div>

  <button onclick={() => isExpanded = false} style="margin-top: 8px;">완료</button>
{/if}
```

---

## 11. 다크모드 대응

| 토큰 | 라이트 | 다크 |
|---|---|---|
| `Colors/Fill/Quaternary` | rgba(116,116,128,0.08) | rgba(118,118,128,0.24) |
| `Colors/Tint/Blue` | #007AFF | #0A84FF |
| `Colors/Label/Primary` | rgba(0,0,0,1.0) | rgba(255,255,255,1.0) |
| `Colors/Label/Tertiary` | rgba(60,60,67,0.3) | rgba(235,235,245,0.3) |

---

## 12. 엣지 케이스

- **2월 날짜 제한**: 월 변경 시 28/29일 자동 조정 (선택된 일이 해당 월 최대일 초과 시)
- **윤년**: `selectedYear % 4 === 0 && (selectedYear % 100 !== 0 || selectedYear % 400 === 0)`
- **시간대**: `UIDatePicker.timeZone` 설정 필요 (기본값: 시스템 시간대)
- **최소/최대 날짜**: `minimumDate`, `maximumDate` 프로퍼티로 범위 제한
- **Locale**: `UIDatePicker.locale` 로 월 이름 언어 변경 (한국어: `Locale(identifier: "ko_KR")`)

---

## 13. 체크리스트

- [ ] Collapsed 높이 34pt 준수
- [ ] Wheel 높이 216pt (5행) 준수
- [ ] 드럼 스크롤 friction decay 구현
- [ ] Collapsed↔Expanded spring 전환 (stiffness: 400, damping: 35)
- [ ] 선택 행 중앙 스냅 구현
- [ ] 다크모드 토큰 대응
- [ ] VoiceOver 레이블 설정
- [ ] 2월/윤년 날짜 범위 보정
- [ ] 햅틱 피드백 (선택 행 변경 시)
- [ ] Dynamic Type 최대 크기 처리
