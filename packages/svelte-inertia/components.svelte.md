# iOS 26 Component Mapping — Svelte 5 + Inertia.js

Map of iOS 26 Figma components to Svelte 5 components with Inertia.js integration.
Each component uses Svelte 5 runes (`$state`, `$derived`, `$props`) and Inertia.js
APIs (`router.visit()`, `$page`, `useForm()`).

---

## Toolbar (Top Navigation Bar)

iOS navigation bar with Large Title support. Integrates with `$page.props` to
derive the page title from the Rails controller.

```svelte
<!-- lib/components/ios/Toolbar.svelte -->
<script>
  import { page } from '@inertiajs/svelte';

  let {
    title = $derived($page.props.title ?? ''),
    largeTitle = false,
    leading = undefined,
    trailing = undefined,
  } = $props();

  let scrolled = $state(false);

  function onScroll(e) {
    scrolled = e.target.scrollTop > 0;
  }
</script>

<header
  class="ios-toolbar"
  class:ios-toolbar--scrolled={scrolled}
  class:ios-toolbar--large={largeTitle}
>
  <div class="ios-toolbar__bar ios-blur-chrome">
    <div class="ios-toolbar__leading">
      {#if leading}
        {@render leading()}
      {/if}
    </div>
    <h1 class="ios-toolbar__title ios-headline">
      {title}
    </h1>
    <div class="ios-toolbar__trailing">
      {#if trailing}
        {@render trailing()}
      {/if}
    </div>
  </div>

  {#if largeTitle && !scrolled}
    <div class="ios-toolbar__large-title">
      <h1 class="ios-large-title ios-emphasized">{title}</h1>
    </div>
  {/if}
</header>

<style>
  .ios-toolbar {
    position: sticky;
    top: 0;
    z-index: 100;
  }

  .ios-toolbar__bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: var(--ios-toolbar-height);
    padding: 0 var(--ios-padding-horizontal);
  }

  .ios-toolbar__title {
    flex: 1;
    text-align: center;
    margin: 0;
    color: var(--ios-label-primary);
  }

  .ios-toolbar__leading,
  .ios-toolbar__trailing {
    flex: 0 0 auto;
    display: flex;
    align-items: center;
    min-width: 60px;
  }

  .ios-toolbar__trailing {
    justify-content: flex-end;
  }

  .ios-toolbar__large-title {
    padding: 0 var(--ios-padding-horizontal) 8px;
    background: var(--ios-bg-primary);
  }

  .ios-toolbar__large-title h1 {
    margin: 0;
    color: var(--ios-label-primary);
  }

  .ios-toolbar--scrolled .ios-toolbar__bar {
    border-bottom: 0.5px solid var(--ios-separator);
  }
</style>
```

**Rails controller integration:**

```ruby
# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  def index
    render inertia: 'Messages/Index', props: {
      title: 'Messages',
      messages: Message.recent.as_json
    }
  end
end
```

---

## TabBar (Bottom Navigation)

iOS floating tab bar using Inertia `<Link>` for SPA navigation. Active tab is
derived from `$page.url`.

```svelte
<!-- lib/components/ios/TabBar.svelte -->
<script>
  import { page } from '@inertiajs/svelte';
  import { Link } from '@inertiajs/svelte';

  let { tabs = [] } = $props();

  let currentPath = $derived($page.url.split('?')[0]);

  function isActive(href) {
    if (href === '/') return currentPath === '/';
    return currentPath.startsWith(href);
  }
</script>

<nav class="ios-tab-bar ios-glass-medium">
  {#each tabs as tab (tab.href)}
    <Link
      href={tab.href}
      class="ios-tab-bar__item"
      class:ios-tab-bar__item--active={isActive(tab.href)}
      preserveState
    >
      <span class="ios-tab-bar__icon">
        {@html tab.icon}
      </span>
      <span class="ios-tab-bar__label ios-caption2">
        {tab.label}
      </span>
    </Link>
  {/each}
</nav>

<style>
  .ios-tab-bar {
    position: fixed;
    bottom: calc(var(--ios-home-indicator-height) + 4px);
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    align-items: center;
    gap: 4px;
    padding: 6px 8px;
    z-index: 200;
  }

  .ios-tab-bar__item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 2px;
    padding: 4px 16px;
    border-radius: var(--ios-glass-radius-small);
    text-decoration: none;
    color: var(--ios-label-secondary);
    transition: all var(--ios-duration-fast) var(--ios-easing-default);
  }

  .ios-tab-bar__item--active {
    color: var(--ios-glass-icon-primary);
    background: var(--ios-glass-bg-small-primary);
    box-shadow: 0 0 var(--ios-glass-shadow-blur) rgba(0, 0, 0, 0.04);
  }

  .ios-tab-bar__icon {
    width: 24px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .ios-tab-bar__label {
    color: inherit;
  }
</style>
```

