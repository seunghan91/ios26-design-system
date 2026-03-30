# iOS 26 Color Tokens — Full Reference

79 variables × 4 modes: Light, Dark, Increased Contrast Light, Increased Contrast Dark.

## Accents

| Color | Light | Dark | IC-Light | IC-Dark |
|-------|-------|------|----------|---------|
| red | #ff383c | #ff4245 | #e9152d | #ff6165 |
| orange | #ff8d28 | #ff9230 | #c55300 | #ffa056 |
| yellow | #ffcc00 | #ffd600 | #a16a00 | #fedf43 |
| green | #34c759 | #30d158 | #008932 | #4ae968 |
| mint | #00c8b3 | #00dac3 | #008575 | #54dfcb |
| teal | #00c3d0 | #00d2e0 | #008198 | #3bddec |
| cyan | #00c0e8 | #3cd3fe | #007eae | #6dd9ff |
| blue | #0088ff | #0091ff | #1e6ef4 | #5cb8ff |
| indigo | #6155f5 | #6d7cff | #564ade | #a7aaff |
| purple | #cb30e0 | #db34f2 | #b02fc2 | #ea8dff |
| pink | #ff2d55 | #ff375f | #e7124d | #ff8ac4 |
| brown | #ac7f5e | #b78a66 | #956d51 | #dba679 |

## Labels

| Token | Light | Dark |
|-------|-------|------|
| primary | #000 a:1 | #fff a:1 |
| secondary | #3c3c43 a:0.6 | #ebebf5 a:0.7 |
| tertiary | #3c3c43 a:0.3 | #ebebf5 a:0.3 |
| quaternary | #3c3c43 a:0.18 | #ebebf5 a:0.16 |

## Labels Vibrant

| Token | Light | Dark |
|-------|-------|------|
| primary | #1a1a1a | #f5f5f5 |
| secondary | #727272 | #8a8a8a |
| tertiary | #bfbfbf | #404040 |
| quaternary | #d9d9d9 | #262626 |

## Backgrounds

| Token | Light | Dark |
|-------|-------|------|
| primary | #ffffff | #000000 |
| secondary | #f2f2f7 | #1c1c1e |
| tertiary | #ffffff | #2c2c2e |
| primaryElevated | #ffffff | #1c1c1e |
| secondaryElevated | #f2f2f7 | #2c2c2e |
| tertiaryElevated | #ffffff | #3a3a3c |

## Backgrounds Grouped

| Token | Light | Dark |
|-------|-------|------|
| primary | #f2f2f7 | #000000 |
| secondary | #ffffff | #1c1c1e |
| tertiary | #f2f2f7 | #2c2c2e |

## Fills

| Token | Light | Dark |
|-------|-------|------|
| primary | #787878 a:0.2 | #787880 a:0.36 |
| secondary | #787880 a:0.16 | #787880 a:0.32 |
| tertiary | #767680 a:0.12 | #767680 a:0.24 |
| quaternary | #747480 a:0.08 | #767680 a:0.18 |

## Grays

| Token | Light | Dark |
|-------|-------|------|
| gray | #8e8e93 | #8e8e93 |
| gray2 | #aeaeb2 | #636366 |
| gray3 | #c7c7cc | #48484a |
| gray4 | #d1d1d6 | #3a3a3c |
| gray5 | #e5e5ea | #2c2c2e |
| gray6 | #f2f2f7 | #1c1c1e |

## Separators

| Token | Light | Dark |
|-------|-------|------|
| opaque | #c6c6c8 | #38383a |
| nonOpaque | #000 a:0.12 | #fff a:0.17 |
| vibrant | #e6e6e6 | #1a1a1a |

## Overlays

| Token | Light | Dark |
|-------|-------|------|
| default | #000 a:0.2 | #000 a:0.48 |
| activityView | #000 a:0.2 | #000 a:0.29 |
| alert | #29293a a:0.23 | #121212 a:0.56 |

## Semantic Radius

| Element | Radius |
|---------|--------|
| card | 12px |
| button | 12px |
| alert | 14px |
| menu | 14px |
| popover | 14px |
| notification | 20px |
| sheet iPhone top | 34pt |
| sheet iPhone bottom | 58pt |
| sheet iPad | 38pt |
| Liquid Glass small | 9999px (pill) |
| Liquid Glass medium | 20px |
| Liquid Glass large | 24px |

## CSS Usage

```css
/* Import all color tokens */
@import '@ios26_design_system/tokens/css';

/* Use tokens */
.card {
  background: var(--color-bg-secondary);
  color: var(--color-label-primary);
  border: 1px solid var(--color-separator-opaque);
  border-radius: 12px;
}
```

## JS Usage

```js
import { colors } from '@ios26_design_system/tokens';

// Access any token
colors.accents.blue.light  // "#0088ff"
colors.accents.blue.dark   // "#0091ff"
colors.labels.primary.light.hex  // "#000000"
```
