<div align="center">

# iPhone Duo — Static Mirror

**Pixel-faithful static clone of `apple.com/iphone-duo` — run locally in 1 command or deploy to Vercel.**

[![Vercel](https://img.shields.io/badge/deploy-vercel-black?style=flat-square&logo=vercel)](https://vercel.com/new/clone?repository-url=https://github.com/ArchDityaa/iphone-duo-clone)
[![Static](https://img.shields.io/badge/site-static-blue?style=flat-square)]()
[![Size](https://img.shields.io/badge/size-~81_MB-orange?style=flat-square)]()
[![Source](https://img.shields.io/badge/source-apple.com-lightgrey?style=flat-square)](https://www.apple.com/iphone-duo/)

[Live Demo](#deploy-ke-vercel) · [Quickstart](#quickstart) · [Structure](#struktur) · [Re-mirror](#re-mirror) · [Disclaimer](#disclaimer)

</div>

---

## Preview

| Hero | Highlights | Camera |
|------|------------|--------|
| Foldable Duo display | Battery / A20 Pro / Durability | 48MP Dual Fusion |

> Screenshot asli menyusul — sementara bandingkan langsung: `http://localhost:3000/` vs https://www.apple.com/iphone-duo/

Meta asli yang di-mirror:

```html
<title>iPhone Duo - Apple</title>
<meta name="description" content="iPhone Duo. The largest iPhone display ever. In a thin, foldable design. 48MP Dual Fusion camera system. A20 Pro chip. All-day battery life." />
```

## Fitur

- **1:1 HTML** — `index.html` mentah dari Apple (~730 KB, 476 referensi `iphone-duo`), bukan rekayasa ulang
- **Aset lokal** — CSS `overview.built.css` (1.5 MB), JS `head/main/welcome.built.js`, ~750 images responsive (`large/medium/small`, `@2x`)
- **Zero-build** — tanpa bundler, tanpa framework. `vercel.json` + `package.json` saja
- **Vercel-ready** — `cleanUrls` + rewrite `/iphone-duo → /index.html`, total ~81 MB / 759 file
- **Hemat kuota** — font `/wss/fonts`, video `.m3u8`, AR `.usdz` tetap stream dari `www.apple.com`
- **Reproducible** — `update.sh` untuk re-mirror kapan saja

## Stack

| Layer | Detail |
|-------|--------|
| Markup | HTML5 Apple (`page-overview`, `AutoARQL`, `FocusManager`) |
| Style | `v/iphone-duo/d/built/styles/overview.built.css` + `ac/globalfooter` + `api-www/globalheader` |
| Script | `head.built.js` / `main.built.js` (794 KB) / `welcome.built.js` + `ac-films`, `autopricing` |
| Serve | `python3 -m http.server` atau `npx serve` |
| Deploy | Vercel Static (`Other`, output `./`) |

## Quickstart

```bash
git clone https://github.com/ArchDityaa/iphone-duo-clone.git
cd iphone-duo-clone

# Opsi A — tanpa install (disarankan)
python3 -m http.server 3000
# → http://localhost:3000/

# Opsi B — node
npm start
# → npx -y serve -s . -l 3000
```

Verifikasi:

```bash
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:3000/
# 200
curl -s http://localhost:3000/ | grep -o "<title>[^<]*</title>"
# <title>iPhone Duo - Apple</title>
```

## Deploy ke Vercel

**CLI:**

```bash
vercel --prod
```

**Dashboard:**

1. Import repo ini
2. Framework: `Other`
3. Build: _(kosong)_ · Output: `./`
4. Deploy

Config (`vercel.json`):

```json
{
  "cleanUrls": true,
  "trailingSlash": false,
  "rewrites": [{ "source": "/iphone-duo", "destination": "/index.html" }]
}
```

## Struktur

```
iphone-duo-clone/
├── index.html                  # HTML asli apple.com/iphone-duo
├── v/iphone-duo/d/
│   ├── built/styles/           # overview.built.css, specs.built.css
│   ├── built/scripts/overview/ # head / main / welcome.built.js
│   └── images/overview/        # hero, highlights, camera, design,
│                               # versatility, incentive, contrast, …
├── ac/                         # globalfooter, ac-films, pricing, localeswitcher
├── api-www/                    # globalheader (globalnav)
├── metrics/                    # analytics (opsional, aman dihapus)
├── vercel.json
├── package.json
└── update.sh
```

## Re-mirror

Ambil versi terbaru dari Apple:

```bash
bash update.sh
```

Ekuivalen manual:

```bash
wget --mirror --page-requisites --no-parent -e robots=off \
  --domains=www.apple.com,apple.com --span-hosts \
  https://www.apple.com/iphone-duo/
curl -sL -A "Mozilla/5.0" https://www.apple.com/iphone-duo/ -o index.html
```

Snapshot saat ini: **2026-10-15 · 759 file · ~81 MB**.

## Batasan yang diketahui

- Navigasi global (`/mac/`, `/iphone/`, `/support/`, …) tetap menunjuk ke `apple.com`
- Pricing/trade-in (`/us/shop/mcm/*`) butuh API Apple, tidak ikut di-mirror
- Beberapa film AR/USdz + HLS (`.m3u8`) di-load remote — butuh internet

## Disclaimer

Proyek arsip/edukasi. Seluruh desain, citra, dan merek **© Apple Inc.** Jangan gunakan untuk meniru situs resmi atau tujuan komersial.

---

<div align="center">

**Mirror:** `wget --mirror` · **Serve:** `python3 -m http.server 3000` · **Deploy:** `vercel --prod`

</div>
