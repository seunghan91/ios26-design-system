# iOS 26 Design System -- Svelte 5 + Inertia.js + Rails

Complete iOS 26 design token and component library for Group A stack projects
(Rails 8 + Inertia.js + Svelte 5 + Vite).

Source: [Figma Community Kit](https://www.figma.com/community/file/1527721578857867021)

---

## Files

| File | Contents |
|------|----------|
| `tokens.css` | 50 color tokens, typography scale, material tokens, spacing, animations. Light + dark mode. |
| `typography.css` | 11-level SF Pro type scale with Regular/Emphasized/Italic/Loose variants. |
| `materials.css` | Liquid Glass (4 sizes), background blur (5 levels), scroll edges, overlays. |
| `components.svelte.md` | 7 iOS components mapped to Svelte 5 + Inertia.js patterns with code. |
| `layout.svelte.md` | Layout patterns: root layout, transitions, shared toolbar, error handling. |

---

## Setup

### 1. Copy CSS files to your Rails project

```
app/
  frontend/                    # or resources/js/ depending on Inertia setup
    css/
      ios26/
        tokens.css
        typography.css
        materials.css
    Components/
      ios/
        Toolbar.svelte
        TabBar.svelte
        ListRow.svelte
        Alert.svelte
        Sheet.svelte
        SegmentedControl.svelte
    Layouts/
      AppLayout.svelte
    Pages/
      ...
```

### 2. Import in your app entry CSS

```css
/* app/frontend/css/app.css */

/* iOS 26 Design System */
@import './ios26/tokens.css';
@import './ios26/typography.css';
@import './ios26/materials.css';

/* Your app styles */
/* ... */
```

### 3. Vite configuration

```js
// vite.config.js
import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';
import { resolve } from 'path';

export default defineConfig({
  plugins: [svelte()],
  resolve: {
    alias: {
      $lib: resolve('./app/frontend/Components'),
    },
  },
  css: {
    devSourcemap: true,
  },
});
```

### 4. Inertia app initialization

```js
// app/frontend/entrypoints/inertia.js
import { createInertiaApp } from '@inertiajs/svelte';
import '../css/app.css';

createInertiaApp({
  resolve: (name) => {
    const pages = import.meta.glob('../Pages/**/*.svelte', { eager: true });
    return pages[`../Pages/${name}.svelte`];
  },
  setup({ el, App }) {
    new App({ target: el });
  },
});
```

---

## Dark Mode

Three mechanisms are supported, in priority order:

1. **`data-theme` attribute** (explicit) -- Set by user toggle or JavaScript.
   ```html
   <html data-theme="dark">
   ```

2. **`prefers-color-scheme` media query** (automatic) -- Respects OS setting when
   `data-theme` is absent.

3. **Combination** -- The CSS includes both. If `data-theme="light"` is set
   explicitly, it overrides the OS dark mode preference.

The `AppLayout.svelte` in `layout.svelte.md` includes an `onMount` hook that
auto-detects OS preference and sets `data-theme` accordingly.

---

## Full Page Example

### Rails Controller

```ruby
# app/controllers/contacts_controller.rb
class ContactsController < ApplicationController
  def index
    contacts = current_user.contacts.order(:name)

    render inertia: 'Contacts/Index', props: {
      title: 'Contacts',
      contacts: contacts.map { |c|
        {
          id: c.id,
          name: c.name,
          subtitle: c.phone_number,
        }
      }
    }
  end

  def show
    contact = current_user.contacts.find(params[:id])

    render inertia: 'Contacts/Show', props: {
      title: contact.name,
      contact: contact.as_json(only: [:id, :name, :phone_number, :notes]),
    }
  end
end
```

### Svelte Page Component

```svelte
<!-- app/frontend/Pages/Contacts/Index.svelte -->
<script>
  import Toolbar from '$lib/ios/Toolbar.svelte';
  import ListRow from '$lib/ios/ListRow.svelte';
  import Sheet from '$lib/ios/Sheet.svelte';
  import { useForm } from '@inertiajs/svelte';

  let { contacts } = $props();

  let showAddSheet = $state(false);
  let form = useForm({ name: '', phone_number: '' });

  function handleAdd(e) {
    e.preventDefault();
    $form.post('/contacts', {
      onSuccess: () => {
        showAddSheet = false;
        $form.reset();
      },
    });
  }
</script>

<Toolbar largeTitle>
  {#snippet trailing()}
    <button
      class="ios-body"
      style:color="var(--ios-color-blue)"
      onclick={() => showAddSheet = true}
      type="button"
    >
      Add
    </button>
  {/snippet}
</Toolbar>

<div class="ios-grouped-page">
  <section class="ios-section">
    <div class="ios-section__body">
      {#each contacts as contact (contact.id)}
        <ListRow
          href="/contacts/{contact.id}"
          title={contact.name}
          subtitle={contact.subtitle}
        />
      {:else}
        <div class="ios-empty-state">
          <p class="ios-title3 ios-text-secondary">No Contacts</p>
          <p class="ios-body ios-text-tertiary">
            Add contacts to start sending messages.
          </p>
        </div>
      {/each}
    </div>
  </section>
</div>

<Sheet
  bind:open={showAddSheet}
  title="New Contact"
  leadingAction={{ label: 'Cancel', onclick: () => showAddSheet = false }}
  trailingAction={{ label: 'Save', onclick: handleAdd }}
>
  <form onsubmit={handleAdd} style:padding="var(--ios-padding-horizontal)">
    <div class="ios-form-section">
      <div class="ios-form-section__body">
        <div class="ios-list-row" style:padding="11px var(--ios-padding-horizontal)">
          <input
            type="text"
            class="ios-text-input ios-body"
            placeholder="Name"
            bind:value={$form.name}
            style:width="100%"
          />
        </div>
        <div class="ios-list-row" style:padding="11px var(--ios-padding-horizontal)">
          <input
            type="tel"
            class="ios-text-input ios-body"
            placeholder="Phone Number"
            bind:value={$form.phone_number}
            style:width="100%"
          />
        </div>
      </div>
    </div>
  </form>
</Sheet>

<style>
  .ios-grouped-page {
    padding-top: 16px;
  }

  .ios-section {
    margin-bottom: var(--ios-section-spacing);
  }

  .ios-section__body {
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

  .ios-form-section__body {
    background: var(--ios-bg-grouped-secondary);
    border-radius: 10px;
    overflow: hidden;
  }

  .ios-text-input {
    background: none;
    border: none;
    color: var(--ios-label-primary);
    outline: none;
  }

  .ios-text-input::placeholder {
    color: var(--ios-label-tertiary);
  }
</style>
```

---

## Token Count Summary

| Category | Count |
|----------|-------|
| System Colors | 12 |
| Labels | 4 |
| Backgrounds | 6 |
| Fills | 4 |
| Grays | 8 |
| Separators | 2 |
| Vibrant Labels (light + dark) | 8 |
| Vibrant Fills (light + dark) | 6 |
| **Total Color Tokens** | **50** |
| Typography (11 levels x props) | 50+ |
| Material (Liquid Glass + Blur) | ~22 |
| Spacing & Layout | 14 |
| Animation | 6 |
| **Grand Total** | **~142** |

---

## Related Files

- Design guide source: `docs/ios26-design-guide.md`
- Figma kit: [Community Kit](https://www.figma.com/community/file/1527721578857867021)
- Flutter tokens: `docs/ios26-design/flutter/ios26_colors.dart`
- Svelte-only tokens: `docs/ios26-design/svelte/tokens.css`
