# iOS 26 Layout Patterns — Svelte 5 + Inertia.js

Inertia.js layout patterns implementing iOS 26 screen structure: persistent
TabBar, page transitions, shared toolbar, and error handling.

---

## Root Layout with Persistent TabBar

The root layout wraps all pages with a persistent bottom TabBar that survives
Inertia page navigation. The TabBar and theme initialization live here.

```svelte
<!-- resources/js/Layouts/AppLayout.svelte -->
<script>
  import { page } from '@inertiajs/svelte';
  import TabBar from '$lib/components/ios/TabBar.svelte';

  let { children } = $props();

  /** Detect system dark mode and set data-theme on mount */
  import { onMount } from 'svelte';

  onMount(() => {
    const mq = window.matchMedia('(prefers-color-scheme: dark)');
    function apply(e) {
      document.documentElement.dataset.theme = e.matches ? 'dark' : 'light';
    }
    apply(mq);
    mq.addEventListener('change', apply);
    return () => mq.removeEventListener('change', apply);
  });

  const tabs = [
    { href: '/',         icon: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg>', label: 'Home' },
    { href: '/messages', icon: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>', label: 'Messages' },
    { href: '/contacts', icon: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>', label: 'Contacts' },
    { href: '/settings', icon: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 1 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 1 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 1 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 1 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>', label: 'Settings' },
  ];
</script>

<div class="ios-app">
  <main class="ios-app__content ios-page">
    {@render children()}
  </main>
  <TabBar {tabs} />
</div>

<style>
  .ios-app {
    min-height: 100dvh;
    background: var(--ios-bg-grouped-primary);
    font-family: var(--ios-font-family);
    color: var(--ios-label-primary);
    -webkit-font-smoothing: antialiased;
  }

  .ios-app__content {
    padding-bottom: calc(var(--ios-tab-bar-height) + var(--ios-home-indicator-height) + 16px);
  }
</style>
```

---

## Page Transitions (iOS Navigation Animation)

Inertia fires `navigate` events on every page change. Use Svelte 5 transitions
to animate the incoming page with an iOS-style slide.

```svelte
<!-- resources/js/Layouts/AppLayout.svelte (enhanced with transitions) -->
<script>
  import { page, router } from '@inertiajs/svelte';
  import { fly } from 'svelte/transition';
  import TabBar from '$lib/components/ios/TabBar.svelte';

  let { children } = $props();
  let transitionKey = $state($page.url);
  let direction = $state(1); /* 1 = forward, -1 = back */

  /* Track navigation direction based on browser history */
  let navigationStack = $state(['/']);

  router.on('navigate', (event) => {
    const url = event.detail.page.url;
    const stackIndex = navigationStack.indexOf(url);

    if (stackIndex !== -1) {
      /* Going back to a previously visited page */
      direction = -1;
      navigationStack = navigationStack.slice(0, stackIndex + 1);
    } else {
      /* Going forward to a new page */
      direction = 1;
      navigationStack = [...navigationStack, url];
    }

    transitionKey = url;
  });

  const tabs = [
    { href: '/',         icon: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/></svg>', label: 'Home' },
    { href: '/messages', icon: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>', label: 'Messages' },
    { href: '/contacts', icon: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>', label: 'Contacts' },
    { href: '/settings', icon: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 ..."/></svg>', label: 'Settings' },
  ];
</script>

<div class="ios-app">
  {#key transitionKey}
    <main
      class="ios-app__content ios-page"
      in:fly={{ x: direction * 80, duration: 350, easing: (t) => 1 - Math.pow(1 - t, 3) }}
      out:fly={{ x: direction * -80, duration: 250, easing: (t) => t * t }}
    >
      {@render children()}
    </main>
  {/key}
  <TabBar {tabs} />
</div>

<style>
  .ios-app {
    min-height: 100dvh;
    background: var(--ios-bg-grouped-primary);
    font-family: var(--ios-font-family);
    color: var(--ios-label-primary);
    -webkit-font-smoothing: antialiased;
    overflow-x: hidden;
    position: relative;
  }

  .ios-app__content {
    padding-bottom: calc(var(--ios-tab-bar-height) + var(--ios-home-indicator-height) + 16px);
    position: absolute;
    width: 100%;
  }
</style>
```

---

## Shared Toolbar Across Pages

Each page includes a `<Toolbar>` that reads its title from `$page.props`.
The `largeTitle` prop controls whether the collapsible large title is shown.

```svelte
<!-- resources/js/Pages/Messages/Index.svelte -->
<script>
  import Toolbar from '$lib/components/ios/Toolbar.svelte';
  import ListRow from '$lib/components/ios/ListRow.svelte';
  import AppLayout from '../../Layouts/AppLayout.svelte';

  let { messages } = $props();
</script>

<Toolbar largeTitle>
  {#snippet trailing()}
    <button
      class="ios-body"
      style:color="var(--ios-color-blue)"
      type="button"
    >
      Compose
    </button>
  {/snippet}
</Toolbar>

<div class="ios-list-section">
  {#each messages as message (message.id)}
    <ListRow
      href="/messages/{message.id}"
      title={message.room_name}
      subtitle={message.last_message}
      value={message.time_ago}
    />
  {/each}

  {#if messages.length === 0}
    <div class="ios-empty-state">
      <p class="ios-title3 ios-text-secondary">No Messages</p>
      <p class="ios-body ios-text-tertiary">
        Your conversations will appear here.
      </p>
    </div>
  {/if}
</div>

<style>
  .ios-list-section {
    background: var(--ios-bg-grouped-secondary);
    border-radius: 10px;
    margin: 0 var(--ios-padding-horizontal);
    overflow: hidden;
  }

  .ios-empty-state {
    text-align: center;
    padding: 60px var(--ios-padding-horizontal);
  }

  .ios-empty-state p {
    margin: 0;
  }

  .ios-empty-state p + p {
    margin-top: 8px;
  }
</style>
```

