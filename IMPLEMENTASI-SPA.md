# Implementasi SPA (Single Page Application) untuk Materi Detail

## Overview

Implementasi ini mengubah sistem materi dari file HTML statis menjadi SPA dinamis yang mengambil data dari database Supabase.

## File yang Dibuat/Dimodifikasi

### 1. `materi-detail.html` (BARU)

- File SPA untuk menampilkan detail materi
- Menggunakan query parameter `?id=UUID` untuk mengambil data
- Struktur: Header → Pengertian Awal → Materi Inti → Latihan Praktis

### 2. `materi.html` (DIMODIFIKASI)

- Update fungsi `renderMateriCards()` untuk menggunakan link dinamis
- Link berubah dari `materi.link_url` menjadi `materi-detail.html?id=${materi.id}`

### 3. `update-nun-sukun.sql` (BARU)

- Script SQL untuk update database dengan konten lengkap
- Menambah kolom: `pengertian_awal`, `materi_inti`, `latihan_praktis`, `jumlah_hukum`
- Update data untuk 4 materi: Nun Sukun, Mim Sukun, Lam Ta'rif, Qalqalah

## Struktur Database

### Kolom Baru di Tabel `materi`:

```sql
ALTER TABLE materi ADD COLUMN IF NOT EXISTS pengertian_awal TEXT;
ALTER TABLE materi ADD COLUMN IF NOT EXISTS materi_inti JSONB;
ALTER TABLE materi ADD COLUMN IF NOT EXISTS latihan_praktis JSONB;
ALTER TABLE materi ADD COLUMN IF NOT EXISTS jumlah_hukum INTEGER DEFAULT 5;
```

### Format JSON untuk `materi_inti`:

```json
[
  {
    "id": 1,
    "judul": "الإظهار الحلق",
    "judul_latin": "Idzhar Halqi",
    "deskripsi": "Penjelasan hukum...",
    "contoh_ayat": "مَنْ آمَنَ",
    "terjemahan": "Dari orang yang beriman (QS. Al-Baqarah: 62)",
    "audio_url": "sound/idzhar halqi.opus",
    "tips": {
      "judul": "حروف الحلق",
      "konten": "أ - ع - غ - ح - خ - ه"
    }
  }
]
```

### Format JSON untuk `latihan_praktis`:

```json
[
  {
    "id": 1,
    "judul": "Latihan Praktis",
    "deskripsi": "Praktikkan bacaan berikut...",
    "contoh": "إِنَّ ٱلْإِنْسَٰنَ لَفِى خُسْرٍ",
    "terjemahan": "Sesungguhnya manusia...",
    "audio_url": "sound/contoh nun sukun.opus",
    "jawaban": "Latihan praktis...",
    "penjelasan": "Perhatikan hukum..."
  }
]
```

## Cara Implementasi

### 1. Jalankan Script SQL

```bash
# Buka Supabase Dashboard → SQL Editor
# Jalankan script update-nun-sukun.sql
```

### 2. Test Implementasi

1. Buka `materi.html`
2. Klik tombol "Pelajari" pada materi Nun Sukun & Tanwin
3. URL akan berubah menjadi: `materi-detail.html?id=UUID_MATERI`
4. Halaman akan menampilkan konten dinamis dari database

### 3. Verifikasi Data

```sql
-- Cek apakah data sudah terupdate
SELECT id, judul_latin, jumlah_hukum,
       CASE WHEN materi_inti IS NOT NULL THEN 'Ada' ELSE 'Tidak ada' END as materi_inti,
       CASE WHEN latihan_praktis IS NOT NULL THEN 'Ada' ELSE 'Tidak ada' END as latihan_praktis
FROM materi
ORDER BY created_at;
```

## Keuntungan Implementasi SPA

### 1. **Dinamis**

- Tidak perlu buat file HTML baru untuk setiap materi
- Konten bisa diupdate melalui database
- URL tetap konsisten: `materi-detail.html?id=UUID`

### 2. **Maintenance Mudah**

- Cukup update database untuk mengubah konten
- Tidak perlu edit file HTML manual
- Struktur konsisten untuk semua materi

### 3. **SEO Friendly**

- URL yang clean dan predictable
- Meta tags bisa diupdate dinamis
- Loading cepat karena SPA

### 4. **Scalable**

- Mudah tambah materi baru
- Bisa tambah fitur baru tanpa ubah struktur
- Support untuk berbagai jenis konten

## Struktur Konten

### 1. **Header Materi**

- Gambar background
- Judul Arab dan Latin
- Meta info (jumlah hukum, level)

### 2. **Pengertian Awal**

- Definisi materi dalam bahasa Arab
- Penjelasan konsep dasar

### 3. **Materi Inti (Array)**

- List hukum-hukum dengan:
  - Judul Arab & Latin
  - Deskripsi
  - Contoh ayat
  - Audio file
  - Tips box

### 4. **Latihan Praktis (Array)**

- Latihan dengan:
  - Judul latihan
  - Deskripsi
  - Contoh ayat
  - Audio file
  - Jawaban & penjelasan

## Troubleshooting

### Error: "ID materi tidak ditemukan"

- Pastikan URL memiliki parameter `?id=UUID`
- Cek apakah UUID valid di database

### Error: "Materi tidak ditemukan"

- Pastikan data ada di database
- Cek koneksi Supabase

### Error: "Error parsing materi inti"

- Pastikan format JSON valid
- Cek struktur data di database

### Audio tidak muncul

- Pastikan file audio ada di folder `sound/`
- Cek path file di database

## Next Steps

### 1. **Admin Panel Enhancement**

- Buat form untuk tambah/edit materi
- Upload gambar dan audio
- Preview konten sebelum publish

### 2. **Fitur Tambahan**

- Progress tracking user
- Bookmark materi
- Share materi
- Print materi

### 3. **Optimization**

- Lazy loading untuk audio
- Image optimization
- Caching strategy

## Testing Checklist

- [ ] Database updated dengan script SQL
- [ ] `materi.html` menampilkan link dinamis
- [ ] `materi-detail.html` bisa load berdasarkan ID
- [ ] Konten Nun Sukun & Tanwin tampil lengkap
- [ ] Audio files bisa diputar
- [ ] Responsive design berfungsi
- [ ] Error handling berfungsi
- [ ] Loading state tampil dengan benar
