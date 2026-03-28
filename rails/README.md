# iOS 26 Design System -- Rails 8 + Hotwire

Production-ready implementation of the iOS 26 design language for Rails 8 applications using Stimulus, ERB, and Turbo.

---

## Quick Start

### 1. Copy Assets into Your Rails Project

```
app/
  assets/
    stylesheets/
      ios26/
        tokens.css           <-- Design tokens (colors, typography, materials)
        sheet.css            <-- Sheet component styles
        context-menu.css     <-- Context menu styles
  javascript/
    controllers/
      ios26_toolbar_controller.js
      ios26_tab_bar_controller.js
      ios26_sheet_controller.js
      ios26_alert_controller.js
      ios26_context_menu_controller.js
      ios26_dark_mode_controller.js
  views/
    shared/
      ios26/
        _toolbar.html.erb
        _list_row.html.erb
        _list_section.html.erb
        _alert.html.erb
        _button.html.erb
        _tab_bar.html.erb
```

### 2. Asset Pipeline Integration

**Propshaft (Rails 8 default):**

```css
/* app/assets/stylesheets/application.css */
/* Add to your existing stylesheet */
@import "ios26/tokens.css";
@import "ios26/sheet.css";
@import "ios26/context-menu.css";
```

**Sprockets (legacy):**

```css
/* app/assets/stylesheets/application.css */
/*
 *= require ios26/tokens
 *= require ios26/sheet
 *= require ios26/context-menu
 */
```

### 3. Register Stimulus Controllers

**Option A: Bulk registration (recommended)**

```js
// app/javascript/controllers/index.js
import { application } from "./application"

import { registerIos26Controllers } from "./ios26_controller"
registerIos26Controllers(application)
```

**Option B: Individual registration**

```js
// app/javascript/controllers/index.js
import { application } from "./application"

import { Ios26ToolbarController } from "./ios26_controller"
import { Ios26TabBarController } from "./ios26_controller"
import { Ios26SheetController } from "./ios26_controller"
import { Ios26AlertController } from "./ios26_controller"
import { Ios26ContextMenuController } from "./ios26_controller"
import { Ios26DarkModeController } from "./ios26_controller"

application.register("ios26-toolbar", Ios26ToolbarController)
application.register("ios26-tab-bar", Ios26TabBarController)
application.register("ios26-sheet", Ios26SheetController)
application.register("ios26-alert", Ios26AlertController)
application.register("ios26-context-menu", Ios26ContextMenuController)
application.register("ios26-dark-mode", Ios26DarkModeController)
```

### 4. Importmap (if not using bundler)

```ruby
# config/importmap.rb
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
```

---

## Full Example: Settings Page

A complete Rails view demonstrating the iOS 26 design system in action.

```erb
<%# app/views/settings/index.html.erb %>
<% content_for :title, "Settings" %>

<%# -- Toolbar with large title -- %>
<%= render "shared/ios26/toolbar",
      title: "Settings",
      large_title: true %>

<%# -- Main scrollable content -- %>
<main style="background: var(--ios-bg-grouped-primary);
             padding: var(--ios-spacing-lg) 0;
             padding-bottom: calc(49px + var(--ios-safe-area-bottom) + var(--ios-spacing-2xl));
             min-height: 100vh;"
      data-ios26-toolbar-target="scrollContainer">

  <%# -- Profile Section -- %>
  <%= render "shared/ios26/list_section" do %>
    <%= render "shared/ios26/list_row",
          title: current_user.name,
          subtitle: "Apple Account, iCloud, and purchases",
          leading: '<div style="width:44px;height:44px;border-radius:50%;background:var(--ios-color-blue);display:flex;align-items:center;justify-content:center;color:white;font-weight:600;font-size:18px;">SH</div>',
          trailing: '<span class="ios-row__chevron"></span>',
          url: account_path %>
  <% end %>

  <%# -- Connectivity Section -- %>
  <%= render "shared/ios26/list_section" do %>
    <%= render "shared/ios26/list_row",
          title: "Wi-Fi",
          detail: "Home-5G",
          leading: '<div style="background:var(--ios-color-blue);width:29px;height:29px;border-radius:6px;display:flex;align-items:center;justify-content:center;color:white;font-size:14px;">W</div>',
          trailing: '<span class="ios-row__chevron"></span>',
          url: wifi_settings_path %>

    <%= render "shared/ios26/list_row",
          title: "Bluetooth",
          detail: "On",
          leading: '<div style="background:var(--ios-color-blue);width:29px;height:29px;border-radius:6px;display:flex;align-items:center;justify-content:center;color:white;font-size:14px;">B</div>',
          trailing: '<span class="ios-row__chevron"></span>',
          url: bluetooth_settings_path %>

    <%= render "shared/ios26/list_row",
          title: "Cellular",
          leading: '<div style="background:var(--ios-color-green);width:29px;height:29px;border-radius:6px;display:flex;align-items:center;justify-content:center;color:white;font-size:14px;">C</div>',
          trailing: '<span class="ios-row__chevron"></span>',
          url: cellular_settings_path %>
  <% end %>

  <%# -- Notifications (lazy loaded via Turbo Frame) -- %>
  <%= render "shared/ios26/list_section", header: "NOTIFICATIONS" do %>
    <turbo-frame id="notification-prefs" src="<%= notification_preferences_path %>" loading="lazy">
      <div class="ios-row" style="justify-content:center;min-height:88px;">
        <span class="ios-footnote" style="color:var(--ios-label-tertiary);">Loading...</span>
      </div>
    </turbo-frame>
  <% end %>

  <%# -- Danger Zone -- %>
  <%= render "shared/ios26/list_section", footer: "Signing out will remove your data from this device." do %>
    <%= render "shared/ios26/list_row",
          title: "Sign Out",
          destructive: true,
          url: sign_out_confirm_path %>
  <% end %>

</main>

<%# -- Tab Bar -- %>
<%= render "shared/ios26/tab_bar",
      current: "settings",
      tabs: [
        { id: "home", label: "Home", url: root_path,
          icon_html: '<svg width="25" height="25" viewBox="0 0 25 25"><path d="M3 10.5L12.5 3L22 10.5V21H15.5V15H9.5V21H3V10.5Z" fill="currentColor"/></svg>' },
        { id: "search", label: "Search", url: search_path,
          icon_html: '<svg width="25" height="25" viewBox="0 0 25 25"><circle cx="11" cy="11" r="7" stroke="currentColor" stroke-width="2" fill="none"/><line x1="16" y1="16" x2="22" y2="22" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>' },
        { id: "settings", label: "Settings", url: settings_path,
          icon_html: '<svg width="25" height="25" viewBox="0 0 25 25"><circle cx="12.5" cy="12.5" r="3" stroke="currentColor" stroke-width="2" fill="none"/><path d="M12.5 2L14 5H11L12.5 2Z" fill="currentColor"/></svg>' }
      ] %>

<%# -- Dark mode toggle (optional) -- %>
<div style="position:fixed;top:var(--ios-spacing-sm);right:var(--ios-spacing-sm);z-index:200;">
  <button data-controller="ios26-dark-mode"
          data-action="ios26-dark-mode#toggle"
          class="ios-btn ios-btn--liquid_glass ios-btn--small">
    Dark Mode
  </button>
</div>
```

