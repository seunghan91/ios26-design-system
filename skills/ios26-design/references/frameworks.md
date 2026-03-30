# iOS 26 Framework Implementation Guide

## Svelte 5

### Setup
```bash
npm install @ios26_design_system/svelte
```

```svelte
<!-- +layout.svelte -->
<script>
  import '@ios26_design_system/svelte/tokens.css';
  import '@ios26_design_system/svelte/typography.css';
  import '@ios26_design_system/svelte/materials.css';
</script>

<slot />
```

### Liquid Glass Component
```svelte
<script>
  let { children, size = 'md' } = $props();
  const blur = { sm: 7, md: 12, lg: 14 };
</script>

<div
  class="ios26-liquid-glass-{size.substring(0,2)}"
  style="backdrop-filter: blur({blur[size]}px)"
>
  {@render children()}
</div>
```

### Tab Bar
```svelte
<script>
  let { tabs, active = 0 } = $props();
</script>

<nav class="ios26-liquid-glass-lg" style="height: 83px; padding-bottom: 34px;">
  {#each tabs as tab, i}
    <button
      class="ios26-caption2"
      class:active={i === active}
      onclick={() => active = i}
    >
      <span class="icon">{tab.icon}</span>
      <span>{tab.label}</span>
    </button>
  {/each}
</nav>

<style>
  nav {
    display: flex;
    justify-content: space-around;
    align-items: center;
    position: fixed;
    bottom: 0;
    width: 100%;
  }
  .active {
    color: var(--color-accent-blue);
  }
</style>
```

### Button
```svelte
<script>
  let { variant = 'filled', size = 'regular', children, ...rest } = $props();
  const heights = { mini: 28, small: 34, regular: 44, large: 50 };
  const radii = { mini: 8, small: 10, regular: 12, large: 14 };
</script>

<button
  class="ios26-body"
  style="
    height: {heights[size]}px;
    border-radius: {radii[size]}px;
    padding: 0 {size === 'mini' ? 12 : 20}px;
  "
  {...rest}
>
  {@render children()}
</button>
```

---

## Rails 8 + Hotwire

### Setup
```ruby
# config/importmap.rb
pin "@ios26_design_system/rails", to: "https://unpkg.com/@ios26_design_system/rails"
```

```css
/* app/assets/stylesheets/application.css */
@import "@ios26_design_system/rails/tokens.css";
```

### Toolbar Partial
```erb
<!-- app/views/shared/ios26/_toolbar.html.erb -->
<header
  class="ios26-toolbar"
  data-controller="ios26-toolbar"
  style="height: 44px; padding: 0 16px; display: flex; align-items: center;"
>
  <% if local_assigns[:back] %>
    <%= link_to "←", :back, class: "ios26-body" %>
  <% end %>
  <h1 class="ios26-headline" style="flex: 1; text-align: center;">
    <%= title %>
  </h1>
  <% if local_assigns[:action] %>
    <%= action %>
  <% end %>
</header>
```

### List Row Partial
```erb
<!-- app/views/shared/ios26/_list_row.html.erb -->
<div
  class="ios26-list-row"
  style="
    height: 44px;
    padding: 0 16px;
    display: flex;
    align-items: center;
    border-bottom: 0.5px solid var(--color-separator-opaque);
  "
>
  <span class="ios26-body" style="flex: 1;"><%= label %></span>
  <% if local_assigns[:value] %>
    <span class="ios26-body" style="color: var(--color-label-secondary);"><%= value %></span>
  <% end %>
  <% if local_assigns[:disclosure] %>
    <span style="color: var(--color-label-tertiary);">›</span>
  <% end %>
</div>
```

### Stimulus Controller (Dark Mode)
```js
// app/javascript/controllers/ios26_dark_mode_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const mq = window.matchMedia("(prefers-color-scheme: dark)")
    this.apply(mq)
    mq.addEventListener("change", (e) => this.apply(e))
  }

  apply(mq) {
    document.documentElement.dataset.theme = mq.matches ? "dark" : "light"
  }
}
```

---

## Svelte 5 + Inertia.js + Rails

### Setup
```bash
npm install @ios26_design_system/svelte-inertia
```

```svelte
<!-- resources/js/Layouts/AppLayout.svelte -->
<script>
  import '@ios26_design_system/svelte-inertia/tokens.css';
  import '@ios26_design_system/svelte-inertia/typography.css';
  import '@ios26_design_system/svelte-inertia/materials.css';

  let { children } = $props();
</script>

<div class="ios26-app" style="
  font-family: var(--font-family);
  background: var(--color-bg-grouped-primary);
  color: var(--color-label-primary);
  min-height: 100dvh;
">
  {@render children()}
</div>
```

### Page with Sheet
```svelte
<script>
  import { page } from '@inertiajs/svelte';
  let showSheet = $state(false);
</script>

<main style="padding: 0 16px;">
  <h1 class="ios26-large-title">{$page.props.title}</h1>
  <button onclick={() => showSheet = true}>Open Sheet</button>
</main>

{#if showSheet}
  <div
    class="ios26-overlay"
    style="background: var(--color-overlay-default);"
    onclick={() => showSheet = false}
  >
    <div
      class="ios26-liquid-glass-lg"
      style="
        position: fixed;
        bottom: 0;
        width: 100%;
        border-radius: 34px 34px 0 0;
        min-height: 50dvh;
        padding: 8px 16px 34px;
      "
      onclick|stopPropagation
    >
      <div style="width: 36px; height: 5px; background: var(--color-fill-tertiary);
        border-radius: 9999px; margin: 0 auto 16px;" />
      <!-- Sheet content -->
    </div>
  </div>
{/if}
```

---

## Flutter

### Setup
```yaml
# pubspec.yaml
dependencies:
  ios26_design: ^1.0.0
```

### Theme
```dart
import 'package:ios26_design/ios26_theme.dart';
import 'package:ios26_design/ios26_colors.dart';
import 'package:ios26_design/ios26_typography.dart';

MaterialApp(
  theme: iOS26Theme.light(),
  darkTheme: iOS26Theme.dark(),
  themeMode: ThemeMode.system,
);
```

### Liquid Glass Container
```dart
import 'dart:ui';

class LiquidGlassContainer extends StatelessWidget {
  final Widget child;
  final double frostRadius;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.frostRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: frostRadius, sigmaY: frostRadius),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
              ? const Color(0xFF000000).withOpacity(0.6)
              : const Color(0xFFF5F5F5).withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 40,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
```

### iOS 26 List Row
```dart
ListTile(
  title: Text('Wi-Fi', style: iOS26Typography.body),
  trailing: Text('Connected',
    style: iOS26Typography.body.copyWith(
      color: iOS26Colors.labelSecondary,
    ),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
  minVerticalPadding: 11,
);
```
