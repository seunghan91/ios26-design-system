# Settings Screen — iOS 26 페이지 레시피

> **References**
> - Templates: `../../templates/`
> - Components: `../../components/specs/`
> - Tokens: `../../tokens/`
> - Inventory: `../../../figma-ios26-pages.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="...")`

---

## 화면 개요

| 항목 | 값 |
|------|-----|
| **화면명** | 설정 화면 (Settings Screen) |
| **용도** | 앱 환경 설정 — Grouped List 섹션으로 옵션을 분류 |
| **탐색 깊이** | Root 또는 1-depth (탭 직접 접근 또는 프로필에서 Push) |
| **상태 수** | 정상 / 검색 활성 |
| **iOS 26 특이사항** | Grouped Inset List, Toggle 리디자인, Search Bar 통합 |

iOS 설정 앱과 동일한 패턴을 따르는 화면이다. 옵션을 의미 단위로 묶은 Grouped Section으로 구성하며, 각 섹션에는 헤더와 풋노트(설명 텍스트)를 붙일 수 있다. Toggle, Disclosure Indicator, 체크마크, 서브타이틀 등 다양한 Row 스타일을 혼합해 사용한다.

---

## 사용된 Template

**`standard-screen.md`** (Large Title "설정") + **Grouped Inset List 레이아웃**

```
Template 조합:
- Navigation Bar: Large Title, 오른쪽 버튼 없음 (또는 "완료")
- Content: UITableView / List(.insetGrouped) — 섹션 분리
- Tab Bar: 있을 경우 하단 고정 (설정이 별도 탭인 경우)
- 검색바: Large Title 하단에 통합 (searchable modifier)
```

---

## 컴포넌트 계층 (ASCII 와이어프레임)

```
iPhone 16 Pro (393 × 852 pt)
┌─────────────────────────────────────────┐
│  ● ●●  9:41          ⠿ ▐▌ ■           │  ← Status Bar (54pt)
├─────────────────────────────────────────┤
│                                          │  ← Toolbar (Large Title mode)
│  설정                                    │    Large Title: 34pt Bold
│  ─────────────────────────────────────  │
│  [🔍 설정 검색]                           │  ← Search Bar (_Search-Top)
│  ─────────────────────────────────────  │
│                                          │
│  ╔═══════════════════════════════════╗  │
│  ║  [👤 프로필 아이콘  72pt]           ║  │  ← 프로필 섹션 (커스텀, 선택)
│  ║  홍길동                            ║  │    tap → 프로필 상세 Push
│  ║  iCloud, 미디어, 앱 스토어 ›        ║  │
│  ╚═══════════════════════════════════╝  │
│                                          │
│  ╔═══════════════════════════════════╗  │  ← Grouped Section 1: "일반"
│  ║  🔕  알림              ›          ║  │    Row: Disclosure
│  ║─────────────────────────────────║  │
│  ║  🔊  사운드 및 햅틱      ›          ║  │    Row: Disclosure
│  ║─────────────────────────────────║  │
│  ║  🌙  집중 모드           ›          ║  │    Row: Disclosure
│  ╚═══════════════════════════════════╝  │    Footer: 없음
│                                          │
│  ╔═══════════════════════════════════╗  │  ← Grouped Section 2: "디스플레이"
│  ║  ☀️  밝기 및 문자 크기   ›          ║  │    Row: Disclosure
│  ║─────────────────────────────────║  │
│  ║  🌓  다크 모드                     ║  │    Row: Toggle (오른쪽)
│  ║               ┌──────┐           ║  │         Toggle: ON (파란색)
│  ║               │  ●─  │           ║  │
│  ║               └──────┘           ║  │
│  ╚═══════════════════════════════════╝  │
│  [다크 모드를 켜면 어두운 배경이 적용됩니다] │  ← Section Footer (13pt, secondary)
│                                          │
│  ╔═══════════════════════════════════╗  │  ← Grouped Section 3: "언어 및 지역"
│  ║  🌐  언어              한국어 ›    ║  │    Row: Value + Disclosure
│  ║─────────────────────────────────║  │
│  ║  📍  지역              대한민국 ›  ║  │    Row: Value + Disclosure
│  ╚═══════════════════════════════════╝  │
│                                          │
│  ╔═══════════════════════════════════╗  │  ← Grouped Section 4: "화면 시간"
│  ║  ⏱  화면 시간          켜짐  ›    ║  │
│  ╚═══════════════════════════════════╝  │
│                                          │
│  ╔═══════════════════════════════════╗  │  ← Grouped Section 5: "앱 전용 설정"
│  ║  [세그먼트]  목록  │  그리드        ║  │    Row: Segmented Control
│  ╚═══════════════════════════════════╝  │
│  [화면 표시 방식을 선택합니다]             │  ← Footer
│                                          │
├─────────────────────────────────────────┤
│  [🏠홈] [🔍탐색] [＋] [🔔벨] [👤설정●]   │  ← Tab Bar
└─────────────────────────────────────────┘

검색 활성 상태:
┌─────────────────────────────────────────┐
│  [취소]  [🔍 "다크"]                     │  ← 검색 커서 활성
│  ─────────────────────────────────────  │
│                                          │
│  ╔═══════════════════════════════════╗  │  ← 검색 결과 그룹
│  ║  🌓  다크 모드  (디스플레이)       ║  │    섹션명이 breadcrumb로 표시
│  ╚═══════════════════════════════════╝  │
│                                          │
│  [최근 검색]                             │  ← 검색 기록 (선택 구현)
└─────────────────────────────────────────┘
```

