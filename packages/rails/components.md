# iOS 26 Component Mapping -- Rails + Hotwire

Maps iOS 26 native components to their Rails 8 / Hotwire (Stimulus + ERB + Turbo) equivalents.

---

## Toolbar (Navigation Bar)

**iOS native:** `UINavigationBar` with large title
**Rails implementation:** `<header>` with Stimulus controller for scroll collapse

```erb
<%# app/views/shared/ios26/_toolbar.html.erb %>

<header class="ios-toolbar" data-controller="ios26-toolbar">
  <div class="ios-toolbar__row">
    <div class="ios-toolbar__leading">
      <%= link_to root_path, class: "ios-toolbar__back" do %>
        <svg width="12" height="20" viewBox="0 0 12 20" fill="none">
          <path d="M10 2L2 10L10 18" stroke="currentColor" stroke-width="2.5"
                stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
        Back
      <% end %>
    </div>
    <div class="ios-toolbar__trailing">
      <%= link_to "Edit", edit_item_path(@item), class: "ios-toolbar__action" %>
    </div>
  </div>
  <h1 class="ios-large-title ios-large-title--emphasized ios-toolbar__title--large"
      data-ios26-toolbar-target="largeTitle">
    Settings
  </h1>
</header>
```

**Key behaviors:**
- Sticky positioning with `backdrop-filter: blur()` for the frosted glass effect
- Large title collapses on scroll via `ios26-toolbar` Stimulus controller
- Back button uses Turbo Drive for SPA-like navigation

---

## Tab Bar

**iOS native:** `UITabBarController`
**Rails implementation:** `<nav>` with Turbo Frames for content switching

```erb
<%# app/views/layouts/_tab_bar.html.erb %>

<nav class="ios-tab-bar" data-controller="ios26-tab-bar" role="tablist">
  <% [
    { id: "home", label: "Home", url: root_path, icon_html: home_svg },
    { id: "search", label: "Search", url: search_path, icon_html: search_svg },
    { id: "profile", label: "Profile", url: profile_path, icon_html: person_svg }
  ].each do |tab| %>
    <%= link_to tab[:url],
          class: "ios-tab-bar__item #{'ios-tab-bar__item--active' if current_page?(tab[:url])}",
          data: { turbo_frame: "main-content", ios26_tab_bar_target: "tab",
                  action: "ios26-tab-bar#switch" },
          role: "tab",
          aria: { selected: current_page?(tab[:url]) } do %>
      <span class="ios-tab-bar__icon"><%= tab[:icon_html] %></span>
      <span class="ios-caption2 ios-tab-bar__label"><%= tab[:label] %></span>
    <% end %>
  <% end %>
</nav>
```

**Layout integration:**

```erb
<%# app/views/layouts/application.html.erb %>

<body>
  <%= render "shared/ios26/toolbar", title: yield(:title), large_title: true %>

  <turbo-frame id="main-content">
    <%= yield %>
  </turbo-frame>

  <%= render "layouts/tab_bar" %>
</body>
```

**Key behaviors:**
- Tab clicks load content into `<turbo-frame id="main-content">` without full page reload
- Active state managed by Stimulus controller + `current_page?` helper on initial render
- Turbo preserves scroll position and provides instant navigation feel

---

## List (Grouped Table View)

**iOS native:** `UITableView` / `List` with `.insetGrouped` style
**Rails implementation:** `<ul>` sections with `turbo_frame_tag` for lazy loading

