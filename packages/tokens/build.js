import StyleDictionary from 'style-dictionary';
import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

// ── Read source tokens ──
const colors = JSON.parse(readFileSync(join(__dirname, 'src/colors.json'), 'utf8'));
const typography = JSON.parse(readFileSync(join(__dirname, 'src/typography.json'), 'utf8'));
const materials = JSON.parse(readFileSync(join(__dirname, 'src/materials.json'), 'utf8'));
const spacing = JSON.parse(readFileSync(join(__dirname, 'src/spacing.json'), 'utf8'));
const animations = JSON.parse(readFileSync(join(__dirname, 'src/animations.json'), 'utf8'));

// ── Ensure output dirs ──
['dist/css', 'dist/js', 'dist/dart'].forEach(d => {
  const p = join(__dirname, d);
  if (!existsSync(p)) mkdirSync(p, { recursive: true });
});

// ══════════════════════════════════════════════
// CSS Custom Properties Generation
// ══════════════════════════════════════════════

function generateColorCSS(colors) {
  let light = ':root {\n';
  let dark = ':root[data-theme="dark"],\n@media (prefers-color-scheme: dark) { :root {\n';

  // Accents
  for (const [name, vals] of Object.entries(colors.accents || {})) {
    light += `  --color-accent-${name}: ${vals.light};\n`;
    dark += `  --color-accent-${name}: ${vals.dark};\n`;
  }

  // Labels
  for (const [name, vals] of Object.entries(colors.labels || {})) {
    if (vals.light?.hex) {
      const a = vals.light.a ?? 1;
      light += `  --color-label-${name}: ${vals.light.hex}${a < 1 ? hexAlpha(a) : ''};\n`;
      const da = vals.dark?.a ?? 1;
      dark += `  --color-label-${name}: ${vals.dark.hex}${da < 1 ? hexAlpha(da) : ''};\n`;
    }
  }

  // Backgrounds
  for (const [name, vals] of Object.entries(colors.backgrounds || {})) {
    light += `  --color-bg-${kebab(name)}: ${vals.light};\n`;
    dark += `  --color-bg-${kebab(name)}: ${vals.dark};\n`;
  }

  // Backgrounds Grouped
  for (const [name, vals] of Object.entries(colors.backgroundsGrouped || {})) {
    light += `  --color-bg-grouped-${kebab(name)}: ${vals.light};\n`;
    dark += `  --color-bg-grouped-${kebab(name)}: ${vals.dark};\n`;
  }

  // Fills
  for (const [name, vals] of Object.entries(colors.fills || {})) {
    if (vals.light?.hex) {
      light += `  --color-fill-${name}: ${vals.light.hex}${hexAlpha(vals.light.a)};\n`;
      dark += `  --color-fill-${name}: ${vals.dark.hex}${hexAlpha(vals.dark.a)};\n`;
    }
  }

  // Grays
  for (const [name, vals] of Object.entries(colors.grays || {})) {
    if (typeof vals === 'string') {
      light += `  --color-gray-${name}: ${vals};\n`;
      dark += `  --color-gray-${name}: ${vals};\n`;
    } else if (vals.light) {
      light += `  --color-gray-${name}: ${vals.light};\n`;
      dark += `  --color-gray-${name}: ${vals.dark};\n`;
    }
  }

  // Separators
  for (const [name, vals] of Object.entries(colors.separators || {})) {
    if (typeof vals.light === 'string') {
      light += `  --color-separator-${name}: ${vals.light};\n`;
      dark += `  --color-separator-${name}: ${vals.dark};\n`;
    } else if (vals.light?.hex) {
      light += `  --color-separator-${name}: ${vals.light.hex}${hexAlpha(vals.light.a)};\n`;
      dark += `  --color-separator-${name}: ${vals.dark.hex}${hexAlpha(vals.dark.a)};\n`;
    }
  }

  // Overlays
  for (const [name, vals] of Object.entries(colors.overlays || {})) {
    if (vals.light?.hex) {
      light += `  --color-overlay-${name}: ${vals.light.hex}${hexAlpha(vals.light.a)};\n`;
      dark += `  --color-overlay-${name}: ${vals.dark.hex}${hexAlpha(vals.dark.a)};\n`;
    }
  }

  light += '}\n';
  dark += '}}\n';

  return `/* iOS 26 Design Tokens — Colors */\n/* Auto-generated from tokens/colors.json */\n\n${light}\n${dark}`;
}

