# Face ID — iOS 26 컴포넌트 스펙

> **References**
> - Tokens: `../tokens/colors.json`, `../tokens/spacing.json`, `../tokens/typography.json`, `../tokens/animations.json`
> - Inventory: `../../figma-ios26-pages.md`
> - Parent: `../PLAN.md`
> - Figma (최후 수단): `get_screenshot(fileKey="pDmGXdYu2k8xlf1SQoU9PW", nodeId="507:26011")`

---

## 1. Overview

iOS 26 Face ID UI는 생체 인증 화면 컴포넌트다. Figma 내 2개 variant로 구성된다.

| 항목 | 값 |
|------|-----|
| **Figma Node** | `507:26011` — COMPONENT_SET |
| **Variants 수** | 2 (인증 중 / 실패) |
| **섹션 그룹** | Face ID |
| **기술 프레임워크** | LocalAuthentication (UIKit/SwiftUI), local_auth (Flutter), WebAuthn (Web) |
| **지원 기기** | Face ID 탑재 iPhone / iPad (TrueDepth 카메라) |

---

## 2. Variants

| Variant | 설명 | 상태 |
|---------|------|------|
| **Authenticating** | Face ID 스캔 진행 중 | 초록색 테두리 pulse 애니메이션 |
| **Failed** | 인증 실패 | 빨간색 테두리 + shake 애니메이션 |

---

## 3. 치수 (Dimensions)

### 전체 오버레이

| 요소 | 값 |
|------|-----|
| 오버레이 크기 | 전체 화면 (fullscreen) |
| 배경 | 반투명 dimming: `rgba(0,0,0,0.45)` |
| 배경 blur | `backdrop-filter: blur(8px)` |

### 중앙 카드 (인증 패널)

| 요소 | 값 | 토큰 |
|------|-----|------|
| 너비 | 270pt | — |
| 내부 패딩 | 24pt | `spacing.scale.3` = 24pt |
| 코너 반경 | 20pt | `spacing.radius.semantic.sheet` |
| 배경 | `.systemBackground` (Liquid Glass) | `colors.backgrounds.primary` |

### Face ID 아이콘

| 요소 | 값 |
|------|-----|
| 아이콘 크기 | **81 × 81pt** |
| 아이콘 타입 | SF Symbol: `faceid` |
| 아이콘 색상 (기본) | `colors.labels.primary` |
| 아이콘 색상 (인증 중) | `accents.green` |
| 아이콘 색상 (실패) | `accents.red` |
| 아이콘 위치 | 카드 수직 중앙 상단 |

### 테두리 (Border Ring)

| 상태 | 색상 | 두께 | 반경 |
|------|------|------|------|
| 인증 중 | `#34C759` (`accents.green`) | 3pt | 아이콘 크기 + 6pt |
| 실패 | `#FF3B30` (`accents.red`) | 3pt | 아이콘 크기 + 6pt |

---

## 4. 텍스트

| 요소 | 텍스트 (기본) | 폰트 | 크기 | 굵기 | 색상 |
|------|-------------|------|------|------|------|
| 타이틀 | "Face ID" | SF Pro | 17pt | Semibold | `labels.primary` |
| 서브타이틀 (인증 중) | "iPhone의 잠금을 해제하려면 바라보십시오." | SF Pro | 13pt | Regular | `labels.secondary` |
| 서브타이틀 (실패) | "Face ID를 인식하지 못했습니다." | SF Pro | 13pt | Regular | `labels.secondary` |
| 간격 (아이콘 → 타이틀) | 20pt | — | — | — | — |
| 간격 (타이틀 → 서브타이틀) | 6pt | — | — | — | — |

---

## 5. 버튼

| 버튼 | 텍스트 | 스타일 | 높이 | 위치 |
|------|--------|--------|------|------|
| **취소 (Cancel)** | "취소" | Plain (`accents.blue`) | 44pt | 카드 하단 왼쪽 |
| **암호 사용 (Try Password)** | "암호 입력" | Plain (`accents.blue`) | 44pt | 카드 하단 오른쪽 |

버튼 간격: 구분선 (`colors.separators.opaque`) 1px로 분리.

---