```erb
<%# app/views/settings/index.html.erb %>

<div class="ios-grouped-list" style="background: var(--ios-bg-grouped-primary); padding-top: var(--ios-spacing-lg);">
  <%# Section 1: Account %>
  <section class="ios-list-section">
    <header class="ios-footnote ios-list-section__header">ACCOUNT</header>
    <div class="ios-list-section__body">
      <%= render "shared/ios26/list_row",
            title: "Apple ID",
            subtitle: "iCloud, App Store, Media",
            leading: '<div style="width:29px;height:29px;border-radius:50%;background:var(--ios-color-blue);display:flex;align-items:center;justify-content:center;color:white;font-weight:600;font-size:14px;">SH</div>',
            trailing: '<span class="ios-row__chevron"></span>',
            url: account_path %>
    </div>
  </section>

  <%# Section 2: Settings rows %>
  <section class="ios-list-section">
    <div class="ios-list-section__body">
      <%= render "shared/ios26/list_row",
            title: "Wi-Fi",
            detail: "Home-5G",
            leading: '<div style="background:var(--ios-color-blue);width:29px;height:29px;border-radius:6px;display:flex;align-items:center;justify-content:center;color:white;">W</div>',
            trailing: '<span class="ios-row__chevron"></span>',
            url: wifi_path %>

      <%= render "shared/ios26/list_row",
            title: "Bluetooth",
            detail: "On",
            leading: '<div style="background:var(--ios-color-blue);width:29px;height:29px;border-radius:6px;display:flex;align-items:center;justify-content:center;color:white;">B</div>',
            trailing: '<span class="ios-row__chevron"></span>',
            url: bluetooth_path %>
    </div>
  </section>

  <%# Lazy-loaded section via Turbo Frame %>
  <section class="ios-list-section">
    <header class="ios-footnote ios-list-section__header">NOTIFICATIONS</header>
    <div class="ios-list-section__body">
      <%= turbo_frame_tag "notifications-settings", src: notifications_settings_path, loading: :lazy do %>
        <div class="ios-row" style="justify-content:center;">
          <span class="ios-footnote" style="color:var(--ios-label-tertiary);">Loading...</span>
        </div>
      <% end %>
    </div>
  </section>
</div>
```

**Key behaviors:**
- Inset grouped style with rounded corners and proper separator handling
- `:last-child` CSS removes bottom border automatically
- `turbo_frame_tag` with `loading: :lazy` for deferred section loading
- Row taps use Turbo Drive, preserving back-forward navigation

---

## Alert

**iOS native:** `UIAlertController` with `.alert` style
**Rails implementation:** Turbo Stream modal rendered from controller

```ruby
# app/controllers/items_controller.rb

def destroy
  @item = Item.find(params[:id])

  respond_to do |format|
    format.turbo_stream {
      render turbo_stream: turbo_stream.append("modal-container",
        partial: "shared/ios26/alert",
        locals: {
          title: "Delete Item?",
          message: "This action cannot be undone.",
          actions: [
            { label: "Cancel", variant: :cancel },
            { label: "Delete", url: item_path(@item), method: :delete, variant: :destructive }
          ]
        }
      )
    }
    format.html { redirect_to items_path }
  end
end
```

**Triggering the alert (confirm before action):**

```erb
<%# In any view — request alert via Turbo Stream %>
<%= button_to "Delete",
      confirm_delete_item_path(@item),
      method: :get,
      class: "ios-btn ios-btn--destructive ios-btn--medium",
      data: { turbo_stream: true } %>

<%# Alert container in layout %>
<div id="modal-container"></div>
```

**Key behaviors:**
- Alert appears via Turbo Stream `append` into a container in the layout
- `ios26-alert` Stimulus controller handles backdrop click and dismiss
- Actions can be plain buttons (dismiss only) or links with Turbo method for destructive ops
- Two actions render side-by-side; three or more stack vertically (CSS `:has()` selector)

---

## Sheet (Bottom Sheet / Modal)

**iOS native:** `.sheet()` presentation
**Rails implementation:** Stimulus-controlled bottom sheet with drag-to-dismiss

```erb
<%# Trigger: opens sheet via Turbo Frame %>
<%= link_to "Show Details",
      details_item_path(@item),
      data: { turbo_frame: "sheet-frame" },
      class: "ios-btn ios-btn--liquid_glass ios-btn--medium" %>

<%# Sheet container in layout %>
<turbo-frame id="sheet-frame">
  <%# Content loaded here by Turbo %>
</turbo-frame>
```