---

## 사용된 Components 목록

| 컴포넌트 | 파일 | 사용 위치 | Variant |
|---------|------|---------|---------|
| Toolbar (Top) | `toolbar.md` | 상단 Navigation Bar | Large Title |
| Search Bar | `toolbar.md` (_Search-Top) | Large Title 하단 | Default / Active |
| List Row | `list-row.md` | 각 설정 항목 | Disclosure / Toggle / Value+Disclosure |
| Toggle | `toggle.md` | 다크 모드 등 on/off 옵션 | Default (파란색 ON) |
| Segmented Control | `segmented-control.md` | 보기 방식 전환 옵션 | 2-segment |
| Tab Bar | `tab-bar.md` | 하단 (설정이 탭인 경우) | 5-tab |

---

## 레이아웃 구조

```
Grouped Inset List 치수 (iOS 26 기준):

섹션 사이 간격:         28pt
섹션 헤더 높이:         28pt  (13pt Semibold Uppercase, labels.secondary)
섹션 푸터 높이:         20pt~ (13pt Regular, labels.secondary, 8pt top padding)
Row 기본 높이:          44pt  (내용이 길면 자동 확장)
Row 내부 수직 패딩:      11pt (상하)
Row 아이콘 영역:         29×29pt (corner-radius 6pt)
Row 아이콘 leading:      20pt
Row 텍스트 leading:      62pt (아이콘 있을 때)
Row 텍스트 trailing:     16pt
Disclosure Indicator:   8pt chevron, labels.tertiary
Toggle 크기:            51×31pt

섹션 컨테이너:
  background: backgrounds.secondary (#f2f2f7 light)
  corner-radius: 12pt
  shadow: 없음 (flat)
  horizontal-inset: 20pt (양측)
```

### Row 스타일 가이드

```
1. Disclosure Row (다음 화면으로 이동)
   [아이콘] 제목                          ›

2. Toggle Row (즉시 상태 변경)
   [아이콘] 제목                    [Toggle]

3. Value + Disclosure Row (현재 값 표시 후 이동)
   [아이콘] 제목             현재값  ›

4. Subtitle Row (설명 포함)
   [아이콘] 제목
            서브타이틀 (15pt secondary)    ›

5. Destructive Row (위험한 액션)
   [아이콘] 로그아웃                        ← red, centered
```

### 색상 토큰 매핑

