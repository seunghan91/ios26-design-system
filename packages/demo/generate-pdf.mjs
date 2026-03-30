import puppeteer from 'puppeteer-core';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { execSync } from 'child_process';

const __dirname = dirname(fileURLToPath(import.meta.url));

// Find Chrome
function findChrome() {
  const paths = [
    '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
    '/Applications/Chromium.app/Contents/MacOS/Chromium',
    '/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge',
  ];
  for (const p of paths) {
    try { execSync(`test -f "${p}"`); return p; } catch {}
  }
  throw new Error('No Chrome found');
}

async function generatePDF() {
  const browser = await puppeteer.launch({
    headless: true,
    executablePath: findChrome(),
  });
  const page = await browser.newPage();

  // Set viewport wide enough for good layout
  await page.setViewport({ width: 1200, height: 800 });

  // Navigate to the demo page via local server
  await page.goto('http://localhost:8787/packages/demo/index.html', {
    waitUntil: 'networkidle0',
    timeout: 30000,
  });

  // Wait for images/backgrounds to load
  await new Promise(r => setTimeout(r, 2000));

  // Generate Light mode PDF
  const lightPath = join(__dirname, 'ios26-design-system-light.pdf');
  await page.pdf({
    path: lightPath,
    format: 'A4',
    printBackground: true,
    margin: { top: '20px', bottom: '20px', left: '20px', right: '20px' },
    displayHeaderFooter: true,
    headerTemplate: '<div></div>',
    footerTemplate: '<div style="font-size:8px; text-align:center; width:100%; color:#999;">iOS 26 Design System — github.com/seunghan91/ios26-design-system — Page <span class="pageNumber"></span> of <span class="totalPages"></span></div>',
  });
  console.log(`Light PDF saved: ${lightPath}`);

  // Switch to dark mode
  await page.evaluate(() => {
    document.documentElement.classList.add('dark');
  });
  await new Promise(r => setTimeout(r, 500));

  // Generate Dark mode PDF
  const darkPath = join(__dirname, 'ios26-design-system-dark.pdf');
  await page.pdf({
    path: darkPath,
    format: 'A4',
    printBackground: true,
    margin: { top: '20px', bottom: '20px', left: '20px', right: '20px' },
    displayHeaderFooter: true,
    headerTemplate: '<div></div>',
    footerTemplate: '<div style="font-size:8px; text-align:center; width:100%; color:#666;">iOS 26 Design System (Dark) — github.com/seunghan91/ios26-design-system — Page <span class="pageNumber"></span> of <span class="totalPages"></span></div>',
  });
  console.log(`Dark PDF saved: ${darkPath}`);

  await browser.close();
  console.log('Done!');
}

generatePDF().catch(console.error);