## 6. 애니메이션

`animations.json` 참조.

### 인증 중 — Pulse 애니메이션

| 속성 | 값 |
|------|-----|
| 타입 | 링 scale pulse (0.95 → 1.05 → 0.95) |
| duration | `0.9s` |
| curve | `easeInOut` |
| 반복 | `.repeatForever(autoreverses: true)` |
| 불투명도 | 1.0 → 0.6 → 1.0 동기 페이드 |

### 실패 — Shake 애니메이션

| 속성 | 값 |
|------|-----|
| 타입 | 수평 이동 (translateX) |
| 시퀀스 | 0 → -10pt → 10pt → -8pt → 8pt → -4pt → 4pt → 0 |
| duration | `0.5s` 총 (`animations.duration.normal`) |
| curve | `easeInOut` |
| 반복 | 1회 |

### 오버레이 진입/퇴장

| 이벤트 | 효과 | duration |
|--------|------|---------|
| 진입 | fade in + scale 0.95 → 1.0 | `0.2s` (`animations.duration.fast`) |
| 성공 후 퇴장 | fade out + scale 1.0 → 0.95 | `0.15s` |
| 실패 후 퇴장 | fade out | `0.2s` |
| 취소 퇴장 | fade out + slide down | `0.25s` |

---

## 7. 개발자 구현 가이드

### 7-1. UIKit (Swift)

```swift
import LocalAuthentication
import UIKit

class FaceIDAuthViewController: UIViewController {

    private let context = LAContext()
    private var authError: NSError?

    // MARK: - UI Components
    private let dimOverlay: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let authCard: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBackground
        v.layer.cornerRadius = 20
        v.layer.cornerCurve = .continuous
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let faceIDImageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .thin)
        let iv = UIImageView(image: UIImage(systemName: "faceid", withConfiguration: config))
        iv.tintColor = .label
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let ringView: UIView = {
        let v = UIView()
        v.layer.borderWidth = 3
        v.layer.borderColor = UIColor.systemGreen.cgColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Face ID"
        l.font = .systemFont(ofSize: 17, weight: .semibold)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.text = "iPhone의 잠금을 해제하려면 바라보십시오."
        l.font = .systemFont(ofSize: 13)
        l.textColor = .secondaryLabel
        l.textAlignment = .center
        l.numberOfLines = 2
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    // MARK: - Authentication

    func authenticate() {
        guard context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &authError
        ) else {
            // Face ID 사용 불가 → 암호로 대체
            fallbackToPasscode()
            return
        }

        // Face ID 요청
        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "앱 잠금을 해제합니다."
        ) { [weak self] success, error in
            DispatchQueue.main.async {
                if success {
                    self?.handleSuccess()
                } else {
                    self?.handleFailure(error: error)
                }
            }
        }

        startPulseAnimation()
    }

    // MARK: - Animations

    func startPulseAnimation() {
        faceIDImageView.tintColor = .systemGreen
        ringView.layer.borderColor = UIColor.systemGreen.cgColor

        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.fromValue = 0.95
        pulse.toValue = 1.05
        pulse.duration = 0.9
        pulse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        ringView.layer.add(pulse, forKey: "pulse")

        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 1.0
        fade.toValue = 0.6
        fade.duration = 0.9
        fade.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        fade.autoreverses = true
        fade.repeatCount = .infinity
        ringView.layer.add(fade, forKey: "fade")
    }

    func startShakeAnimation(completion: @escaping () -> Void) {
        faceIDImageView.tintColor = .systemRed
        ringView.layer.removeAllAnimations()
        ringView.layer.borderColor = UIColor.systemRed.cgColor
        subtitleLabel.text = "Face ID를 인식하지 못했습니다."

        let shake = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shake.values = [0, -10, 10, -8, 8, -4, 4, 0]
        shake.keyTimes = [0, 0.1, 0.25, 0.4, 0.55, 0.7, 0.85, 1.0]
        shake.duration = 0.5
        shake.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        authCard.layer.add(shake, forKey: "shake")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion()
        }
    }

    private func handleSuccess() {
        ringView.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.15) {
            self.view.alpha = 0
            self.authCard.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }

    private func handleFailure(error: Error?) {
        startShakeAnimation {
            // 재시도 허용 또는 암호 fallback
        }
    }

    private func fallbackToPasscode() {
        // LAContext.evaluatePolicy(.deviceOwnerAuthentication) — 암호 포함
    }
}
```

