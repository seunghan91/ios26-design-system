# iOS 26 Component Mapping — Svelte 5

Maps each iOS 26 component to a pure Svelte 5 implementation approach using runes mode (`$props()`, `$state()`, `$derived()`). All components consume CSS tokens from `tokens.css`.

---

## Navigation & Structure

### Toolbar (Top)

Top navigation bar with optional Large Title mode. Supports leading/trailing action slots.

```svelte
<!-- Toolbar.svelte -->
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Props {
    title: string;
    largeTitle?: boolean;
    /** Collapses large title on scroll. Bind to scroll container's scrollY. */
    scrollY?: number;
    leading?: Snippet;
    trailing?: Snippet;
  }

  let {
    title,
    largeTitle = false,
    scrollY = 0,
    leading,
    trailing,
  }: Props = $props();

  let collapsed = $derived(scrollY > 44);
</script>

<header class="toolbar liquid-glass-large" class:collapsed>
  <div class="toolbar-leading">
    {#if leading}{@render leading()}{/if}
  </div>
  <div class="toolbar-title text-headline">{title}</div>
  <div class="toolbar-trailing">
    {#if trailing}{@render trailing()}{/if}
  </div>
</header>
{#if largeTitle && !collapsed}
  <div class="toolbar-large-title text-large-title emphasized">{title}</div>
{/if}
```

**Key patterns:**
- `largeTitle` mode renders an additional large title below the bar
- `scrollY` binding enables collapse-on-scroll behavior
- `leading`/`trailing` are Svelte 5 snippet props for action slots


### TabBar

Bottom tab bar using Liquid Glass floating style. Manages active tab state internally.

```svelte
<!-- TabBar.svelte -->
<script lang="ts">
  interface TabItem {
    id: string;
    label: string;
    icon: string;
    /** SF Symbol name or SVG path */
  }

  interface Props {
    items: TabItem[];
    active?: string;
    onchange?: (id: string) => void;
  }

  let {
    items,
    active = $bindable(items[0]?.id ?? ''),
    onchange,
  }: Props = $props();
</script>

<nav class="tabbar liquid-glass-large">
  {#each items as item (item.id)}
    <button
      class="tabbar-item"
      class:active={active === item.id}
      onclick={() => { active = item.id; onchange?.(item.id); }}
    >
      <span class="tabbar-icon">{item.icon}</span>
      <span class="tabbar-label text-caption2">{item.label}</span>
    </button>
  {/each}
</nav>
```

**Key patterns:**
- `$bindable()` for two-way active tab binding
- Floating Liquid Glass style (not docked to bottom edge)
- `onchange` callback for parent-driven navigation


### Segmented Control

Horizontal segmented selector with animated indicator.

```svelte
<!-- SegmentedControl.svelte -->
<script lang="ts">
  interface Props {
    segments: string[];
    selected?: number;
    onchange?: (index: number) => void;
  }

  let {
    segments,
    selected = $bindable(0),
    onchange,
  }: Props = $props();
</script>

<div class="segmented-control" role="tablist">
  {#each segments as label, i (label)}
    <button
      role="tab"
      class="segment text-subheadline"
      class:active={selected === i}
      aria-selected={selected === i}
      onclick={() => { selected = i; onchange?.(i); }}
    >
      {label}
    </button>
  {/each}
</div>
```


---

## Content & Lists

### ListRow

Single list row with leading and trailing content slots. Supports disclosure indicator and separator control.

```svelte
<!-- ListRow.svelte -->
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Props {
    /** Show right chevron disclosure indicator */
    disclosure?: boolean;
    /** Show bottom separator */
    separator?: boolean;
    leading?: Snippet;
    trailing?: Snippet;
    children: Snippet;
    onclick?: () => void;
  }

  let {
    disclosure = false,
    separator = true,
    leading,
    trailing,
    children,
    onclick,
  }: Props = $props();
</script>

<div
  class="list-row"
  class:has-separator={separator}
  role={onclick ? 'button' : undefined}
  tabindex={onclick ? 0 : undefined}
  onclick={onclick}
  onkeydown={(e) => { if (e.key === 'Enter' && onclick) onclick(); }}
>
  {#if leading}
    <div class="list-row-leading">{@render leading()}</div>
  {/if}
  <div class="list-row-content text-body">
    {@render children()}
  </div>
  {#if trailing}
    <div class="list-row-trailing text-body text-secondary">{@render trailing()}</div>
  {/if}
  {#if disclosure}
    <div class="list-row-disclosure text-tertiary">&#8250;</div>
  {/if}
</div>
```