| 요소 | 토큰 | 값 (Light) |
|------|------|-----------|
| 전체 배경 | `backgrounds.grouped.primary` | `#f2f2f7` |
| 섹션 카드 BG | `backgrounds.grouped.secondary` | `#ffffff` |
| Row 제목 | `labels.primary` | `#000000` |
| Row Value / Subtitle | `labels.secondary` | `#3c3c43 60%` |
| Disclosure | `labels.tertiary` | `#3c3c43 30%` |
| 섹션 헤더/풋터 | `labels.secondary` | `#3c3c43 60%` |
| Toggle ON | `accents.blue.light` | `#0088ff` |
| Toggle OFF | `fills.tertiary` | `rgba(116,116,128, 0.12)` |
| Destructive | `accents.red.light` | `#ff383c` |

---

## 특이사항 / 커스터마이징 포인트

### 검색바 통합 패턴
- `searchable(text:placement:)` → Large Title 아래 `.navigationBarDrawer` 위치
- 검색 활성화 시 Large Title fade-out + 검색창 확장
- 결과: 매칭 항목만 섹션 구조 유지하며 필터링

### 섹션 순서 설계 원칙
1. **가장 중요/자주 사용** 섹션을 상단에 배치
2. **위험한 액션** (로그아웃, 계정 삭제)은 최하단 별도 섹션
3. 한 섹션 최대 Row 수: 7개 (초과 시 분리 고려)

### Toggle 즉시 반응
- Toggle 탭 → 즉시 UI 업데이트 → 백그라운드에서 저장
- 저장 실패 시: Toggle 되돌리기 + 토스트 에러 메시지

### 세그먼트 컨트롤 (Segmented Control)
- Row 안에 넣을 때: 좌우 패딩 16pt, 상하 8pt
- 즉시 반응 (애니메이션 없이 콘텐츠 전환)

### 접근성 (Accessibility)
- 모든 Row: `accessibilityLabel` = 제목 + 현재값 + 역할
  예: "다크 모드, 켜짐, 스위치"
- Toggle: `accessibilityValue` = "켜짐" / "꺼짐"
- Disclosure: role = "버튼", hint = "이중 탭하여 이동"

---

## 애니메이션 시나리오

### 1. 검색 활성화
```
트리거: 검색바 탭
Duration: 0.3s
Curve: easeInOut
요소:
  - Large Title: opacity 1→0, scale 1→0.95, translateY 0→-12pt
  - 검색창: width 확장 (오른쪽 여백 → "취소" 버튼 공간)
  - 취소 버튼: translateX +80pt→0, opacity 0→1
  - 비관련 Row: opacity 1→0.3 (즉시)
```

### 2. Toggle 전환
```
트리거: 사용자 탭
Duration: 0.25s
Curve: spring(damping: 0.85, stiffness: 350)
요소:
  - 썸(원형): translateX 이동 (20pt 좌↔우)
  - 배경: fill color 전환 (fills.tertiary ↔ accents.blue)
  - 배경 width: 미세 확장 후 복귀 (팽창 효과)
```

### 3. Row 탭 (Disclosure)
```
트리거: 터치 다운
Duration: 즉시 → 0.3s 복귀
요소:
  - Row 배경: highlighted (fills.quaternary)
  - 화면 전환: NavigationStack push (우→좌 슬라이드)
```

### 4. Segmented Control 전환
```
트리거: 세그먼트 탭
Duration: 0.2s
Curve: easeInOut
요소:
  - 선택 배경 pill: x 이동 (spring)
  - 텍스트 색: 비선택→선택 (opacity 0.6→1.0)
```

---

## 프레임워크별 전체 코드 예시

### SwiftUI (iOS 26)