**Usage in layout:**

```svelte
<TabBar tabs={[
  { href: '/',         icon: '<svg>...</svg>', label: 'Home' },
  { href: '/messages', icon: '<svg>...</svg>', label: 'Messages' },
  { href: '/contacts', icon: '<svg>...</svg>', label: 'Contacts' },
  { href: '/settings', icon: '<svg>...</svg>', label: 'Settings' },
]} />
```

---

## List Row

Standard iOS list row with chevron disclosure, optional icon, subtitle, and
navigation via `router.visit()`.

```svelte
<!-- lib/components/ios/ListRow.svelte -->
<script>
  import { router } from '@inertiajs/svelte';

  let {
    href = undefined,
    icon = undefined,
    title,
    subtitle = undefined,
    value = undefined,
    showChevron = true,
    destructive = false,
    onclick = undefined,
  } = $props();

  function handleClick() {
    if (onclick) {
      onclick();
    } else if (href) {
      router.visit(href);
    }
  }
</script>

<button
  class="ios-list-row"
  class:ios-list-row--destructive={destructive}
  class:ios-list-row--interactive={href || onclick}
  onclick={handleClick}
  type="button"
>
  {#if icon}
    <span class="ios-list-row__icon">
      {@render icon()}
    </span>
  {/if}

  <div class="ios-list-row__content">
    <div class="ios-list-row__text">
      <span class="ios-body" class:ios-text-primary={!destructive}>
        {title}
      </span>
      {#if subtitle}
        <span class="ios-footnote ios-text-secondary">
          {subtitle}
        </span>
      {/if}
    </div>

    <div class="ios-list-row__trailing">
      {#if value}
        <span class="ios-body ios-text-secondary">{value}</span>
      {/if}
      {#if showChevron && (href || onclick)}
        <svg class="ios-list-row__chevron" width="7" height="12" viewBox="0 0 7 12" fill="none">
          <path d="M1 1L6 6L1 11" stroke="var(--ios-gray-3)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
      {/if}
    </div>
  </div>
</button>

<style>
  .ios-list-row {
    display: flex;
    align-items: center;
    width: 100%;
    min-height: var(--ios-list-row-min-height);
    padding: 11px var(--ios-padding-horizontal);
    background: var(--ios-bg-grouped-secondary);
    border: none;
    text-align: left;
    cursor: default;
    gap: 12px;
  }

  .ios-list-row--interactive {
    cursor: pointer;
  }

  .ios-list-row--interactive:active {
    background: var(--ios-fill-quaternary);
  }

  .ios-list-row__icon {
    flex: 0 0 auto;
    width: 29px;
    height: 29px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 6px;
  }

  .ios-list-row__content {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 0.5px solid var(--ios-separator);
    padding: 0 0 11px;
    margin-bottom: -11px;
    min-height: calc(var(--ios-list-row-min-height) - 22px);
  }

  /* Remove separator on last row */
  .ios-list-row:last-child .ios-list-row__content {
    border-bottom: none;
  }

  .ios-list-row__text {
    display: flex;
    flex-direction: column;
    gap: 2px;
  }

  .ios-list-row__trailing {
    display: flex;
    align-items: center;
    gap: 6px;
  }

  .ios-list-row__chevron {
    flex: 0 0 auto;
  }

  .ios-list-row--destructive {
    color: var(--ios-color-red);
  }
</style>
```