### 7-2. SwiftUI

```swift
import LocalAuthentication
import SwiftUI

struct FaceIDOverlay: View {
    @Binding var isPresented: Bool
    var onSuccess: () -> Void
    var onFailure: () -> Void

    @State private var authState: AuthState = .idle
    @State private var isPulsing = false
    @State private var shakeOffset: CGFloat = 0

    enum AuthState {
        case idle, authenticating, failed, success
    }

    var body: some View {
        ZStack {
            // Dimming 오버레이
            Color.black.opacity(0.45)
                .ignoresSafeArea()
                .blur(radius: 0)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()

            // 인증 카드
            VStack(spacing: 0) {
                Spacer().frame(height: 24)

                // Face ID 아이콘 + 링
                ZStack {
                    Circle()
                        .stroke(ringColor, lineWidth: 3)
                        .frame(width: 93, height: 93)  // 81 + 6*2
                        .scaleEffect(isPulsing ? 1.05 : 0.95)
                        .opacity(isPulsing ? 0.6 : 1.0)
                        .animation(
                            authState == .authenticating
                                ? .easeInOut(duration: 0.9).repeatForever(autoreverses: true)
                                : .default,
                            value: isPulsing
                        )

                    Image(systemName: "faceid")
                        .font(.system(size: 60, weight: .thin))
                        .foregroundStyle(iconColor)
                        .frame(width: 81, height: 81)
                }

                Spacer().frame(height: 20)

                Text("Face ID")
                    .font(.system(size: 17, weight: .semibold))

                Spacer().frame(height: 6)

                Text(subtitleText)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                Spacer().frame(height: 24)

                Divider()

                // 버튼 영역
                HStack(spacing: 0) {
                    Button("취소") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .foregroundStyle(.blue)

                    Divider().frame(height: 44)

                    Button("암호 입력") {
                        authenticateWithPasscode()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .foregroundStyle(.blue)
                }
            }
            .frame(width: 270)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .offset(x: shakeOffset)
        }
        .onAppear { startAuthentication() }
    }

    // MARK: - Computed

    var ringColor: Color {
        switch authState {
        case .authenticating: return .green
        case .failed:         return .red
        default:              return .clear
        }
    }

    var iconColor: Color {
        switch authState {
        case .failed: return .red
        default:      return .primary
        }
    }

    var subtitleText: String {
        authState == .failed
            ? "Face ID를 인식하지 못했습니다."
            : "iPhone의 잠금을 해제하려면 바라보십시오."
    }

    // MARK: - Logic

    func startAuthentication() {
        authState = .authenticating
        isPulsing = true

        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics, error: &error
        ) else { return }

        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "앱 잠금을 해제합니다."
        ) { success, _ in
            DispatchQueue.main.async {
                isPulsing = false
                if success {
                    authState = .success
                    onSuccess()
                    dismiss()
                } else {
                    authState = .failed
                    triggerShake()
                }
            }
        }
    }

    func triggerShake() {
        withAnimation(.easeInOut(duration: 0.05)) { shakeOffset = -10 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation(.easeInOut(duration: 0.08)) { shakeOffset = 10 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.13) {
            withAnimation(.easeInOut(duration: 0.08)) { shakeOffset = -8 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.21) {
            withAnimation(.easeInOut(duration: 0.08)) { shakeOffset = 8 }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.29) {
            withAnimation(.easeInOut(duration: 0.08)) { shakeOffset = 0 }
        }
    }

    func authenticateWithPasscode() {
        let context = LAContext()
        context.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: "앱 잠금을 해제합니다."
        ) { success, _ in
            DispatchQueue.main.async {
                if success { onSuccess() }
                dismiss()
            }
        }
    }

    func dismiss() {
        withAnimation(.easeIn(duration: 0.2)) {
            isPresented = false
        }
    }
}

// 사용 예시
struct ContentView: View {
    @State private var showFaceID = false

    var body: some View {
        Button("잠금 해제") { showFaceID = true }
            .fullScreenCover(isPresented: $showFaceID) {
                FaceIDOverlay(
                    isPresented: $showFaceID,
                    onSuccess: { print("인증 성공") },
                    onFailure: { print("인증 실패") }
                )
                .background(.clear)
            }
    }
}
```

