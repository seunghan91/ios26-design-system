// =============================================================================
// iOS 26 Stimulus Controllers
// For Rails 8 + Hotwire (Stimulus + ERB + Turbo)
//
// Registration:
//   import { application } from "controllers/application"
//   import Ios26Controller from "controllers/ios26_controller"
//   application.register("ios26", Ios26Controller)
//
// Or register individual controllers (toolbar, tab-bar, sheet, alert, etc.)
// =============================================================================


import { Controller } from "@hotwired/stimulus"

// -----------------------------------------------------------------------------
// ios26-toolbar — Large title collapse on scroll
//
// Usage:
//   <header data-controller="ios26-toolbar">
//     <h1 data-ios26-toolbar-target="largeTitle">Title</h1>
//   </header>
//   <main data-ios26-toolbar-target="scrollContainer">...</main>
//
// The large title fades and collapses as the user scrolls down, mimicking
// the iOS navigation bar behavior.
// -----------------------------------------------------------------------------
export class Ios26ToolbarController extends Controller {
  static targets = ["largeTitle", "scrollContainer"]

  connect() {
    this._scrollHandler = this._onScroll.bind(this)

    const container = this.hasScrollContainerTarget
      ? this.scrollContainerTarget
      : window

    container.addEventListener("scroll", this._scrollHandler, { passive: true })
  }

  disconnect() {
    const container = this.hasScrollContainerTarget
      ? this.scrollContainerTarget
      : window

    container.removeEventListener("scroll", this._scrollHandler)
  }

  _onScroll() {
    if (!this.hasLargeTitleTarget) return

    const container = this.hasScrollContainerTarget
      ? this.scrollContainerTarget
      : document.documentElement

    const scrollY = container.scrollTop || window.scrollY
    const threshold = 50
    const progress = Math.min(scrollY / threshold, 1)

    this.largeTitleTarget.style.opacity = String(1 - progress)
    this.largeTitleTarget.style.transform = `scale(${1 - progress * 0.15})`
    this.largeTitleTarget.style.transformOrigin = "left center"
    this.largeTitleTarget.style.height = progress >= 1 ? "0px" : ""
    this.largeTitleTarget.style.overflow = "hidden"
    this.largeTitleTarget.style.marginBottom = progress >= 1 ? "0px" : ""
  }
}


// -----------------------------------------------------------------------------
// ios26-tab-bar — Tab switching with Turbo Frame integration
//
// Usage:
//   <nav data-controller="ios26-tab-bar">
//     <a data-ios26-tab-bar-target="tab"
//        data-action="ios26-tab-bar#switch"
//        data-turbo-frame="main-content"
//        href="/home">Home</a>
//     <a ...>Search</a>
//   </nav>
//   <turbo-frame id="main-content">...</turbo-frame>
//
// Handles active state management. Turbo Frames handle the actual navigation.
// -----------------------------------------------------------------------------
export class Ios26TabBarController extends Controller {
  static targets = ["tab"]

  connect() {
    this._highlightCurrentTab()

    // Listen for Turbo navigation to keep tabs in sync
    document.addEventListener("turbo:load", this._highlightCurrentTab.bind(this))
    document.addEventListener("turbo:frame-load", this._highlightCurrentTab.bind(this))
  }

  disconnect() {
    document.removeEventListener("turbo:load", this._highlightCurrentTab.bind(this))
    document.removeEventListener("turbo:frame-load", this._highlightCurrentTab.bind(this))
  }

  switch(event) {
    this.tabTargets.forEach((tab) => {
      tab.classList.remove("ios-tab-bar__item--active")
      tab.setAttribute("aria-selected", "false")
    })
    event.currentTarget.classList.add("ios-tab-bar__item--active")
    event.currentTarget.setAttribute("aria-selected", "true")
  }