---

## Alert Dialog

iOS-style centered alert with dimming overlay. Supports Inertia form submission
for confirm/cancel actions that hit a Rails endpoint.

```svelte
<!-- lib/components/ios/Alert.svelte -->
<script>
  import { useForm } from '@inertiajs/svelte';
  import { fly, fade } from 'svelte/transition';

  let {
    open = $bindable(false),
    title,
    message = undefined,
    confirmLabel = 'OK',
    cancelLabel = undefined,
    confirmDestructive = false,
    formAction = undefined,
    formMethod = 'post',
    formData = {},
    onconfirm = undefined,
    oncancel = undefined,
  } = $props();

  let form = formAction ? useForm(formData) : null;

  function handleConfirm() {
    if (form && formAction) {
      form.submit(formMethod, formAction, {
        onSuccess: () => { open = false; },
      });
    } else if (onconfirm) {
      onconfirm();
      open = false;
    } else {
      open = false;
    }
  }

  function handleCancel() {
    oncancel?.();
    open = false;
  }
</script>

{#if open}
  <div class="ios-alert-overlay ios-overlay-dim-alert" transition:fade={{ duration: 200 }}>
    <div
      class="ios-alert"
      role="alertdialog"
      aria-labelledby="alert-title"
      aria-describedby={message ? 'alert-message' : undefined}
      transition:fly={{ y: -10, duration: 250 }}
    >
      <div class="ios-alert__content">
        <h2 id="alert-title" class="ios-body ios-emphasized">{title}</h2>
        {#if message}
          <p id="alert-message" class="ios-subheadline ios-text-secondary">{message}</p>
        {/if}
      </div>

      <div class="ios-alert__actions" class:ios-alert__actions--stacked={!cancelLabel}>
        {#if cancelLabel}
          <button
            class="ios-alert__button ios-body"
            onclick={handleCancel}
            type="button"
          >
            {cancelLabel}
          </button>
        {/if}
        <button
          class="ios-alert__button ios-body ios-emphasized"
          class:ios-alert__button--destructive={confirmDestructive}
          onclick={handleConfirm}
          disabled={form?.processing}
          type="button"
        >
          {form?.processing ? 'Processing...' : confirmLabel}
        </button>
      </div>
    </div>
  </div>
{/if}

<style>
  .ios-alert-overlay {
    position: fixed;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }

  .ios-alert {
    width: 270px;
    background: var(--ios-bg-primary);
    border-radius: 14px;
    overflow: hidden;
    box-shadow: 0 8px 40px rgba(0, 0, 0, 0.15);
  }

  .ios-alert__content {
    padding: 20px 16px 16px;
    text-align: center;
  }

  .ios-alert__content h2 {
    margin: 0;
    color: var(--ios-label-primary);
  }

  .ios-alert__content p {
    margin: 4px 0 0;
  }

  .ios-alert__actions {
    display: flex;
    border-top: 0.5px solid var(--ios-separator);
  }

  .ios-alert__actions--stacked {
    flex-direction: column;
  }

  .ios-alert__button {
    flex: 1;
    padding: 11px 8px;
    background: none;
    border: none;
    cursor: pointer;
    color: var(--ios-color-blue);
    text-align: center;
  }

  .ios-alert__button + .ios-alert__button {
    border-left: 0.5px solid var(--ios-separator);
  }

  .ios-alert__actions--stacked .ios-alert__button + .ios-alert__button {
    border-left: none;
    border-top: 0.5px solid var(--ios-separator);
  }

  .ios-alert__button:active {
    background: var(--ios-fill-quaternary);
  }

  .ios-alert__button--destructive {
    color: var(--ios-color-red);
  }

  .ios-alert__button:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
</style>
```

**Usage with Inertia form submission:**