### 7-3. Flutter (`local_auth` 패키지)

```dart
// pubspec.yaml
// dependencies:
//   local_auth: ^2.3.0

import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class FaceIDAuthService {
  final _localAuth = LocalAuthentication();

  /// Face ID / 생체인증 가능 여부 확인
  Future<bool> canAuthenticate() async {
    final isAvailable = await _localAuth.canCheckBiometrics;
    final isDeviceSupported = await _localAuth.isDeviceSupported();
    return isAvailable && isDeviceSupported;
  }

  /// 인증 실행
  Future<bool> authenticate({
    String reason = '앱 잠금을 해제합니다.',
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: false,   // false = Face ID 실패 시 암호 허용
          stickyAuth: true,       // 앱이 백그라운드 갔다 와도 인증 유지
          sensitiveTransaction: false,
        ),
      );
    } catch (e) {
      return false;
    }
  }

  /// 등록된 생체인증 타입 확인
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _localAuth.getAvailableBiometrics();
    // [BiometricType.face] → Face ID
    // [BiometricType.fingerprint] → Touch ID
    // [BiometricType.strong] → 강력한 생체인증 (Android)
  }
}

// 커스텀 Face ID UI 오버레이 위젯
class FaceIDOverlay extends StatefulWidget {
  final VoidCallback onSuccess;
  final VoidCallback onCancel;

  const FaceIDOverlay({
    super.key,
    required this.onSuccess,
    required this.onCancel,
  });

  @override
  State<FaceIDOverlay> createState() => _FaceIDOverlayState();
}

class _FaceIDOverlayState extends State<FaceIDOverlay>
    with TickerProviderStateMixin {
  final _service = FaceIDAuthService();
  bool _isFailed = false;
  late AnimationController _pulseController;
  late AnimationController _shakeController;
  late Animation<double> _pulseAnim;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();

    // Pulse 애니메이션
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _pulseAnim = Tween(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Shake 애니메이션
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 10),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 10, end: -8),  weight: 15),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8),   weight: 15),
      TweenSequenceItem(tween: Tween(begin: 8, end: -4),   weight: 15),
      TweenSequenceItem(tween: Tween(begin: -4, end: 4),   weight: 15),
      TweenSequenceItem(tween: Tween(begin: 4, end: 0),    weight: 15),
    ]).animate(_shakeController);

    _authenticate();
  }

  Future<void> _authenticate() async {
    final success = await _service.authenticate();
    if (!mounted) return;
    if (success) {
      widget.onSuccess();
    } else {
      setState(() => _isFailed = true);
      _pulseController.stop();
      _shakeController.forward();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 딤 오버레이
        GestureDetector(
          onTap: widget.onCancel,
          child: Container(color: Colors.black54),
        ),
        // 카드
        Center(
          child: AnimatedBuilder(
            animation: _shakeAnim,
            builder: (_, child) => Transform.translate(
              offset: Offset(_shakeAnim.value, 0),
              child: child,
            ),
            child: Container(
              width: 270,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 24),
                  // 아이콘 + 링
                  AnimatedBuilder(
                    animation: _pulseAnim,
                    builder: (_, child) => Transform.scale(
                      scale: _isFailed ? 1.0 : _pulseAnim.value,
                      child: child,
                    ),
                    child: Container(
                      width: 93,
                      height: 93,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _isFailed ? Colors.red : Colors.green,
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        Icons.face_retouching_natural,
                        size: 60,
                        color: _isFailed ? Colors.red : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Face ID',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      _isFailed
                          ? 'Face ID를 인식하지 못했습니다.'
                          : 'iPhone의 잠금을 해제하려면 바라보십시오.',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 1),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: widget.onCancel,
                          child: const Text('취소'),
                        ),
                      ),
                      const VerticalDivider(width: 1, thickness: 1),
                      Expanded(
                        child: TextButton(
                          onPressed: _authenticate,
                          child: const Text('암호 입력'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
```