  _highlightCurrentTab() {
    const path = window.location.pathname
    this.tabTargets.forEach((tab) => {
      const href = tab.getAttribute("href")
      const isMatch = href === path || (href !== "/" && path.startsWith(href))
      tab.classList.toggle("ios-tab-bar__item--active", isMatch)
      tab.setAttribute("aria-selected", String(isMatch))
    })
  }
}


// -----------------------------------------------------------------------------
// ios26-sheet — Bottom sheet with drag-to-dismiss
//
// Usage:
//   <div data-controller="ios26-sheet"
//        data-ios26-sheet-detents-value='["medium","large"]'
//        data-ios26-sheet-initial-value="medium">
//     <div data-ios26-sheet-target="backdrop"
//          data-action="click->ios26-sheet#dismiss" class="ios-sheet-backdrop"></div>
//     <div data-ios26-sheet-target="panel" class="ios-sheet">
//       <div data-ios26-sheet-target="grabber"
//            data-action="pointerdown->ios26-sheet#startDrag" class="ios-sheet__grabber">
//         <div class="ios-sheet__grabber-pill"></div>
//       </div>
//       <div class="ios-sheet__content">...</div>
//     </div>
//   </div>
//
// Detents: "medium" = 50vh, "large" = 90vh
// -----------------------------------------------------------------------------
export class Ios26SheetController extends Controller {
  static targets = ["panel", "backdrop", "grabber"]
  static values = {
    detents: { type: Array, default: ["medium", "large"] },
    initial: { type: String, default: "medium" },
    open: { type: Boolean, default: true },
  }

  static DETENT_HEIGHTS = {
    small: 0.25,
    medium: 0.50,
    large: 0.90,
  }

  connect() {
    this._currentDetent = this.initialValue
    this._isDragging = false
    this._startY = 0
    this._startHeight = 0

    this._onPointerMove = this._onPointerMove.bind(this)
    this._onPointerUp = this._onPointerUp.bind(this)

    if (this.openValue) {
      this._applyDetent(this._currentDetent, true)
      this._showBackdrop()
    }
  }

  disconnect() {
    document.removeEventListener("pointermove", this._onPointerMove)
    document.removeEventListener("pointerup", this._onPointerUp)
  }

  // --- Actions ---

  startDrag(event) {
    event.preventDefault()
    this._isDragging = true
    this._startY = event.clientY
    this._startHeight = this.panelTarget.getBoundingClientRect().height

    document.addEventListener("pointermove", this._onPointerMove)
    document.addEventListener("pointerup", this._onPointerUp)

    this.panelTarget.style.transition = "none"
  }

  dismiss() {
    this.panelTarget.style.transition =
      `transform var(--ios-duration-slow) var(--ios-easing-decelerate)`
    this.panelTarget.style.transform = "translateY(100%)"
    this.backdropTarget.style.opacity = "0"

    setTimeout(() => {
      this.openValue = false
      this.element.remove()
    }, 350)
  }

  // --- Drag Handling ---

  _onPointerMove(event) {
    if (!this._isDragging) return

    const deltaY = event.clientY - this._startY
    const newHeight = Math.max(0, this._startHeight - deltaY)
    const maxHeight = window.innerHeight * 0.95

    this.panelTarget.style.height = `${Math.min(newHeight, maxHeight)}px`

    // Update backdrop opacity based on position
    const progress = newHeight / (window.innerHeight * 0.5)
    this.backdropTarget.style.opacity = String(Math.min(progress, 1))
  }

  _onPointerUp(event) {
    if (!this._isDragging) return
    this._isDragging = false

    document.removeEventListener("pointermove", this._onPointerMove)
    document.removeEventListener("pointerup", this._onPointerUp)

    const currentHeight = this.panelTarget.getBoundingClientRect().height
    const viewportHeight = window.innerHeight

    // Dismiss if dragged below 15% of viewport
    if (currentHeight < viewportHeight * 0.15) {
      this.dismiss()
      return
    }

    // Snap to nearest detent
    const nearestDetent = this._findNearestDetent(currentHeight / viewportHeight)
    this._currentDetent = nearestDetent
    this._applyDetent(nearestDetent, false)
  }