```erb
<%# app/views/items/details.html.erb (rendered inside sheet frame) %>

<%= turbo_frame_tag "sheet-frame" do %>
  <div data-controller="ios26-sheet"
       data-ios26-sheet-detents-value='["medium","large"]'
       data-ios26-sheet-initial-value="medium">
    <div data-ios26-sheet-target="backdrop"
         data-action="click->ios26-sheet#dismiss"
         class="ios-sheet-backdrop"></div>

    <div data-ios26-sheet-target="panel" class="ios-sheet">
      <div data-ios26-sheet-target="grabber"
           data-action="pointerdown->ios26-sheet#startDrag"
           class="ios-sheet__grabber">
        <div class="ios-sheet__grabber-pill"></div>
      </div>

      <%# Sheet toolbar %>
      <div class="ios-toolbar__row" style="padding: 0 var(--ios-inset-horizontal);">
        <button data-action="ios26-sheet#dismiss" class="ios-toolbar__action">Cancel</button>
        <h2 class="ios-headline ios-toolbar__title--inline">Details</h2>
        <button class="ios-toolbar__action ios-body--emphasized">Done</button>
      </div>

      <%# Sheet content %>
      <div class="ios-sheet__content" style="padding: var(--ios-spacing-md);">
        <p class="ios-body"><%= @item.description %></p>
      </div>
    </div>
  </div>
<% end %>
```

```css
/* app/assets/stylesheets/ios26/sheet.css */

.ios-sheet-backdrop {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.4);
  z-index: 999;
  opacity: 0;
  transition: opacity var(--ios-duration-normal) var(--ios-easing-default);
}
.ios-sheet {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 1000;
  background: var(--ios-bg-primary);
  border-radius: var(--ios-radius-sheet) var(--ios-radius-sheet) 0 0;
  box-shadow: 0 -4px 40px rgba(0, 0, 0, 0.15);
  transform: translateY(100%);
  transition: transform var(--ios-duration-slow) var(--ios-easing-spring),
              height var(--ios-duration-slow) var(--ios-easing-spring);
}
.ios-sheet__grabber {
  display: flex;
  justify-content: center;
  padding: 8px 0 4px;
  cursor: grab;
  touch-action: none;
}
.ios-sheet__grabber-pill {
  width: 36px;
  height: 5px;
  background: var(--ios-fill-secondary);
  border-radius: 2.5px;
}
.ios-sheet__content {
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
  max-height: calc(100% - 60px);
}
```

**Key behaviors:**
- Content loaded via Turbo Frame for seamless server-rendered sheets
- Drag-to-dismiss with detent snapping (50% and 90% viewport height)
- Pointer events for cross-platform touch and mouse support
- Backdrop dismiss on tap outside

---

## Context Menu (Long Press)

**iOS native:** `UIContextMenuInteraction`
**Rails implementation:** Stimulus controller with long-press detection

```erb
<div class="ios-list-section__body">
  <% @items.each do |item| %>
    <div data-controller="ios26-context-menu"
         data-action="pointerdown->ios26-context-menu#startPress
                      pointerup->ios26-context-menu#cancelPress
                      pointerleave->ios26-context-menu#cancelPress
                      ios26-context-menu:selected->handleContextAction"
         data-item-id="<%= item.id %>">

      <template data-ios26-context-menu-target="menu">
        <div class="ios-context-menu">
          <button class="ios-context-menu__item"
                  data-action="ios26-context-menu#select"
                  data-value="copy">
            <span>Copy</span>
            <span class="ios-context-menu__icon">C</span>
          </button>
          <button class="ios-context-menu__item"
                  data-action="ios26-context-menu#select"
                  data-value="share">
            <span>Share</span>
          </button>
          <div class="ios-context-menu__separator"></div>
          <button class="ios-context-menu__item ios-context-menu__item--destructive"
                  data-action="ios26-context-menu#select"
                  data-value="delete">
            <span>Delete</span>
          </button>
        </div>
      </template>

      <%= render "shared/ios26/list_row",
            title: item.name,
            subtitle: item.description,
            trailing: '<span class="ios-row__chevron"></span>' %>
    </div>
  <% end %>
</div>
```