```swift
import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("displayStyle") private var displayStyle = 0
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                // ── 프로필 섹션 ──────────────────────
                Section {
                    NavigationLink(destination: ProfileDetailView()) {
                        HStack(spacing: 16) {
                            Circle()
                                .fill(.blue.gradient)
                                .frame(width: 72, height: 72)
                                .overlay {
                                    Text("홍")
                                        .font(.largeTitle.bold())
                                        .foregroundStyle(.white)
                                }
                            VStack(alignment: .leading, spacing: 2) {
                                Text("홍길동")
                                    .font(.title3.weight(.semibold))
                                Text("iCloud, 미디어, 앱 스토어")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }

                // ── 섹션 1: 일반 ─────────────────────
                Section("일반") {
                    NavigationLink(destination: NotificationsSettingsView()) {
                        Label("알림", systemImage: "bell.badge.fill")
                            .symbolRenderingMode(.multicolor)
                    }
                    NavigationLink(destination: SoundSettingsView()) {
                        Label("사운드 및 햅틱", systemImage: "speaker.wave.3.fill")
                            .symbolRenderingMode(.multicolor)
                    }
                    NavigationLink(destination: FocusSettingsView()) {
                        Label("집중 모드", systemImage: "moon.fill")
                            .symbolRenderingMode(.multicolor)
                    }
                }

                // ── 섹션 2: 디스플레이 ───────────────
                Section {
                    NavigationLink(destination: DisplaySettingsView()) {
                        Label("밝기 및 문자 크기", systemImage: "sun.max.fill")
                    }
                    Toggle(isOn: $isDarkMode) {
                        Label("다크 모드", systemImage: "circle.lefthalf.filled")
                    }
                    .tint(.blue)
                } header: {
                    Text("디스플레이")
                } footer: {
                    Text("다크 모드를 켜면 어두운 배경이 적용됩니다")
                }

                // ── 섹션 3: 언어 및 지역 ─────────────
                Section("언어 및 지역") {
                    NavigationLink(destination: LanguageSettingsView()) {
                        LabeledContent("언어", value: "한국어")
                    }
                    NavigationLink(destination: RegionSettingsView()) {
                        LabeledContent("지역", value: "대한민국")
                    }
                }

                // ── 섹션 4: 앱 전용 설정 ─────────────
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("보기 방식")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Picker("보기 방식", selection: $displayStyle) {
                            Text("목록").tag(0)
                            Text("그리드").tag(1)
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.vertical, 4)
                } footer: {
                    Text("화면 표시 방식을 선택합니다")
                }

                // ── 섹션 5: 계정 (하단) ──────────────
                Section {
                    Button(role: .destructive) {
                        // 로그아웃 처리
                    } label: {
                        HStack {
                            Spacer()
                            Text("로그아웃")
                            Spacer()
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.large)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "설정 검색"
            )
        }
    }
}
```

### Flutter (Cupertino)

```dart
// settings_screen.dart
import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  int _displayStyle = 0;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('설정'),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 8),
              // 섹션 1: 일반
              CupertinoListSection.insetGrouped(
                header: const Text('일반'),
                children: [
                  CupertinoListTile.notched(
                    leading: const Icon(CupertinoIcons.bell_fill,
                        color: CupertinoColors.systemRed),
                    title: const Text('알림'),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                  CupertinoListTile.notched(
                    leading: const Icon(CupertinoIcons.moon_fill,
                        color: CupertinoColors.systemIndigo),
                    title: const Text('집중 모드'),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                ],
              ),
              // 섹션 2: 디스플레이
              CupertinoListSection.insetGrouped(
                header: const Text('디스플레이'),
                footer: const Text('다크 모드를 켜면 어두운 배경이 적용됩니다'),
                children: [
                  CupertinoListTile.notched(
                    leading: const Icon(CupertinoIcons.sun_max_fill,
                        color: CupertinoColors.systemYellow),
                    title: const Text('밝기 및 문자 크기'),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {},
                  ),
                  CupertinoListTile.notched(
                    title: const Text('다크 모드'),
                    trailing: CupertinoSwitch(
                      value: _isDarkMode,
                      onChanged: (v) => setState(() => _isDarkMode = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ]),
          ),
        ],
      ),
    );
  }
}
```
