# Checklist Setup Supabase - Media Pembelajaran Tajwid

## ✅ Langkah 1: Buat Project Supabase

- [ ] Daftar/Login ke [supabase.com](https://supabase.com)
- [ ] Klik "New Project"
- [ ] Pilih organization
- [ ] Isi nama project: `tajwid-master`
- [ ] Buat database password yang kuat
- [ ] Pilih region: Asia Southeast
- [ ] Klik "Create new project"
- [ ] Tunggu setup selesai (5-10 menit)

## ✅ Langkah 2: Setup Database

- [ ] Buka project Supabase yang baru dibuat
- [ ] Pergi ke menu "SQL Editor"
- [ ] Copy isi file `database-setup.sql`
- [ ] Paste ke SQL Editor
- [ ] Klik "Run" untuk menjalankan script
- [ ] Cek di menu "Table Editor" apakah tabel `materi` sudah terbuat

## ✅ Langkah 3: Dapatkan API Keys

- [ ] Di dashboard Supabase, pergi ke "Settings" → "API"
- [ ] Copy **Project URL** (format: https://xxx.supabase.co)
- [ ] Copy **anon public** key (panjang string)
- [ ] Simpan kedua informasi ini

## ✅ Langkah 4: Environment Variables (Hard-coded)

- [ ] Environment variables sudah hard-coded di `env.js`
- [ ] Tidak perlu file `.env` lagi
- [ ] Konfigurasi sudah siap pakai

## ✅ Langkah 5: Test Environment Variables

- [ ] Buka `materi.html` di browser
- [ ] Cek console untuk memastikan environment variables ter-load
- [ ] Pastikan tidak ada error

## ✅ Langkah 6: Test Koneksi

- [ ] Buka file `materi.html` di browser
- [ ] Buka Developer Tools (F12)
- [ ] Pergi ke tab "Console"
- [ ] Cek apakah ada error
- [ ] Data materi seharusnya muncul dari database

## ✅ Langkah 7: Test Admin Panel (Opsional)

- [ ] Buka file `admin-panel.html`
- [ ] Test tambah materi baru
- [ ] Test edit materi
- [ ] Test hapus materi

## 🔧 Troubleshooting

### Error: "Environment variables tidak ditemukan"

- [ ] Pastikan `env.js` sudah dimuat dengan benar
- [ ] Cek apakah file `env.js` ada
- [ ] Pastikan load sebelum script lain

### Error: "getEnv is not defined"

- [ ] Pastikan `env.js` sudah dimuat
- [ ] Cek apakah file `env.js` ada
- [ ] Pastikan load sebelum script lain

### Error: "Supabase connection failed"

- [ ] Cek apakah URL Supabase sudah benar di `env.js`
- [ ] Cek apakah API key sudah benar di `env.js`
- [ ] Pastikan project Supabase masih aktif

## 📝 File Structure

```
project/
├── database-setup.sql     # SQL setup database
├── env-loader.js          # Environment loader (simplified)
├── env.js                 # Hard-coded environment variables
├── supabase-offline.js    # Offline Supabase client
├── SETUP-CHECKLIST.md     # Checklist ini
├── materi.html            # Halaman materi
├── admin-panel.html       # Panel admin
└── [file HTML lainnya]
```

## 🎉 Selamat!

Setelah semua checklist selesai, aplikasi Media Pembelajaran Tajwid Anda sudah terintegrasi dengan Supabase dan siap digunakan!
