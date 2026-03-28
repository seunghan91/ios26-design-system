# iOS 26 Design System -- Progress Tracker

> Plan: [PLAN.md](./PLAN.md)

## ✅ ALL PHASES COMPLETE

---

## Phase 1: Design Tokens

| # | Task | Status | Notes |
|---|------|--------|-------|
| 1.1 | Light mode 컬러 추출 | DONE | 50 paint styles 추출 완료 |
| 1.2 | Dark mode 컬러 추출 | DONE | 79 variables x 4 modes (Light/Dark/IC-Light/IC-Dark) |
| 1.3 | Typography 토큰 추출 | DONE | 50+ text styles + Dynamic Type 7 sizes |
| 1.4 | Material 토큰 추출 | DONE | Liquid Glass vars + Blur 레이어 분석 완료 |
| 1.5 | Spacing/Radius 토큰 추출 | DONE | Kit 변수 25개 + 컴포넌트 padding 분석 |
| 1.6 | Animation 토큰 정의 | DONE | Apple HIG 기반 spring/duration/easing 정의 |
| 1.7 | tokens/*.json 생성 | DONE | colors, typography, materials, spacing, animations — 5개 완료 |
| 1.8 | Svelte 토큰 파일 | DONE | tokens.css, typography.css, materials.css |
| 1.9 | Rails 토큰 파일 | DONE | tokens.css |
| 1.10 | Svelte+Inertia 토큰 파일 | DONE | tokens.css, typography.css, materials.css + components/layout/README |
| 1.11 | Flutter 토큰 파일 | DONE | ios26_colors.dart, ios26_typography.dart |

## Phase 2: Components
**담당: 사용자 직접 진행**

> References (작업 시 이 순서로 참조):
> 1. `tokens/*.json` — 토큰 값
> 2. `../../figma-ios26-pages.md` — 컴포넌트 variant 목록 + Node ID
> 3. `../../ios26-design-guide.md` — 전체 개요
> 4. Figma MCP (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="...")`

| Priority | Component | Figma Node | Variants | Status |
|----------|-----------|-----------|---------|--------|
| P0 | Tab Bar (iPhone) | `3:70967` | 16 | **DONE** `specs/tab-bar.md` |
| P0 | Toolbar (Top iPhone) | `1:54472` | 5 | **DONE** `specs/toolbar.md` |
| P0 | Button - Content Area + Liquid Glass | `40:58696` | 144+4 | **DONE** `specs/button.md` |
| P0 | List Row | `550:50430` | 2 | **DONE** `specs/list-row.md` |
| P1 | Alert | `63:57121` | 2 | **DONE** `specs/alert.md` |
| P1 | Sheets | `507:24684` | — | **DONE** `specs/sheet.md` |
| P1 | Segmented Control | `6:57374` | 14 | **DONE** `specs/segmented-control.md` |
| P1 | Notifications | `507:24678` | — | **DONE** `specs/notifications.md` |
| P2 | Toggle | `507:24690` | — | **DONE** `specs/toggle.md` |
| P2 | Text Field | `553:22762` | — | **DONE** `specs/text-field.md` |
| P2 | Sliders | `7:53847` | 5 | **DONE** `specs/sliders.md` |
| P2 | Steppers | `507:24687` | — | **DONE** `specs/steppers.md` |
| P2 | Progress Indicators | `507:24682` | — | **DONE** `specs/progress-indicators.md` |
| P2 | Page Controls | `488:51848` | 35 | **DONE** `specs/page-controls.md` |
| P3 | App Icons | `2402:17543` | 2 | **DONE** `specs/app-icons.md` |
| P3 | Popovers | `61:65421` | 12 | **DONE** `specs/popovers.md` |

## Phase 3: Templates ✅ DONE

| 파일 | 내용 |
|------|------|
| `templates/standard-screen.md` | Status Bar + Nav Bar + Content + Tab Bar |
| `templates/sheet-overlay.md` | Detent 25/50/100%, Liquid Glass, 키보드 avoidance |
| `templates/navigation-stack.md` | Push/Pop 전환, Large Title collapse |
| `templates/tab-bar-layout.md` | Liquid Glass 인디케이터 morphing, 2~5탭 |
| `templates/alert-modal.md` | 270pt 카드, scale+fade 애니메이션 |

## Phase 4: Sections ✅ DONE

| 파일 | 줄 수 | 핵심 내용 |
|------|-------|----------|
| `sections/status-bar.md` | 354 | 높이 54/44/20/24pt, Dynamic Island, light/dark 전환 |
| `sections/navigation-region.md` | 496 | Standard 44pt / Large Title 96pt, Liquid Glass, collapse spring |
| `sections/content-region.md` | 551 | Safe Area inset, 섹션 간격, row 최소 44pt |
| `sections/overlay-region.md` | 683 | Sheet detents 25/50/100%, Alert 270pt, dimming |
| `sections/system-region.md` | 694 | Home Indicator 134×5pt, Dynamic Island 확장, 키보드 216pt |

## Phase 5: Pages

### iPhone Examples ✅ DONE
| 파일 | 줄 수 |
|------|-------|
| `iphone-examples/home-feed.md` | 436 |
| `iphone-examples/settings-screen.md` | 459 |
| `iphone-examples/detail-view.md` | 438 |
| `iphone-examples/sheet-form.md` | 469 |
| `iphone-examples/alert-flow.md` | 619 |

### iPad Examples ✅ DONE
| 파일 | 줄 수 |
|------|-------|
| `ipad-examples/ipad-split-view.md` | 401 |
| `ipad-examples/ipad-popover-menu.md` | 468 |
| `ipad-examples/ipad-multitasking.md` | 582 |

---

## Deliverables Tracker

| Deliverable | Path | Status |
|-------------|------|--------|
| Raw Figma Inventory | `../figma-ios26-pages.md` | DONE |
| Design Guide (overview) | `../ios26-design-guide.md` | Phase 1 draft |
| Plan + Roadmap | `PLAN.md` | DONE |
| Progress | `PROGRESS.md` | Active |
| tokens/colors.json | `tokens/colors.json` | DONE |
| tokens/typography.json | `tokens/typography.json` | DONE |
| tokens/materials.json | `tokens/materials.json` | DONE |
| tokens/spacing.json | `tokens/spacing.json` | DONE |
| tokens/animations.json | `tokens/animations.json` | DONE |
| svelte/ (5 files) | `svelte/` | DONE |
| rails/ (5 files) | `rails/` | DONE |
| svelte-inertia/ | `svelte-inertia/` | IN PROGRESS |
| flutter/ (6 files) | `flutter/` | DONE |

---

## Log

- 2026-03-27: Figma MCP 연결, 전체 페이지 구조 추출 (45 pages)
- 2026-03-27: 로컬 스타일 추출 (50 colors, 50+ text styles, materials)
- 2026-03-27: figma-ios26-pages.md 전체 variant 사전 구조화 완료
- 2026-03-27: ios26-design-guide.md Phase 1 초안 작성
- 2026-03-27: 프레임워크별 가이드 생성 (svelte, rails, flutter 완료)
- 2026-03-27: PLAN.md + PROGRESS.md 작성
- 2026-03-28: Phase 1 완료 — tokens/ 5개 JSON (colors, typography, materials, spacing, animations) 생성
- 2026-03-28: Phase 2 P0+P1 완료 — 8개 컴포넌트 스펙 (tab-bar, toolbar, button, list-row, alert, sheet, segmented-control, notifications)
- 2026-03-28: Phase 2 P2+P3 완료 — 8개 추가 (toggle, text-field, sliders, steppers, progress-indicators, page-controls, app-icons, popovers)
- 2026-03-28: Phase 3 완료 — 5개 템플릿 (standard-screen, sheet-overlay, navigation-stack, tab-bar-layout, alert-modal)
- 2026-03-28: Phase 4 완료 — 5개 섹션 스펙 (status-bar, navigation-region, content-region, overlay-region, system-region)
- 2026-03-28: Phase 5 완료 — iPhone 5개 + iPad 3개 페이지 레시피 (총 3,872줄)