```css
/* app/assets/stylesheets/ios26/context-menu.css */

.ios-context-menu__item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  padding: 10px 16px;
  font-family: var(--ios-font-family);
  font-size: var(--ios-body-size);
  color: var(--ios-label-primary);
  background: none;
  border: none;
  cursor: pointer;
  text-align: left;
}
.ios-context-menu__item:active {
  background: var(--ios-fill-tertiary);
}
.ios-context-menu__item--destructive {
  color: var(--ios-color-red);
}
.ios-context-menu__separator {
  height: 0.5px;
  background: var(--ios-separator-opaque);
  margin: 0 16px;
}
```

---

## Segmented Control

**iOS native:** `UISegmentedControl`
**Rails implementation:** Turbo Frame switcher with radio-like behavior

```erb
<div class="ios-segmented-control" data-controller="ios26-segment">
  <% ["All", "Active", "Completed"].each_with_index do |label, i| %>
    <%= link_to label,
          items_path(filter: label.downcase),
          class: "ios-segmented-control__item #{'ios-segmented-control__item--selected' if i == 0}",
          data: {
            turbo_frame: "items-list",
            ios26_segment_target: "segment",
            action: "ios26-segment#select"
          } %>
  <% end %>
</div>

<turbo-frame id="items-list">
  <%# Filtered list renders here %>
</turbo-frame>
```

```css
.ios-segmented-control {
  display: inline-flex;
  background: var(--ios-fill-tertiary);
  border-radius: var(--ios-radius-sm);
  padding: 2px;
  gap: 0;
}
.ios-segmented-control__item {
  padding: 6px 16px;
  border-radius: 6px;
  font-family: var(--ios-font-family);
  font-size: var(--ios-subheadline-size);
  font-weight: 600;
  color: var(--ios-label-primary);
  text-decoration: none;
  transition: all var(--ios-duration-fast) var(--ios-easing-default);
}
.ios-segmented-control__item--selected {
  background: var(--ios-bg-primary);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12);
}
```

---

## Buttons (Liquid Glass)

**iOS native:** Liquid Glass button style (iOS 26)
**Rails implementation:** ERB partial with variant system

```erb
<%# Liquid Glass (default) %>
<%= render "shared/ios26/button", label: "Continue", variant: :liquid_glass %>

<%# Filled blue %>
<%= render "shared/ios26/button", label: "Sign In", variant: :filled, size: :large %>

<%# Gray / secondary %>
<%= render "shared/ios26/button", label: "Cancel", variant: :gray %>

<%# Plain text %>
<%= render "shared/ios26/button", label: "Skip", variant: :plain %>

<%# Destructive %>
<%= render "shared/ios26/button",
      label: "Delete Account",
      variant: :destructive,
      size: :large,
      url: account_path,
      method: :delete %>
```

---

## Mapping Summary

| iOS 26 Component | HTML Element | Stimulus Controller | Turbo Integration |
|-------------------|-------------|---------------------|-------------------|
| Navigation Bar | `<header>` | `ios26-toolbar` | Turbo Drive for navigation |
| Tab Bar | `<nav>` | `ios26-tab-bar` | Turbo Frame for content swap |
| List (Grouped) | `<section>` + `<div>` | -- | `turbo_frame_tag` for lazy load |
| List Row | `<a>` or `<div>` | -- | `data-turbo-frame` for targeting |
| Alert | `<div role="alertdialog">` | `ios26-alert` | Turbo Stream append |
| Sheet | `<div>` fixed positioned | `ios26-sheet` | Turbo Frame for content |
| Context Menu | `<template>` + `<div>` | `ios26-context-menu` | Custom events |
| Segmented Control | `<div>` flex | `ios26-segment` | Turbo Frame for filtering |
| Button | `<button>` / `<a>` | -- | `data-turbo-method` |
| Dark Mode | `.ios26-dark` class | `ios26-dark-mode` | localStorage persistence |
