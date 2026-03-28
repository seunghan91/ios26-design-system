# iOS 26 Design System for Svelte 5

Design tokens, typography, materials, and component patterns extracted from the Apple iOS & iPadOS 26 Figma Community Kit, adapted for pure Svelte 5 (runes mode).

---

## Files

| File | Purpose |
|------|---------|
| `tokens.css` | CSS custom properties for colors, typography, spacing, materials |
| `typography.css` | 11 text style classes with emphasized, italic, and loose modifiers |
| `materials.css` | Liquid Glass effects and background material blur classes |
| `components.svelte.md` | Component mapping guide with Svelte 5 `$props()` signatures |

---

## Setup

### 1. Import tokens into your app entry point

In your root layout or `app.css`:

```css
@import './path-to/tokens.css';
@import './path-to/typography.css';
@import './path-to/materials.css';
```

Or in `+layout.svelte`:

```svelte
<script>
  import './path-to/tokens.css';
  import './path-to/typography.css';
  import './path-to/materials.css';
</script>
```

### 2. Framework requirements

- **Svelte 5** with runes mode enabled (default in Svelte 5)
- **SvelteKit** with `@sveltejs/adapter-static` for Tauri integration
- No external CSS framework required -- all styles are vanilla CSS custom properties

---

## Usage Examples

### Basic screen with tokens

```svelte
<script>
  let count = $state(0);
</script>

<div class="screen">
  <header class="toolbar liquid-glass-large">
    <h1 class="text-headline">Settings</h1>
  </header>

  <main class="content">
    <section class="card">
      <h2 class="text-title3 emphasized">Account</h2>
      <p class="text-body text-secondary">Manage your profile and preferences.</p>
    </section>

    <button
      class="action-button"
      onclick={() => count++}
    >
      Tapped {count} times
    </button>
  </main>
</div>

<style>
  .screen {
    min-height: 100vh;
    background-color: var(--bg-grouped-primary);
    color: var(--label-primary);
    font-family: var(--font-family);
  }

  .toolbar {
    display: flex;
    align-items: center;
    justify-content: center;
    height: var(--toolbar-height);
    padding: 0 var(--space-4);
  }

  .content {
    padding: var(--space-4);
    display: flex;
    flex-direction: column;
    gap: var(--space-4);
  }

  .card {
    background-color: var(--bg-grouped-secondary);
    border-radius: 10px;
    padding: var(--space-4);
    display: flex;
    flex-direction: column;
    gap: var(--space-2);
  }

  .action-button {
    background-color: var(--color-blue);
    color: var(--white);
    border: none;
    border-radius: 10px;
    padding: var(--space-3) var(--space-5);
    font-size: var(--text-body);
    line-height: var(--lh-body);
    font-weight: var(--weight-semibold);
    cursor: pointer;
    transition: opacity 0.15s ease;
  }

  .action-button:active {
    opacity: 0.7;
  }
</style>
```

### Grouped list with sections

```svelte
<div class="list">
  <div class="list-header text-footnote text-secondary">GENERAL</div>
  <div class="list-group">
    <div class="list-row">
      <span class="text-body">Notifications</span>
      <span class="text-body text-secondary">On</span>
    </div>
    <div class="list-separator"></div>
    <div class="list-row">
      <span class="text-body">Sounds</span>
      <span class="text-body text-secondary">Default</span>
    </div>
  </div>
</div>

<style>
  .list {
    padding: 0 var(--space-4);
  }

  .list-header {
    padding: var(--space-2) var(--space-4) var(--space-1);
    text-transform: uppercase;
  }

  .list-group {
    background-color: var(--bg-grouped-secondary);
    border-radius: 10px;
    overflow: hidden;
  }

  .list-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    min-height: var(--list-row-height);
    padding: 0 var(--space-4);
  }

  .list-separator {
    height: var(--separator-height);
    background-color: var(--separator-opaque);
    margin-left: var(--space-4);
  }
</style>
```

### Liquid Glass toolbar

```svelte
<nav class="bottom-bar liquid-glass-large">
  <button class="bar-item active">
    <span>Home</span>
  </button>
  <button class="bar-item">
    <span>Search</span>
  </button>
  <button class="bar-item">
    <span>Profile</span>
  </button>
</nav>

<style>
  .bottom-bar {
    position: fixed;
    bottom: var(--space-6);
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: var(--space-6);
    padding: var(--space-3) var(--space-6);
  }

  .bar-item {
    background: none;
    border: none;
    color: var(--label-secondary);
    font-size: var(--text-caption2);
    cursor: pointer;
  }

  .bar-item.active {
    color: var(--color-blue);
  }
</style>
```

---

## Dark Mode

Dark mode works automatically via `@media (prefers-color-scheme: dark)` overrides defined in `tokens.css`. All CSS variables update without any JavaScript. Components using these variables will adapt seamlessly.

To test dark mode in development, toggle your OS appearance or use browser DevTools to emulate `prefers-color-scheme: dark`.

---

## Design Tokens Quick Reference

| Category | Variables | Count |
|----------|----------|-------|
| System Colors | `--color-red` through `--color-brown` | 12 |
| Labels | `--label-primary` through `--label-quaternary` | 4 |
| Backgrounds | `--bg-primary`, `--bg-grouped-*` | 6 |
| Fills | `--fill-primary` through `--fill-quaternary` | 4 |
| Grays | `--black`, `--gray` through `--gray-6`, `--white` | 8 |
| Typography sizes | `--text-large-title` through `--text-caption2` | 11 |
| Spacing | `--space-0` through `--space-16` | 12 |
| Materials | `--blur-*`, `--glass-*` | 20+ |