### 7-4. Svelte / Web (WebAuthn 근사치)

> 웹에는 Face ID 직접 호출 API가 없다. **Web Authentication API (WebAuthn)** 를 사용해 플랫폼 인증자(Face ID / Touch ID / Windows Hello)를 호출하는 근사적 구현이다.

```typescript
// lib/webauthn.ts
export async function authenticateWithPlatformAuthenticator(): Promise<boolean> {
  if (!window.PublicKeyCredential) {
    console.warn('WebAuthn 미지원 브라우저');
    return false;
  }

  // 플랫폼 인증자(Face ID 등) 가용 여부 확인
  const available =
    await PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable();
  if (!available) return false;

  try {
    // 서버에서 challenge 받아오기 (실제 구현에서는 서버 API 호출)
    const challenge = crypto.getRandomValues(new Uint8Array(32));

    const assertion = await navigator.credentials.get({
      publicKey: {
        challenge,
        timeout: 60000,
        rpId: window.location.hostname,
        allowCredentials: [],         // 빈 배열 = 등록된 모든 인증자 허용
        userVerification: 'required', // Face ID / PIN 필수
      },
    });

    return assertion !== null;
  } catch (e) {
    // NotAllowedError: 사용자 취소 또는 타임아웃
    return false;
  }
}
```

```svelte
<!-- FaceIDOverlay.svelte -->
<script lang="ts">
  import { createEventDispatcher, onMount } from 'svelte';
  import { authenticateWithPlatformAuthenticator } from '$lib/webauthn';

  const dispatch = createEventDispatcher<{
    success: void;
    cancel: void;
  }>();

  let state: 'authenticating' | 'failed' = 'authenticating';
  let shaking = false;

  onMount(() => { runAuth(); });

  async function runAuth() {
    state = 'authenticating';
    const ok = await authenticateWithPlatformAuthenticator();
    if (ok) {
      dispatch('success');
    } else {
      state = 'failed';
      shaking = true;
      setTimeout(() => (shaking = false), 500);
    }
  }
</script>

<!-- 딤 오버레이 -->
<div
  class="fixed inset-0 z-50 flex items-center justify-center"
  style="background: rgba(0,0,0,0.45); backdrop-filter: blur(8px);"
>
  <!-- 카드 -->
  <div
    class="w-[270px] rounded-[20px] overflow-hidden"
    class:shake={shaking}
    style="background: var(--color-background-primary);"
  >
    <div class="flex flex-col items-center px-6 pt-6 pb-0 gap-0">
      <!-- 아이콘 + 링 -->
      <div
        class="relative flex items-center justify-center mb-5"
        style="width:93px;height:93px;"
      >
        <div
          class="absolute inset-0 rounded-full border-[3px]"
          class:ring-green={state === 'authenticating'}
          class:ring-red={state === 'failed'}
          class:pulse={state === 'authenticating'}
        ></div>
        <svg width="60" height="60" viewBox="0 0 60 60" fill="none"
          class:text-green-500={state === 'authenticating'}
          class:text-red-500={state === 'failed'}
        >
          <!-- Face ID SF Symbol 근사 SVG -->
          <rect x="4"  y="4"  width="14" height="3" rx="1.5" fill="currentColor"/>
          <rect x="42" y="4"  width="14" height="3" rx="1.5" fill="currentColor"/>
          <rect x="4"  y="53" width="14" height="3" rx="1.5" fill="currentColor"/>
          <rect x="42" y="53" width="14" height="3" rx="1.5" fill="currentColor"/>
          <rect x="4"  y="4"  width="3"  height="14" rx="1.5" fill="currentColor"/>
          <rect x="53" y="4"  width="3"  height="14" rx="1.5" fill="currentColor"/>
          <rect x="4"  y="42" width="3"  height="14" rx="1.5" fill="currentColor"/>
          <rect x="53" y="42" width="3"  height="14" rx="1.5" fill="currentColor"/>
          <circle cx="22" cy="24" r="3" fill="currentColor"/>
          <circle cx="38" cy="24" r="3" fill="currentColor"/>
          <path d="M20 38 Q30 44 40 38" stroke="currentColor" stroke-width="2.5"
            stroke-linecap="round" fill="none"/>
          <path d="M30 28 L30 34" stroke="currentColor" stroke-width="2.5"
            stroke-linecap="round"/>
        </svg>
      </div>

      <p class="text-[17px] font-semibold">Face ID</p>
      <p class="text-[13px] text-secondary text-center mt-1.5 mb-6">
        {state === 'failed'
          ? 'Face ID를 인식하지 못했습니다.'
          : 'iPhone의 잠금을 해제하려면 바라보십시오.'}
      </p>
    </div>

    <hr style="border-color: var(--color-separator-opaque);" />

    <div class="flex">
      <button
        class="flex-1 h-11 text-[#007AFF] text-[17px]"
        on:click={() => dispatch('cancel')}
      >취소</button>
      <div style="width:1px;background:var(--color-separator-opaque);"></div>
      <button
        class="flex-1 h-11 text-[#007AFF] text-[17px]"
        on:click={runAuth}
      >암호 입력</button>
    </div>
  </div>
</div>

<style>
  .pulse {
    animation: pulse 0.9s ease-in-out infinite alternate;
  }
  @keyframes pulse {
    from { transform: scale(0.95); opacity: 1.0; }
    to   { transform: scale(1.05); opacity: 0.6; }
  }

  .ring-green { border-color: #34C759; }
  .ring-red   { border-color: #FF3B30; }

  .shake {
    animation: shake 0.5s ease-in-out;
  }
  @keyframes shake {
    0%   { transform: translateX(0); }
    10%  { transform: translateX(-10px); }
    25%  { transform: translateX(10px); }
    40%  { transform: translateX(-8px); }
    55%  { transform: translateX(8px); }
    70%  { transform: translateX(-4px); }
    85%  { transform: translateX(4px); }
    100% { transform: translateX(0); }
  }
</style>
```