**Rails controller providing the page props:**

```ruby
class MessagesController < ApplicationController
  def index
    render inertia: 'Messages/Index', props: {
      title: 'Messages',
      messages: current_user.messages.recent.map { |m|
        {
          id: m.id,
          roomName: m.room.name,
          lastMessage: m.last_message_preview,
          timeAgo: time_ago_in_words(m.updated_at),
        }
      }
    }
  end
end
```

---

## Error Handling with iOS-Style Alerts

Use Inertia's shared data and error props to display iOS-style error alerts
automatically.

```svelte
<!-- resources/js/Layouts/AppLayout.svelte (error handling addition) -->
<script>
  import { page } from '@inertiajs/svelte';
  import Alert from '$lib/components/ios/Alert.svelte';

  let { children } = $props();

  /* Derive flash errors from Rails shared data */
  let flashError = $derived($page.props.flash?.error);
  let showError = $state(false);

  $effect(() => {
    if (flashError) {
      showError = true;
    }
  });
</script>

<!-- ... rest of layout ... -->

<Alert
  bind:open={showError}
  title="Error"
  message={flashError}
  confirmLabel="OK"
/>
```

**Rails side — set flash for Inertia:**

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  inertia_share flash: -> {
    {
      success: flash[:notice],
      error: flash[:alert],
    }
  }
end
```

---

## Grouped List Page Pattern

The standard iOS grouped table layout used for settings, profiles, and similar
structured content.

```svelte
<!-- resources/js/Pages/Settings/Index.svelte -->
<script>
  import Toolbar from '$lib/components/ios/Toolbar.svelte';
  import ListRow from '$lib/components/ios/ListRow.svelte';
</script>

<Toolbar largeTitle />

<div class="ios-grouped-page">
  <!-- Section: Account -->
  <section class="ios-section">
    <header class="ios-section__header">
      <span class="ios-footnote ios-text-secondary">ACCOUNT</span>
    </header>
    <div class="ios-section__body">
      <ListRow
        title="Profile"
        href="/settings/profile"
        value="Kim Seunghan"
      />
      <ListRow
        title="Notifications"
        href="/settings/notifications"
      />
    </div>
  </section>

  <!-- Section: Automation -->
  <section class="ios-section">
    <header class="ios-section__header">
      <span class="ios-footnote ios-text-secondary">AUTOMATION</span>
    </header>
    <div class="ios-section__body">
      <ListRow
        title="Send Interval"
        href="/settings/interval"
        value="30s"
      />
      <ListRow
        title="Message Templates"
        href="/settings/templates"
      />
    </div>
    <footer class="ios-section__footer">
      <span class="ios-footnote ios-text-secondary">
        Configure automatic message sending behavior and timing.
      </span>
    </footer>
  </section>

  <!-- Section: Danger -->
  <section class="ios-section">
    <div class="ios-section__body">
      <ListRow
        title="Sign Out"
        destructive
        showChevron={false}
        onclick={() => { /* handle sign out */ }}
      />
    </div>
  </section>
</div>

<style>
  .ios-grouped-page {
    padding-top: 16px;
  }

  .ios-section {
    margin-bottom: var(--ios-section-spacing);
  }

  .ios-section__header {
    padding: 0 calc(var(--ios-padding-horizontal) + var(--ios-padding-horizontal)) 8px;
    text-transform: uppercase;
  }

  .ios-section__body {
    background: var(--ios-bg-grouped-secondary);
    border-radius: 10px;
    margin: 0 var(--ios-padding-horizontal);
    overflow: hidden;
  }

  .ios-section__footer {
    padding: 8px calc(var(--ios-padding-horizontal) + var(--ios-padding-horizontal)) 0;
  }
</style>
```

---

## Layout Summary

| Pattern | File | Key Concept |
|---|---|---|
| Root Layout | `AppLayout.svelte` | Persistent TabBar, theme detection |
| Page Transitions | `AppLayout.svelte` | `{#key}` + `fly` transition on navigate |
| Shared Toolbar | Per-page `<Toolbar>` | `$page.props.title` from Rails |
| Error Alerts | `AppLayout.svelte` | `$page.props.flash` shared data |
| Grouped List | Settings pattern | `ios-section` with header/body/footer |

### Screen Structure

```
+----------------------------------------------+
| Status Bar (54pt)                            |
+----------------------------------------------+
| Toolbar - Top (44pt or 96pt large title)     |
+----------------------------------------------+
|                                              |
|  Content Area                                |
|  - Grouped sections                          |
|  - List rows with separators                 |
|  - Cards, forms, etc.                        |
|                                              |
+----------------------------------------------+
| TabBar (Liquid Glass, floating)              |
+----------------------------------------------+
| Home Indicator (34pt)                        |
+----------------------------------------------+
```