**Key patterns:**
- `children` snippet is the main content (Svelte 5 default slot)
- `leading` for icons/avatars, `trailing` for secondary values
- Keyboard accessible when `onclick` is provided


### ListSection

Groups rows under an optional section header and footer.

```svelte
<!-- ListSection.svelte -->
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Props {
    header?: string;
    footer?: string;
    children: Snippet;
  }

  let { header, footer, children }: Props = $props();
</script>

<div class="list-section">
  {#if header}
    <div class="list-section-header text-footnote text-secondary">{header}</div>
  {/if}
  <div class="list-section-content">
    {@render children()}
  </div>
  {#if footer}
    <div class="list-section-footer text-footnote text-secondary">{footer}</div>
  {/if}
</div>
```


---

## Actions & Inputs

### Button

Supports iOS 26 button variants: content-area (filled), liquid-glass, and text-only.

```svelte
<!-- Button.svelte -->
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Props {
    variant?: 'filled' | 'gray' | 'tinted' | 'plain' | 'liquid-glass';
    size?: 'small' | 'medium' | 'large';
    disabled?: boolean;
    children: Snippet;
    onclick?: () => void;
  }

  let {
    variant = 'filled',
    size = 'medium',
    disabled = false,
    children,
    onclick,
  }: Props = $props();
</script>

<button
  class="btn btn-{variant} btn-{size}"
  {disabled}
  onclick={onclick}
>
  {@render children()}
</button>
```

**Variant mapping:**
| Variant | iOS 26 Equivalent | Background | Text Color |
|---------|-------------------|------------|------------|
| `filled` | Button - Content Area (Filled) | `--color-blue` | `--white` |
| `gray` | Button - Content Area (Gray) | `--fill-primary` | `--color-blue` |
| `tinted` | Button - Content Area (Tinted) | `--color-blue` @ 15% | `--color-blue` |
| `plain` | Button - Content Area (Plain) | transparent | `--color-blue` |
| `liquid-glass` | Button - Liquid Glass | liquid glass effect | `--label-primary` |

**Size mapping:**
| Size | Padding | Font | Min Height |
|------|---------|------|------------|
| `small` | 6px 12px | text-subheadline | 28px |
| `medium` | 8px 16px | text-body | 36px |
| `large` | 12px 20px | text-body emphasized | 50px |


### Toggle

iOS-style toggle switch with bindable checked state.

```svelte
<!-- Toggle.svelte -->
<script lang="ts">
  interface Props {
    checked?: boolean;
    disabled?: boolean;
    label?: string;
    onchange?: (checked: boolean) => void;
  }

  let {
    checked = $bindable(false),
    disabled = false,
    label,
    onchange,
  }: Props = $props();
</script>

<label class="toggle-wrapper">
  {#if label}
    <span class="text-body">{label}</span>
  {/if}
  <button
    role="switch"
    class="toggle"
    class:checked
    aria-checked={checked}
    {disabled}
    onclick={() => { checked = !checked; onchange?.(checked); }}
  >
    <span class="toggle-thumb"></span>
  </button>
</label>
```


### Slider

Range slider with optional min/max labels.

```svelte
<!-- Slider.svelte -->
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Props {
    value?: number;
    min?: number;
    max?: number;
    step?: number;
    disabled?: boolean;
    leading?: Snippet;
    trailing?: Snippet;
    onchange?: (value: number) => void;
  }

  let {
    value = $bindable(0),
    min = 0,
    max = 100,
    step = 1,
    disabled = false,
    leading,
    trailing,
    onchange,
  }: Props = $props();
</script>

<div class="slider-wrapper">
  {#if leading}
    <div class="slider-leading">{@render leading()}</div>
  {/if}
  <input
    type="range"
    class="slider"
    bind:value
    {min}
    {max}
    {step}
    {disabled}
    oninput={() => onchange?.(value)}
  />
  {#if trailing}
    <div class="slider-trailing">{@render trailing()}</div>
  {/if}
</div>
```


---

## Feedback & Overlays

### Alert

Modal alert dialog with title, message, and action buttons.

