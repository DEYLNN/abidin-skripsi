# Soal Database Integration - Media Pembelajaran Tajwid

## Overview

Sistem ini telah diupdate untuk mengambil soal (pertanyaan) dari database Supabase instead of hardcoded content. Setiap halaman latihan sekarang akan memuat soal secara dinamis dari tabel `soal` di database.

## Files Updated

### 1. `soal-service.js` (New)

- Service module untuk menghandle operasi database soal
- Menggunakan Supabase client untuk fetch data
- Mendukung kategori: harian, mingguan, ujian
- Mendukung tipe soal: essay dan pilihan ganda

### 2. `latihan_harian.html`

- Updated untuk load soal dari database dengan kategori 'harian'
- Menambahkan script imports untuk env.js, supabase-offline.js, dan soal-service.js

### 3. `latihan_mingguan.html`

- Updated untuk load soal dari database dengan kategori 'mingguan'
- Menambahkan script imports untuk env.js, supabase-offline.js, dan soal-service.js

### 4. `latihan_ujikompetensi.html`

- Updated untuk load soal dari database dengan kategori 'ujian'
- Menambahkan script imports untuk env.js, supabase-offline.js, dan soal-service.js

### 5. `insert-sample-soal.sql` (New)

- Script SQL untuk insert sample soal ke database
- Berisi 15 soal sample (5 untuk setiap kategori)
- Mendukung tipe soal essay dan pilihan ganda

## Database Structure

### Tabel `soal`

```sql
CREATE TABLE IF NOT EXISTS soal (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    kategori VARCHAR(50) NOT NULL CHECK (kategori IN ('harian', 'mingguan', 'ujian')),
    pertanyaan TEXT NOT NULL,
    tipe_soal VARCHAR(20) NOT NULL CHECK (tipe_soal IN ('pilihan_ganda', 'essay')),
    jawaban_benar TEXT NOT NULL,
    pilihan_jawaban JSONB,
    penjelasan TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## How It Works

### 1. Page Load Process

1. Page loads dengan loading indicator
2. Script `soal-service.js` diinisialisasi
3. `loadSoal()` function dipanggil dengan kategori yang sesuai
4. Data di-fetch dari Supabase database
5. Soal di-render ke dalam container dengan styling yang sesuai

### 2. Soal Rendering

- **Essay Questions**: Menampilkan pertanyaan dengan space untuk jawaban
- **Multiple Choice**: Menampilkan pertanyaan dengan pilihan jawaban A, B, C, D
- **Arabic Text**: Mendukung rendering teks Arab dengan font Amiri
- **Verse Extraction**: Otomatis mengekstrak ayat dari pertanyaan jika ada tanda kutip

### 3. Error Handling

- Fallback content jika database tidak tersedia
- Loading indicator selama proses fetch
- Error message dengan tombol reload jika gagal

## Setup Instructions

### 1. Database Setup

```sql
-- Run the complete database setup
\i setup-database-complete.sql

-- Insert sample soal
\i insert-sample-soal.sql
```

### 2. File Dependencies

Pastikan file-file berikut ada di root directory:

- `env.js` - Environment variables
- `supabase-offline.js` - Supabase client
- `soal-service.js` - Soal service module

### 3. Testing

1. Buka `latihan_harian.html` - akan load soal kategori 'harian'
2. Buka `latihan_mingguan.html` - akan load soal kategori 'mingguan'
3. Buka `latihan_ujikompetensi.html` - akan load soal kategori 'ujian'

## Features

### ✅ Implemented

- Dynamic soal loading dari database
- Support untuk essay dan pilihan ganda
- Arabic text rendering dengan font Amiri
- Error handling dan fallback content
- Responsive design
- Loading indicators

### 🔄 Future Enhancements

- Admin panel untuk manage soal
- User progress tracking
- Score calculation
- Timer untuk ujian
- Export hasil ke PDF

## Troubleshooting

### Common Issues

1. **"loadSoal function not available"**

   - Pastikan `soal-service.js` sudah di-load
   - Check browser console untuk error

2. **"Failed to fetch soal"**

   - Check Supabase connection
   - Verify environment variables
   - Check network connectivity

3. **Arabic text not rendering properly**
   - Pastikan font Amiri sudah di-load
   - Check CSS direction: rtl untuk teks Arab

### Debug Mode

Aktifkan debug mode dengan menambahkan di console:

```javascript
window.ENV.ENABLE_DEBUG = "true";
```

## Sample Data

### Kategori: Harian

- 5 soal dasar tentang ilmu tajwid
- Mix essay dan pilihan ganda
- Fokus pada konsep dasar

### Kategori: Mingguan

- 5 soal intermediate tentang hukum tajwid
- Lebih detail tentang idgham, ikhfa, dll
- Praktik dengan contoh ayat

### Kategori: Ujian

- 5 soal advanced untuk ujian
- Soal kompleks dengan analisis ayat
- Level mahasiswa/advanced

## Security

- Row Level Security (RLS) enabled
- Policies untuk authenticated users
- Environment variables untuk credentials
- No sensitive data exposed in client-side code

## Performance

- Lazy loading untuk soal
- Caching di browser
- Optimized queries dengan indexing
- Minimal network requests

---

**Note**: Sistem ini memerlukan koneksi internet untuk mengakses Supabase database. Untuk offline mode, perlu implementasi caching atau local storage.