```svelte
<Alert
  bind:open={showDeleteAlert}
  title="Delete Message"
  message="This action cannot be undone."
  confirmLabel="Delete"
  cancelLabel="Cancel"
  confirmDestructive
  formAction="/messages/{id}"
  formMethod="delete"
/>
```

---

## Sheet (Bottom Sheet)

iOS drag-to-dismiss sheet with grabber. Uses Svelte 5 transitions. Content
renders via snippet for maximum flexibility.

```svelte
<!-- lib/components/ios/Sheet.svelte -->
<script>
  import { fly, fade } from 'svelte/transition';

  let {
    open = $bindable(false),
    title = undefined,
    leadingAction = undefined,
    trailingAction = undefined,
    children,
  } = $props();

  let startY = $state(0);
  let currentY = $state(0);
  let dragging = $state(false);

  function onPointerDown(e) {
    startY = e.clientY;
    currentY = 0;
    dragging = true;
  }

  function onPointerMove(e) {
    if (!dragging) return;
    const delta = e.clientY - startY;
    currentY = Math.max(0, delta);
  }

  function onPointerUp() {
    dragging = false;
    if (currentY > 150) {
      open = false;
    }
    currentY = 0;
  }

  function handleKeydown(e) {
    if (e.key === 'Escape') open = false;
  }
</script>

<svelte:window onkeydown={handleKeydown} />

{#if open}
  <div class="ios-sheet-backdrop ios-overlay-dim" transition:fade={{ duration: 250 }}>
    <div
      class="ios-sheet"
      style:transform="translateY({currentY}px)"
      style:transition={dragging ? 'none' : `transform ${250}ms var(--ios-easing-default)`}
      role="dialog"
      aria-modal="true"
      aria-label={title ?? 'Sheet'}
      transition:fly={{ y: 600, duration: 350, easing: (t) => 1 - Math.pow(1 - t, 3) }}
    >
      <!-- Grabber -->
      <div
        class="ios-sheet__grabber-area"
        onpointerdown={onPointerDown}
        onpointermove={onPointerMove}
        onpointerup={onPointerUp}
        role="separator"
      >
        <div class="ios-sheet__grabber"></div>
      </div>

      <!-- Sheet toolbar -->
      {#if title || leadingAction || trailingAction}
        <div class="ios-sheet__toolbar">
          <div class="ios-sheet__toolbar-leading">
            {#if leadingAction}
              <button
                class="ios-body"
                style:color="var(--ios-color-blue)"
                onclick={leadingAction.onclick}
                type="button"
              >
                {leadingAction.label}
              </button>
            {/if}
          </div>
          {#if title}
            <h2 class="ios-headline">{title}</h2>
          {/if}
          <div class="ios-sheet__toolbar-trailing">
            {#if trailingAction}
              <button
                class="ios-body ios-emphasized"
                style:color="var(--ios-color-blue)"
                onclick={trailingAction.onclick}
                type="button"
              >
                {trailingAction.label}
              </button>
            {/if}
          </div>
        </div>
      {/if}

      <!-- Content -->
      <div class="ios-sheet__content">
        {@render children()}
      </div>
    </div>
  </div>
{/if}

<style>
  .ios-sheet-backdrop {
    position: fixed;
    inset: 0;
    z-index: 500;
    display: flex;
    align-items: flex-end;
  }

  .ios-sheet {
    width: 100%;
    max-height: 90vh;
    background: var(--ios-bg-primary);
    border-radius: 14px 14px 0 0;
    display: flex;
    flex-direction: column;
    overflow: hidden;
  }

  .ios-sheet__grabber-area {
    display: flex;
    justify-content: center;
    padding: 8px 0 4px;
    cursor: grab;
    touch-action: none;
  }

  .ios-sheet__grabber-area:active {
    cursor: grabbing;
  }

  .ios-sheet__grabber {
    width: 36px;
    height: 5px;
    border-radius: 2.5px;
    background: var(--ios-fill-secondary);
  }

  .ios-sheet__toolbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 8px var(--ios-padding-horizontal);
    border-bottom: 0.5px solid var(--ios-separator);
  }

  .ios-sheet__toolbar h2 {
    margin: 0;
    color: var(--ios-label-primary);
    text-align: center;
    flex: 1;
  }

  .ios-sheet__toolbar-leading,
  .ios-sheet__toolbar-trailing {
    min-width: 60px;
  }

  .ios-sheet__toolbar-trailing {
    text-align: right;
  }

  .ios-sheet__toolbar button {
    background: none;
    border: none;
    cursor: pointer;
    padding: 4px 0;
  }

  .ios-sheet__content {
    flex: 1;
    overflow-y: auto;
    overscroll-behavior: contain;
    -webkit-overflow-scrolling: touch;
  }
</style>
```