---

## 8. Info.plist 권한 설정

```xml
<!-- iOS: Info.plist -->
<key>NSFaceIDUsageDescription</key>
<string>앱 잠금 해제 및 보안 인증에 Face ID를 사용합니다.</string>
```

```yaml
# Flutter: ios/Runner/Info.plist (project.yml 사용 시)
NSFaceIDUsageDescription: "앱 잠금 해제 및 보안 인증에 Face ID를 사용합니다."
```

---

## 9. 에러 핸들링

| LAError 코드 | 의미 | 권장 처리 |
|-------------|------|---------|
| `.authenticationFailed` | 얼굴 불일치 | shake 애니메이션 → 재시도 안내 |
| `.userCancel` | 사용자 취소 | 오버레이 닫기 |
| `.userFallback` | "암호 입력" 선택 | `.deviceOwnerAuthentication` 재호출 |
| `.systemCancel` | 시스템에 의한 취소 (전화 수신 등) | 자동 재표시 옵션 제공 |
| `.biometryNotAvailable` | Face ID 하드웨어 없음 | 암호 전용 UI로 대체 |
| `.biometryNotEnrolled` | Face ID 미등록 | "설정 > Face ID" 안내 알림 |
| `.biometryLockout` | 시도 횟수 초과 잠금 | `.deviceOwnerAuthentication` 강제 전환 |

---

## 10. 주의 사항

| 항목 | 내용 |
|------|------|
| 메인 스레드 | `evaluatePolicy` 콜백은 백그라운드 → UI 업데이트는 `DispatchQueue.main.async` 필수 |
| Context 재사용 | `LAContext`는 1회 인증 후 재사용 불가. 재시도 시 새 인스턴스 생성 |
| Simulator | Face ID 시뮬레이터: Hardware > Face ID > Enrolled 체크 후 "Matching Face" 실행 |
| App Extension | LAContext는 App Extension 내에서도 동작하나, `stickyAuth` 미지원 |
| Privacy Manifest | iOS 17+ 앱은 `PrivacyInfo.xcprivacy`에 `NSPrivacyAccessedAPIType` 불필요 (LA는 해당 없음) |