  _findNearestDetent(ratio) {
    let closest = this.detentsValue[0]
    let closestDist = Infinity

    for (const detent of this.detentsValue) {
      const target = Ios26SheetController.DETENT_HEIGHTS[detent] || 0.5
      const dist = Math.abs(ratio - target)
      if (dist < closestDist) {
        closestDist = dist
        closest = detent
      }
    }
    return closest
  }

  _applyDetent(detent, immediate) {
    const ratio = Ios26SheetController.DETENT_HEIGHTS[detent] || 0.5
    const height = `${ratio * 100}vh`

    if (immediate) {
      this.panelTarget.style.transition = "none"
    } else {
      this.panelTarget.style.transition =
        `height var(--ios-duration-slow) var(--ios-easing-spring)`
    }

    this.panelTarget.style.height = height
    this.panelTarget.style.transform = "translateY(0)"
  }

  _showBackdrop() {
    this.backdropTarget.style.opacity = "1"
  }
}


// -----------------------------------------------------------------------------
// ios26-alert — Alert dialog dismiss behavior
//
// Usage: See _ios26_helpers.html.erb alert partial
// Handles backdrop click and button dismiss actions.
// -----------------------------------------------------------------------------
export class Ios26AlertController extends Controller {
  dismiss() {
    this.element.style.opacity = "0"
    this.element.style.transition =
      `opacity var(--ios-duration-normal) var(--ios-easing-default)`
    setTimeout(() => this.element.remove(), 250)
  }

  backdropClick(event) {
    // Only dismiss if clicking the backdrop itself, not the alert content
    if (event.target === this.element) {
      this.dismiss()
    }
  }
}


// -----------------------------------------------------------------------------
// ios26-context-menu — Long press context menu
//
// Usage:
//   <div data-controller="ios26-context-menu"
//        data-action="pointerdown->ios26-context-menu#startPress
//                     pointerup->ios26-context-menu#cancelPress
//                     pointerleave->ios26-context-menu#cancelPress">
//     <template data-ios26-context-menu-target="menu">
//       <div class="ios-context-menu">
//         <button data-action="ios26-context-menu#select"
//                 data-value="copy">Copy</button>
//         <button data-action="ios26-context-menu#select"
//                 data-value="share">Share</button>
//         <hr>
//         <button data-action="ios26-context-menu#select"
//                 data-value="delete" class="ios-context-menu__item--destructive">
//           Delete
//         </button>
//       </div>
//     </template>
//     <!-- Triggerable content here -->
//   </div>
// -----------------------------------------------------------------------------
export class Ios26ContextMenuController extends Controller {
  static targets = ["menu"]
  static values = {
    delay: { type: Number, default: 500 },
  }

  connect() {
    this._timer = null
    this._activeMenu = null
    this._dismissHandler = this._onDocumentClick.bind(this)
  }

  disconnect() {
    this._cleanup()
    document.removeEventListener("click", this._dismissHandler)
  }

  startPress(event) {
    // Only respond to primary pointer (no right-click)
    if (event.button !== 0) return

    this._timer = setTimeout(() => {
      event.preventDefault()
      this._hapticFeedback()
      this._showMenu(event.clientX, event.clientY)
    }, this.delayValue)
  }

  cancelPress() {
    if (this._timer) {
      clearTimeout(this._timer)
      this._timer = null
    }
  }

  select(event) {
    const value = event.currentTarget.dataset.value
    this._cleanup()

    this.dispatch("selected", { detail: { value } })
  }