---

## Form Components (Inertia useForm Integration)

iOS-style form with toggle, text input, and picker. Uses Inertia's `useForm()`
for server-side form submission.

```svelte
<!-- Example: Settings form page -->
<script>
  import { useForm } from '@inertiajs/svelte';

  let form = useForm({
    notifications_enabled: true,
    display_name: '',
    send_interval: '30',
  });

  function handleSubmit(e) {
    e.preventDefault();
    $form.put('/settings');
  }
</script>

<form onsubmit={handleSubmit}>
  <!-- iOS Toggle Row -->
  <div class="ios-form-section">
    <div class="ios-form-section__header">
      <span class="ios-footnote ios-text-secondary">NOTIFICATIONS</span>
    </div>
    <div class="ios-form-section__body">
      <label class="ios-list-row">
        <span class="ios-body">Enable Notifications</span>
        <div class="ios-toggle">
          <input
            type="checkbox"
            bind:checked={$form.notifications_enabled}
          />
          <span class="ios-toggle__track"></span>
        </div>
      </label>
    </div>
  </div>

  <!-- iOS Text Input Row -->
  <div class="ios-form-section">
    <div class="ios-form-section__header">
      <span class="ios-footnote ios-text-secondary">PROFILE</span>
    </div>
    <div class="ios-form-section__body">
      <div class="ios-list-row">
        <span class="ios-body">Display Name</span>
        <input
          type="text"
          class="ios-text-input ios-body"
          placeholder="Enter name"
          bind:value={$form.display_name}
        />
      </div>
      {#if $form.errors.display_name}
        <p class="ios-form-error ios-footnote">{$form.errors.display_name}</p>
      {/if}
    </div>
  </div>

  <!-- iOS Picker Row -->
  <div class="ios-form-section">
    <div class="ios-form-section__header">
      <span class="ios-footnote ios-text-secondary">SEND SETTINGS</span>
    </div>
    <div class="ios-form-section__body">
      <label class="ios-list-row">
        <span class="ios-body">Interval (seconds)</span>
        <select
          class="ios-picker ios-body ios-text-secondary"
          bind:value={$form.send_interval}
        >
          <option value="10">10</option>
          <option value="30">30</option>
          <option value="60">60</option>
          <option value="120">120</option>
        </select>
      </label>
    </div>
  </div>

  <!-- Submit -->
  <div style="padding: var(--ios-padding-horizontal);">
    <button
      class="ios-button-primary ios-body ios-emphasized"
      type="submit"
      disabled={$form.processing}
    >
      {$form.processing ? 'Saving...' : 'Save'}
    </button>
  </div>
</form>

<style>
  .ios-form-section {
    margin-bottom: var(--ios-section-spacing);
  }

  .ios-form-section__header {
    padding: 0 var(--ios-padding-horizontal) 8px;
    text-transform: uppercase;
  }

  .ios-form-section__body {
    background: var(--ios-bg-grouped-secondary);
    border-radius: 10px;
    margin: 0 var(--ios-padding-horizontal);
    overflow: hidden;
  }

  .ios-text-input {
    background: none;
    border: none;
    text-align: right;
    color: var(--ios-label-primary);
    outline: none;
    flex: 1;
  }

  .ios-text-input::placeholder {
    color: var(--ios-label-tertiary);
  }

  .ios-picker {
    background: none;
    border: none;
    color: var(--ios-label-secondary);
    text-align: right;
    appearance: none;
    cursor: pointer;
  }

  .ios-toggle {
    position: relative;
    width: 51px;
    height: 31px;
    flex: 0 0 auto;
  }

  .ios-toggle input {
    opacity: 0;
    width: 0;
    height: 0;
    position: absolute;
  }

  .ios-toggle__track {
    position: absolute;
    inset: 0;
    background: var(--ios-fill-secondary);
    border-radius: 15.5px;
    transition: background var(--ios-duration-fast) var(--ios-easing-default);
    cursor: pointer;
  }

  .ios-toggle__track::after {
    content: "";
    position: absolute;
    top: 2px;
    left: 2px;
    width: 27px;
    height: 27px;
    background: white;
    border-radius: 50%;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.15);
    transition: transform var(--ios-duration-fast) var(--ios-easing-spring);
  }

  .ios-toggle input:checked + .ios-toggle__track {
    background: var(--ios-color-green);
  }

  .ios-toggle input:checked + .ios-toggle__track::after {
    transform: translateX(20px);
  }

  .ios-form-error {
    color: var(--ios-color-red);
    padding: 4px var(--ios-padding-horizontal) 8px;
    margin: 0;
  }

  .ios-button-primary {
    width: 100%;
    padding: 14px;
    background: var(--ios-color-blue);
    color: white;
    border: none;
    border-radius: 12px;
    cursor: pointer;
    text-align: center;
  }

  .ios-button-primary:active {
    opacity: 0.8;
  }

  .ios-button-primary:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
</style>
```