function generateTypographyCSS(typo) {
  let css = `/* iOS 26 Design Tokens — Typography */\n/* Font: ${typo.fontFamily} */\n\n:root {\n`;
  css += `  --font-family: "${typo.fontFamily}", ${typo.fallback};\n\n`;

  for (const [name, style] of Object.entries(typo.styles || {})) {
    const k = kebab(name);
    css += `  --font-${k}-size: ${style.fontSize}px;\n`;
    css += `  --font-${k}-line-height: ${style.lineHeight}px;\n`;
    css += `  --font-${k}-letter-spacing: ${style.letterSpacing}px;\n`;
    css += `  --font-${k}-weight: ${fontWeight(style.regular)};\n`;
    if (style.emphasized) {
      css += `  --font-${k}-weight-emphasized: ${fontWeight(style.emphasized)};\n`;
    }
    css += '\n';
  }
  css += '}\n\n';

  // Utility classes
  for (const [name, style] of Object.entries(typo.styles || {})) {
    const k = kebab(name);
    css += `.ios26-${k} {\n`;
    css += `  font-family: var(--font-family);\n`;
    css += `  font-size: var(--font-${k}-size);\n`;
    css += `  line-height: var(--font-${k}-line-height);\n`;
    css += `  letter-spacing: var(--font-${k}-letter-spacing);\n`;
    css += `  font-weight: var(--font-${k}-weight);\n`;
    css += '}\n';
    css += `.ios26-${k}--emphasized {\n`;
    css += `  font-weight: var(--font-${k}-weight-emphasized);\n`;
    css += '}\n\n';
  }

  return css;
}

function generateMaterialsCSS(mat) {
  let css = `/* iOS 26 Design Tokens — Materials (Liquid Glass) */\n\n`;

  // Liquid Glass utility classes
  const lg = mat.liquidGlass?.regular;
  if (lg) {
    for (const [size, vals] of Object.entries(lg)) {
      css += `.ios26-liquid-glass-${size.substring(0, 2)} {\n`;
      css += `  backdrop-filter: blur(${vals.frostRadius}px);\n`;
      css += `  -webkit-backdrop-filter: blur(${vals.frostRadius}px);\n`;
      if (vals.light?.bg) {
        css += `  background: ${vals.light.bg.hex || vals.light.bg}${vals.light.bg.a ? hexAlpha(vals.light.bg.a) : ''};\n`;
      }
      css += `  box-shadow: 0 0 ${vals.light?.shadow?.blur || 40}px rgba(0,0,0,0.1);\n`;
      css += `  border-radius: ${size === 'small' ? '9999px' : size === 'medium' ? '20px' : '24px'};\n`;
      css += '}\n\n';
    }
  }

  // Background materials
  const bg = mat.backgroundMaterials;
  if (bg) {
    for (const [name, vals] of Object.entries(bg)) {
      css += `.ios26-material-${name} {\n`;
      css += `  backdrop-filter: blur(${vals.blurRadius}px);\n`;
      css += `  -webkit-backdrop-filter: blur(${vals.blurRadius}px);\n`;
      css += `  background: rgba(255,255,255,${vals.bgOpacity});\n`;
      css += '}\n\n';
    }
  }

  return css;
}

function generateAnimationsCSS(anim) {
  let css = `/* iOS 26 Design Tokens — Animations */\n\n:root {\n`;

  // Durations
  for (const [name, val] of Object.entries(anim.duration || {})) {
    if (typeof val === 'number') {
      css += `  --duration-${name}: ${val}s;\n`;
    }
  }
  css += '\n';

  // Semantic durations
  for (const [name, val] of Object.entries(anim.duration?.semantic || {})) {
    css += `  --duration-${kebab(name)}: ${val}s;\n`;
  }
  css += '\n';

  // Easings
  for (const [name, val] of Object.entries(anim.easing || {})) {
    if (typeof val === 'string') {
      css += `  --easing-${kebab(name)}: ${val};\n`;
    }
  }
  // Spring approximations
  for (const [name, val] of Object.entries(anim.easing?.spring || {})) {
    if (typeof val === 'string') {
      css += `  --easing-spring-${name}: ${val};\n`;
    }
  }

  css += '}\n';
  return css;
}