```svelte
<!-- Alert.svelte -->
<script lang="ts">
  interface AlertAction {
    label: string;
    style?: 'default' | 'cancel' | 'destructive';
    onclick: () => void;
  }

  interface Props {
    open?: boolean;
    title: string;
    message?: string;
    actions: AlertAction[];
  }

  let {
    open = $bindable(false),
    title,
    message,
    actions,
  }: Props = $props();
</script>

{#if open}
  <div class="alert-backdrop" onclick={() => open = false}>
    <div
      class="alert material-thick"
      role="alertdialog"
      aria-label={title}
      onclick={(e) => e.stopPropagation()}
    >
      <div class="alert-content">
        <h2 class="text-headline">{title}</h2>
        {#if message}
          <p class="text-callout text-secondary">{message}</p>
        {/if}
      </div>
      <div class="alert-actions">
        {#each actions as action (action.label)}
          <button
            class="alert-action text-body"
            class:cancel={action.style === 'cancel'}
            class:destructive={action.style === 'destructive'}
            onclick={() => { action.onclick(); open = false; }}
          >
            {action.label}
          </button>
        {/each}
      </div>
    </div>
  </div>
{/if}
```

**Key patterns:**
- `$bindable(false)` allows parent to control open state
- `alertdialog` ARIA role for accessibility
- Action styles map to iOS alert button appearances


### Sheet

Bottom sheet with drag-to-dismiss. Supports detent heights.

```svelte
<!-- Sheet.svelte -->
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Props {
    open?: boolean;
    /** Show grabber pill at top */
    grabber?: boolean;
    /** Detent as percentage of viewport height */
    detent?: 'medium' | 'large' | 'full';
    title?: string;
    children: Snippet;
    onclose?: () => void;
  }

  let {
    open = $bindable(false),
    grabber = true,
    detent = 'large',
    title,
    children,
    onclose,
  }: Props = $props();

  let startY = $state(0);
  let offsetY = $state(0);
  let dragging = $state(false);

  function handleDragStart(e: PointerEvent) {
    dragging = true;
    startY = e.clientY;
    offsetY = 0;
  }

  function handleDragMove(e: PointerEvent) {
    if (!dragging) return;
    offsetY = Math.max(0, e.clientY - startY);
  }

  function handleDragEnd() {
    dragging = false;
    if (offsetY > 150) {
      open = false;
      onclose?.();
    }
    offsetY = 0;
  }
</script>

{#if open}
  <div class="sheet-backdrop" onclick={() => { open = false; onclose?.(); }}>
    <div
      class="sheet material-thick"
      class:detent-medium={detent === 'medium'}
      class:detent-large={detent === 'large'}
      class:detent-full={detent === 'full'}
      style:transform="translateY({offsetY}px)"
      onclick={(e) => e.stopPropagation()}
      onpointerdown={handleDragStart}
      onpointermove={handleDragMove}
      onpointerup={handleDragEnd}
    >
      {#if grabber}
        <div class="sheet-grabber"></div>
      {/if}
      {#if title}
        <div class="sheet-header">
          <h2 class="text-headline">{title}</h2>
        </div>
      {/if}
      <div class="sheet-content">
        {@render children()}
      </div>
    </div>
  </div>
{/if}
```

**Key patterns:**
- Pointer events for drag-to-dismiss gesture
- `detent` controls sheet height (medium ~50vh, large ~85vh, full ~100vh)
- Grabber pill is the 36x5px rounded indicator at top


### ContextMenu

Long-press context menu with grouped actions.

```svelte
<!-- ContextMenu.svelte -->
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface MenuItem {
    label: string;
    icon?: string;
    destructive?: boolean;
    onclick: () => void;
  }

  interface MenuGroup {
    items: MenuItem[];
  }

  interface Props {
    groups: MenuGroup[];
    children: Snippet;
  }

  let { groups, children }: Props = $props();
  let menuOpen = $state(false);
  let menuX = $state(0);
  let menuY = $state(0);

  function handleContextMenu(e: MouseEvent) {
    e.preventDefault();
    menuX = e.clientX;
    menuY = e.clientY;
    menuOpen = true;
  }
</script>

<div oncontextmenu={handleContextMenu}>
  {@render children()}
</div>

{#if menuOpen}
  <div class="context-menu-backdrop" onclick={() => menuOpen = false}>
    <div
      class="context-menu material-thick"
      style:left="{menuX}px"
      style:top="{menuY}px"
    >
      {#each groups as group, gi (gi)}
        {#if gi > 0}<div class="context-menu-separator"></div>{/if}
        {#each group.items as item (item.label)}
          <button
            class="context-menu-item text-body"
            class:destructive={item.destructive}
            onclick={() => { item.onclick(); menuOpen = false; }}
          >
            <span>{item.label}</span>
            {#if item.icon}<span class="context-menu-icon">{item.icon}</span>{/if}
          </button>
        {/each}
      {/each}
    </div>
  </div>
{/if}
```


---

## Form Controls

### TextField

Text input with label, placeholder, and optional clear button.