---

## Layout Template

```erb
<%# app/views/layouts/application.html.erb %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="default">
  <title><%= yield(:title) || "App" %></title>

  <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
  <%= javascript_importmap_tags %>
</head>
<body style="font-family: var(--ios-font-family);
             color: var(--ios-label-primary);
             background: var(--ios-bg-grouped-primary);
             margin: 0;
             -webkit-font-smoothing: antialiased;">

  <%# Alerts and sheets render into this container via Turbo Streams %>
  <div id="modal-container"></div>

  <%= yield %>

</body>
</html>
```

---

## File Reference

| File | Purpose |
|------|---------|
| `tokens.css` | All 50+ CSS custom properties: colors, typography, materials, spacing, animation |
| `_ios26_helpers.html.erb` | ERB partials: toolbar, list_row, list_section, alert, button, tab_bar |
| `ios26_controller.js` | 6 Stimulus controllers: toolbar, tab-bar, sheet, alert, context-menu, dark-mode |
| `components.md` | Component mapping guide with ERB code examples |
| `README.md` | This file -- setup and usage guide |

---

## Design Token Reference

All tokens use the `--ios-` prefix. Key categories:

| Category | Example Variable | Light Value |
|----------|-----------------|-------------|
| System Colors | `--ios-color-blue` | `#0088ff` |
| Labels | `--ios-label-primary` | `rgba(0,0,0,1)` |
| Backgrounds | `--ios-bg-grouped-primary` | `#f2f2f7` |
| Fills | `--ios-fill-primary` | `rgba(120,120,120,0.2)` |
| Grays | `--ios-gray` | `#8e8e93` |
| Glass | `--ios-glass-bg-medium` | `rgba(245,245,245,0.6)` |
| Typography | `--ios-body-size` | `17px` |
| Spacing | `--ios-spacing-md` | `16px` |
| Radius | `--ios-radius-md` | `12px` |
| Animation | `--ios-duration-normal` | `250ms` |

Dark mode values override automatically via `@media (prefers-color-scheme: dark)` or manually via the `.ios26-dark` class on `<html>`.

---

## Turbo Integration Patterns

### Turbo Drive (Full-Page Navigation)
Default behavior. All `<a>` tags get SPA-like navigation. Toolbar and tab bar persist.

### Turbo Frames (Partial Updates)
Use for tab content, lazy-loaded sections, and inline editing.

```erb
<turbo-frame id="content">
  <%# Only this frame updates on navigation %>
</turbo-frame>
```

### Turbo Streams (Real-Time Updates)
Use for alerts, notifications, and server-pushed changes.

```ruby
# Controller
respond_to do |format|
  format.turbo_stream {
    render turbo_stream: turbo_stream.append("modal-container",
      partial: "shared/ios26/alert",
      locals: { title: "Done!", message: "Item saved.", actions: [{ label: "OK", variant: :cancel }] }
    )
  }
end
```

---

## Browser Support

- Safari 15.4+ (required for `backdrop-filter`, `:has()`, `env()`)
- Chrome 105+
- Firefox 103+
- Edge 105+

The Liquid Glass effect (`backdrop-filter: blur()`) degrades gracefully to a solid background on unsupported browsers.