// ── JS/TS module generation ──
function generateJSModule() {
  return `// iOS 26 Design Tokens — ES Module
// Auto-generated — do not edit

export const colors = ${JSON.stringify(colors, null, 2)};
export const typography = ${JSON.stringify(typography, null, 2)};
export const materials = ${JSON.stringify(materials, null, 2)};
export const spacing = ${JSON.stringify(spacing, null, 2)};
export const animations = ${JSON.stringify(animations, null, 2)};

export default { colors, typography, materials, spacing, animations };
`;
}

function generateCJSModule() {
  return `// iOS 26 Design Tokens — CommonJS
// Auto-generated — do not edit

const colors = ${JSON.stringify(colors, null, 2)};
const typography = ${JSON.stringify(typography, null, 2)};
const materials = ${JSON.stringify(materials, null, 2)};
const spacing = ${JSON.stringify(spacing, null, 2)};
const animations = ${JSON.stringify(animations, null, 2)};

module.exports = { colors, typography, materials, spacing, animations };
`;
}

function generateDTS() {
  return `// iOS 26 Design Tokens — TypeScript Declarations
export declare const colors: typeof import('../src/colors.json');
export declare const typography: typeof import('../src/typography.json');
export declare const materials: typeof import('../src/materials.json');
export declare const spacing: typeof import('../src/spacing.json');
export declare const animations: typeof import('../src/animations.json');

declare const tokens: {
  colors: typeof colors;
  typography: typeof typography;
  materials: typeof materials;
  spacing: typeof spacing;
  animations: typeof animations;
};
export default tokens;
`;
}

// ── Dart generation ──
function generateDart() {
  let dart = `// iOS 26 Design Tokens for Flutter\n// Auto-generated — do not edit\n\nimport 'dart:ui';\n\n`;

  // Color helper
  dart += `Color _hex(String hex, [double opacity = 1.0]) {\n`;
  dart += `  hex = hex.replaceFirst('#', '');\n`;
  dart += `  if (hex.length == 6) hex = 'FF\$hex';\n`;
  dart += `  return Color(int.parse(hex, radix: 16)).withOpacity(opacity);\n`;
  dart += `}\n\n`;

  // Accent colors
  dart += `class IOS26Colors {\n  IOS26Colors._();\n\n`;
  for (const [name, vals] of Object.entries(colors.accents || {})) {
    dart += `  static final ${name}Light = _hex('${vals.light}');\n`;
    dart += `  static final ${name}Dark = _hex('${vals.dark}');\n`;
  }
  dart += `}\n`;

  return dart;
}

// ── Helpers ──
function kebab(s) { return s.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase(); }
function hexAlpha(a) { return Math.round(a * 255).toString(16).padStart(2, '0'); }
function fontWeight(w) {
  const map = { 'Regular': 400, 'Medium': 500, 'Semibold': 600, 'Bold': 700 };
  return map[w] || 400;
}

// ══════════════════════════════════════════════
// Build
// ══════════════════════════════════════════════

console.log('Building @ios26/tokens...');

writeFileSync(join(__dirname, 'dist/css/tokens.css'), generateColorCSS(colors));
writeFileSync(join(__dirname, 'dist/css/typography.css'), generateTypographyCSS(typography));
writeFileSync(join(__dirname, 'dist/css/materials.css'), generateMaterialsCSS(materials));
writeFileSync(join(__dirname, 'dist/css/animations.css'), generateAnimationsCSS(animations));
writeFileSync(join(__dirname, 'dist/index.js'), generateJSModule());
writeFileSync(join(__dirname, 'dist/index.cjs'), generateCJSModule());
writeFileSync(join(__dirname, 'dist/index.d.ts'), generateDTS());
writeFileSync(join(__dirname, 'dist/dart/ios26_tokens.dart'), generateDart());

console.log('✓ dist/css/tokens.css');
console.log('✓ dist/css/typography.css');
console.log('✓ dist/css/materials.css');
console.log('✓ dist/css/animations.css');
console.log('✓ dist/index.js (ESM)');
console.log('✓ dist/index.cjs (CJS)');
console.log('✓ dist/index.d.ts');
console.log('✓ dist/dart/ios26_tokens.dart');
console.log('Done!');