```svelte
<!-- TextField.svelte -->
<script lang="ts">
  interface Props {
    value?: string;
    label?: string;
    placeholder?: string;
    type?: 'text' | 'email' | 'password' | 'number' | 'search';
    disabled?: boolean;
    clearable?: boolean;
    oninput?: (value: string) => void;
  }

  let {
    value = $bindable(''),
    label,
    placeholder = '',
    type = 'text',
    disabled = false,
    clearable = false,
    oninput,
  }: Props = $props();
</script>

<div class="textfield-wrapper">
  {#if label}
    <label class="text-subheadline text-secondary">{label}</label>
  {/if}
  <div class="textfield-input-wrapper">
    <input
      class="textfield text-body"
      {type}
      bind:value
      {placeholder}
      {disabled}
      oninput={() => oninput?.(value)}
    />
    {#if clearable && value}
      <button
        class="textfield-clear"
        onclick={() => { value = ''; oninput?.(''); }}
        aria-label="Clear"
      >
        &times;
      </button>
    {/if}
  </div>
</div>
```


### SearchBar

iOS-style search bar with cancel button animation.

```svelte
<!-- SearchBar.svelte -->
<script lang="ts">
  interface Props {
    value?: string;
    placeholder?: string;
    oninput?: (value: string) => void;
    onsubmit?: (value: string) => void;
    oncancel?: () => void;
  }

  let {
    value = $bindable(''),
    placeholder = 'Search',
    oninput,
    onsubmit,
    oncancel,
  }: Props = $props();

  let focused = $state(false);
</script>

<div class="searchbar" class:focused>
  <div class="searchbar-field">
    <span class="searchbar-icon text-tertiary">&#x1F50D;</span>
    <input
      class="searchbar-input text-body"
      type="search"
      bind:value
      {placeholder}
      onfocus={() => focused = true}
      oninput={() => oninput?.(value)}
      onkeydown={(e) => { if (e.key === 'Enter') onsubmit?.(value); }}
    />
  </div>
  {#if focused}
    <button
      class="searchbar-cancel text-body"
      onclick={() => { value = ''; focused = false; oncancel?.(); }}
    >
      Cancel
    </button>
  {/if}
</div>
```


---

## Layout

### Page

Standard screen layout with toolbar, scrollable content, and optional tab bar.

```svelte
<!-- Page.svelte -->
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Props {
    toolbar?: Snippet;
    tabbar?: Snippet;
    children: Snippet;
  }

  let { toolbar, tabbar, children }: Props = $props();
</script>

<div class="page">
  {#if toolbar}
    <div class="page-toolbar">{@render toolbar()}</div>
  {/if}
  <main class="page-content">
    {@render children()}
  </main>
  {#if tabbar}
    <div class="page-tabbar">{@render tabbar()}</div>
  {/if}
</div>
```

**Styles (apply in component `<style>`):**
```css
.page {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background-color: var(--bg-grouped-primary);
  color: var(--label-primary);
}

.page-content {
  flex: 1;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
}
```


---

## Component Summary

| iOS 26 Component | Svelte Component | Key Props |
|-------------------|-----------------|-----------|
| Toolbar - Top | `<Toolbar>` | `title`, `largeTitle`, `scrollY`, `leading`, `trailing` |
| Tab Bar | `<TabBar>` | `items`, `active`, `onchange` |
| Segmented Control | `<SegmentedControl>` | `segments`, `selected`, `onchange` |
| Row | `<ListRow>` | `disclosure`, `separator`, `leading`, `trailing`, `children` |
| Section Header/Footer | `<ListSection>` | `header`, `footer`, `children` |
| Button - Content Area | `<Button>` | `variant`, `size`, `disabled`, `children` |
| Button - Liquid Glass | `<Button variant="liquid-glass">` | same as Button |
| Toggle | `<Toggle>` | `checked`, `disabled`, `label`, `onchange` |
| Slider | `<Slider>` | `value`, `min`, `max`, `step`, `leading`, `trailing` |
| Alert | `<Alert>` | `open`, `title`, `message`, `actions` |
| Sheet | `<Sheet>` | `open`, `grabber`, `detent`, `title`, `children` |
| Context Menu | `<ContextMenu>` | `groups`, `children` |
| Text Field | `<TextField>` | `value`, `label`, `placeholder`, `type`, `clearable` |
| Search Bar | `<SearchBar>` | `value`, `placeholder`, `oninput`, `onsubmit`, `oncancel` |
| Page Layout | `<Page>` | `toolbar`, `tabbar`, `children` |