---

## Segmented Control

iOS segmented control for filtering content. Can drive Inertia page visits or
local state changes.

```svelte
<!-- lib/components/ios/SegmentedControl.svelte -->
<script>
  import { router } from '@inertiajs/svelte';

  let {
    segments = [],
    selected = $bindable(0),
    navigate = false,
  } = $props();

  function select(index) {
    selected = index;
    const segment = segments[index];
    if (navigate && segment.href) {
      router.visit(segment.href, { preserveState: true });
    }
  }
</script>

<div class="ios-segmented" role="tablist">
  {#each segments as segment, i (segment.label)}
    <button
      class="ios-segmented__item ios-subheadline"
      class:ios-segmented__item--active={i === selected}
      class:ios-emphasized={i === selected}
      role="tab"
      aria-selected={i === selected}
      onclick={() => select(i)}
      type="button"
    >
      {segment.label}
    </button>
  {/each}
</div>

<style>
  .ios-segmented {
    display: flex;
    background: var(--ios-fill-quaternary);
    border-radius: 8px;
    padding: 2px;
    gap: 1px;
  }

  .ios-segmented__item {
    flex: 1;
    padding: 6px 12px;
    background: none;
    border: none;
    border-radius: 7px;
    cursor: pointer;
    color: var(--ios-label-primary);
    text-align: center;
    transition: all var(--ios-duration-fast) var(--ios-easing-default);
  }

  .ios-segmented__item--active {
    background: var(--ios-bg-primary);
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
  }

  .ios-segmented__item:active:not(.ios-segmented__item--active) {
    background: var(--ios-fill-tertiary);
  }
</style>
```

---

## Component Summary

| iOS 26 Component | Svelte Component | Key Inertia API |
|---|---|---|
| Toolbar - Top | `<Toolbar>` | `$page.props.title` |
| Tab Bar | `<TabBar>` | `<Link>`, `$page.url` |
| Row | `<ListRow>` | `router.visit()` |
| Alert | `<Alert>` | `useForm().submit()` |
| Sheet | `<Sheet>` | Svelte transitions |
| Form Controls | Inline patterns | `useForm()`, `$form.errors` |
| Segmented Control | `<SegmentedControl>` | `router.visit()` (optional) |
