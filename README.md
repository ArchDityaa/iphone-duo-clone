# iPhone Duo — Static Mirror of apple.com/iphone-duo

Mirror statis dari https://www.apple.com/iphone-duo/ agar bisa di-hosting ulang di Vercel atau dijalankan lokal dengan satu perintah.

> Untuk tujuan edukasi / arsip. Seluruh aset © Apple Inc.

## Demo lokal
- `http://localhost:3000/` (python http.server, berjalan di background)

## Struktur
- `index.html` — HTML asli apple.com (~730 KB, title `iPhone Duo - Apple`)
- `v/` — CSS/JS/images resmi iPhone Duo (~78 MB, `overview.built.css`, `main.built.js`)
- `ac/` — globalfooter, films, pricing Apple
- `api-www/` — globalheader Apple
- `metrics/` — analytics (opsional, boleh dihapus)
- `vercel.json` — config deploy statis
- `package.json` — `npm start` → `serve -s . -l 3000`
- `update.sh` — re-mirror terbaru via wget + curl

## Jalankan lokal
```bash
# cara 1 — tanpa install (disarankan)
python3 -m http.server 3000
# buka http://localhost:3000/

# cara 2 — node
npx -y serve -s . -l 3000
# atau
npm start
```

## Deploy ke Vercel
```bash
vercel --prod
# dashboard: import repo ini, framework = Other, output = ./
```
`vercel.json` memakai `cleanUrls` + rewrite `/iphone-duo` → `/index.html`.

## Cara mirror ulang
```bash
bash update.sh
```
Isinya: `wget --mirror --page-requisites --no-parent -e robots=off --domains=www.apple.com,apple.com --span-hosts https://www.apple.com/iphone-duo/` + `curl` HTML mentah ke `index.html`.

## Catatan
- Font `/wss/fonts` dan video/film `.m3u8`/`.usdz` tetap stream dari `www.apple.com` agar hemat kuota Vercel (limit ~100 MB).
- Link navigasi global (`/mac/`, `/iphone/`, dll) tetap ke apple.com — wajar untuk clone statis.
- Di-mirror tanggal 2026-10-15, 759 file, ~81 MB.