  _showMenu(x, y) {
    if (!this.hasMenuTarget) return

    // Scale down the triggering element for visual feedback
    this.element.style.transform = "scale(0.97)"
    this.element.style.transition =
      `transform var(--ios-duration-fast) var(--ios-easing-default)`

    // Clone menu template and position it
    const menuContent = this.menuTarget.content.cloneNode(true)
    const wrapper = document.createElement("div")
    wrapper.className = "ios-context-menu-overlay"
    wrapper.style.cssText = `
      position: fixed; inset: 0; z-index: 10000;
      background: rgba(0,0,0,0.3);
      animation: ios-fade-in var(--ios-duration-fast) var(--ios-easing-default);
    `

    const menuEl = menuContent.querySelector(".ios-context-menu")
    if (menuEl) {
      menuEl.style.cssText = `
        position: absolute;
        left: ${Math.min(x, window.innerWidth - 250)}px;
        top: ${Math.min(y, window.innerHeight - 200)}px;
        background: var(--ios-material-thick-bg);
        backdrop-filter: blur(var(--ios-blur-thick));
        -webkit-backdrop-filter: blur(var(--ios-blur-thick));
        border-radius: 14px;
        min-width: 220px;
        overflow: hidden;
        box-shadow: 0 8px 40px rgba(0,0,0,0.2);
        animation: ios-scale-in var(--ios-duration-normal) var(--ios-easing-spring);
      `
    }

    wrapper.appendChild(menuContent)
    document.body.appendChild(wrapper)
    this._activeMenu = wrapper

    document.addEventListener("click", this._dismissHandler)
  }

  _cleanup() {
    this.cancelPress()
    this.element.style.transform = ""

    if (this._activeMenu) {
      this._activeMenu.remove()
      this._activeMenu = null
    }
    document.removeEventListener("click", this._dismissHandler)
  }

  _onDocumentClick(event) {
    // Dismiss if clicking outside the context menu
    if (this._activeMenu && !event.target.closest(".ios-context-menu")) {
      this._cleanup()
    }
  }

  _hapticFeedback() {
    // Use Vibration API if available (Android + some browsers)
    if (navigator.vibrate) {
      navigator.vibrate(10)
    }
  }
}


// -----------------------------------------------------------------------------
// ios26-dark-mode — Manual dark mode toggle
//
// Usage:
//   <button data-controller="ios26-dark-mode"
//           data-action="ios26-dark-mode#toggle">
//     Toggle Dark Mode
//   </button>
//
// Adds/removes .ios26-dark class on <html> and persists preference
// in localStorage.
// -----------------------------------------------------------------------------
export class Ios26DarkModeController extends Controller {
  static values = {
    storageKey: { type: String, default: "ios26-dark-mode" },
  }

  connect() {
    this._applyStoredPreference()
  }

  toggle() {
    const html = document.documentElement
    const isDark = html.classList.toggle("ios26-dark")

    localStorage.setItem(this.storageKeyValue, isDark ? "dark" : "light")
    this.dispatch("changed", { detail: { dark: isDark } })
  }

  _applyStoredPreference() {
    const stored = localStorage.getItem(this.storageKeyValue)
    if (stored === "dark") {
      document.documentElement.classList.add("ios26-dark")
    } else if (stored === "light") {
      document.documentElement.classList.remove("ios26-dark")
    }
    // If no stored preference, respect system via CSS media query
  }
}


// =============================================================================
// Registration helper
// Import this in your controllers/index.js or application.js
//
// Usage:
//   import { registerIos26Controllers } from "controllers/ios26_controller"
//   registerIos26Controllers(application)
// =============================================================================
export function registerIos26Controllers(application) {
  application.register("ios26-toolbar", Ios26ToolbarController)
  application.register("ios26-tab-bar", Ios26TabBarController)
  application.register("ios26-sheet", Ios26SheetController)
  application.register("ios26-alert", Ios26AlertController)
  application.register("ios26-context-menu", Ios26ContextMenuController)
  application.register("ios26-dark-mode", Ios26DarkModeController)
}
