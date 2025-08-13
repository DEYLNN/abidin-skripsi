# Database Structure - Media Pembelajaran Tajwid

## Overview

Dokumentasi struktur database untuk aplikasi Media Pembelajaran Tajwid menggunakan Supabase (PostgreSQL).

## Tabel Utama

### 1. Tabel `materi`

Tabel untuk menyimpan materi pembelajaran tajwid.

```sql
CREATE TABLE materi (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    judul VARCHAR(255) NOT NULL,
    hukum_tajwid VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    materi_inti JSONB,
    latihan_praktis JSONB,
    gambar_url TEXT,
    audio_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Field Descriptions:**

- `id`: Primary key dengan UUID
- `judul`: Judul materi (contoh: "Hukum Nun Mati")
- `hukum_tajwid`: Nama hukum tajwid (contoh: "Idgham")
- `deskripsi`: Deskripsi singkat materi
- `materi_inti`: JSON array berisi konten materi inti
- `latihan_praktis`: JSON array berisi latihan praktis
- `gambar_url`: URL gambar materi (disimpan di Supabase Storage)
- `audio_url`: URL audio materi (disimpan di Supabase Storage)
- `created_at`: Timestamp pembuatan record
- `updated_at`: Timestamp update terakhir

### 2. Tabel `soal`

Tabel untuk menyimpan soal-soal latihan dan ujian.

```sql
CREATE TABLE soal (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    kategori VARCHAR(50) NOT NULL CHECK (kategori IN ('harian', 'mingguan', 'ujian')),
    pertanyaan TEXT NOT NULL,
    tipe_soal VARCHAR(20) NOT NULL CHECK (tipe_soal IN ('pilihan_ganda', 'essay')),
    jawaban_benar TEXT NOT NULL,
    pilihan_jawaban JSONB, -- Hanya untuk tipe pilihan_ganda
    penjelasan TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

**Field Descriptions:**

- `id`: Primary key dengan UUID
- `kategori`: Kategori soal ('harian', 'mingguan', 'ujian')
- `pertanyaan`: Teks pertanyaan
- `tipe_soal`: Tipe soal ('pilihan_ganda' atau 'essay')
- `jawaban_benar`: Jawaban yang benar
  - Untuk pilihan ganda: huruf pilihan (A, B, C, D)
  - Untuk essay: teks jawaban lengkap
- `pilihan_jawaban`: JSON object berisi pilihan A, B, C, D (hanya untuk pilihan ganda)
- `penjelasan`: Penjelasan mengapa jawaban tersebut benar
- `created_at`: Timestamp pembuatan record
- `updated_at`: Timestamp update terakhir

### 3. Tabel `users` (Opsional - untuk fitur user management)

Tabel untuk menyimpan data pengguna jika diperlukan.

```sql
CREATE TABLE users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    nama_lengkap VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'student' CHECK (role IN ('admin', 'teacher', 'student')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## Contoh Data

### Contoh Data Tabel `materi`:

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "judul": "Hukum Nun Mati",
  "hukum_tajwid": "Idgham",
  "deskripsi": "Pembelajaran tentang hukum nun mati yang bertemu dengan huruf-huruf tertentu",
  "materi_inti": [
    {
      "sub_judul": "Pengertian Idgham",
      "konten": "Idgham adalah memasukkan huruf nun mati ke dalam huruf yang mengikutinya...",
      "contoh": "مِنْ نُّطْفَةٍ"
    }
  ],
  "latihan_praktis": [
    {
      "jenis": "membaca",
      "teks": "مِنْ نُّطْفَةٍ",
      "instruksi": "Bacalah dengan menerapkan hukum idgham"
    }
  ],
  "gambar_url": "https://supabase.co/storage/v1/object/public/materi-images/idgham.png",
  "audio_url": "https://supabase.co/storage/v1/object/public/materi-audio/idgham.mp3"
}
```

### Contoh Data Tabel `soal`:

**Soal Pilihan Ganda:**

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440001",
  "kategori": "harian",
  "pertanyaan": "Apa yang dimaksud dengan hukum Idgham?",
  "tipe_soal": "pilihan_ganda",
  "jawaban_benar": "A",
  "pilihan_jawaban": {
    "A": "Memasukkan huruf nun mati ke dalam huruf yang mengikutinya",
    "B": "Membaca nun mati dengan jelas",
    "C": "Mengganti nun mati dengan huruf lain",
    "D": "Menghilangkan nun mati"
  },
  "penjelasan": "Idgham adalah memasukkan huruf nun mati ke dalam huruf yang mengikutinya sehingga seolah-olah menjadi satu huruf yang ditasydid."
}
```

**Soal Essay:**

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440002",
  "kategori": "ujian",
  "pertanyaan": "Jelaskan perbedaan antara hukum Idgham dan Ikhfa' dengan memberikan contoh masing-masing!",
  "tipe_soal": "essay",
  "jawaban_benar": "Idgham adalah memasukkan huruf nun mati ke dalam huruf yang mengikutinya, contoh: مِنْ نُّطْفَةٍ. Sedangkan Ikhfa' adalah menyembunyikan nun mati dengan tetap ada bekasnya, contoh: مِنْ فَضْلِهِ",
  "penjelasan": "Kedua hukum ini memiliki cara membaca yang berbeda dan diterapkan pada kondisi yang berbeda pula."
}
```

## Query SQL untuk Implementasi

### 1. Membuat Tabel

```sql
-- Buat tabel materi
CREATE TABLE materi (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    judul VARCHAR(255) NOT NULL,
    hukum_tajwid VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    materi_inti JSONB,
    latihan_praktis JSONB,
    gambar_url TEXT,
    audio_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Buat tabel soal
CREATE TABLE soal (
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

### 2. Query untuk CRUD Operations

**Insert Materi:**

```sql
INSERT INTO materi (judul, hukum_tajwid, deskripsi, materi_inti, latihan_praktis)
VALUES (
    'Hukum Nun Mati',
    'Idgham',
    'Pembelajaran tentang hukum nun mati',
    '[{"sub_judul": "Pengertian", "konten": "Penjelasan..."}]',
    '[{"jenis": "membaca", "teks": "مِنْ نُّطْفَةٍ"}]'
);
```

**Insert Soal Pilihan Ganda:**

```sql
INSERT INTO soal (kategori, pertanyaan, tipe_soal, jawaban_benar, pilihan_jawaban, penjelasan)
VALUES (
    'harian',
    'Apa yang dimaksud dengan hukum Idgham?',
    'pilihan_ganda',
    'A',
    '{"A": "Memasukkan huruf nun mati", "B": "Membaca dengan jelas", "C": "Mengganti huruf", "D": "Menghilangkan huruf"}',
    'Penjelasan hukum Idgham...'
);
```

**Insert Soal Essay:**

```sql
INSERT INTO soal (kategori, pertanyaan, tipe_soal, jawaban_benar, penjelasan)
VALUES (
    'ujian',
    'Jelaskan perbedaan Idgham dan Ikhfa!',
    'essay',
    'Idgham adalah memasukkan huruf nun mati ke dalam huruf yang mengikutinya...',
    'Kedua hukum ini memiliki cara membaca yang berbeda...'
);
```

**Select Soal berdasarkan Kategori:**

```sql
SELECT * FROM soal WHERE kategori = 'harian' ORDER BY created_at DESC;
```

**Select Materi dengan Limit:**

```sql
SELECT * FROM materi ORDER BY created_at DESC LIMIT 10;
```

### 3. Row Level Security (RLS) - Opsional

Jika ingin menambahkan keamanan:

```sql
-- Enable RLS
ALTER TABLE materi ENABLE ROW LEVEL SECURITY;
ALTER TABLE soal ENABLE ROW LEVEL SECURITY;

-- Policy untuk read access
CREATE POLICY "Allow public read access" ON materi FOR SELECT USING (true);
CREATE POLICY "Allow public read access" ON soal FOR SELECT USING (true);

-- Policy untuk admin write access (jika ada auth)
CREATE POLICY "Allow admin write access" ON materi FOR ALL USING (auth.role() = 'admin');
CREATE POLICY "Allow admin write access" ON soal FOR ALL USING (auth.role() = 'admin');
```

## Integrasi dengan JavaScript

### Contoh fungsi untuk menyimpan soal ke Supabase:

```javascript
async function saveSoalToSupabase(soalData) {
  try {
    const { data, error } = await supabase.from("soal").insert([soalData]);

    if (error) throw error;

    return { success: true, data };
  } catch (error) {
    console.error("Error saving soal:", error);
    return { success: false, error };
  }
}

// Penggunaan:
const soalData = {
  kategori: "harian",
  pertanyaan: "Apa yang dimaksud dengan hukum Idgham?",
  tipe_soal: "pilihan_ganda",
  jawaban_benar: "A",
  pilihan_jawaban: {
    A: "Memasukkan huruf nun mati",
    B: "Membaca dengan jelas",
    C: "Mengganti huruf",
    D: "Menghilangkan huruf",
  },
  penjelasan: "Penjelasan hukum Idgham...",
};

const result = await saveSoalToSupabase(soalData);
```

### Contoh fungsi untuk mengambil soal berdasarkan kategori:

```javascript
async function getSoalByKategori(kategori) {
  try {
    const { data, error } = await supabase
      .from("soal")
      .select("*")
      .eq("kategori", kategori)
      .order("created_at", { ascending: false });

    if (error) throw error;

    return { success: true, data };
  } catch (error) {
    console.error("Error fetching soal:", error);
    return { success: false, error };
  }
}
```

## Catatan Penting

1. **Storage**: File gambar dan audio disimpan di Supabase Storage dengan bucket terpisah
2. **JSONB**: Field `materi_inti`, `latihan_praktis`, dan `pilihan_jawaban` menggunakan tipe JSONB untuk fleksibilitas
3. **Validation**: Gunakan CHECK constraints untuk memastikan data valid
4. **Indexing**: Pertimbangkan untuk menambahkan index pada field yang sering digunakan untuk query
5. **Backup**: Pastikan untuk melakukan backup database secara berkala

## Index yang Disarankan

```sql
-- Index untuk performa query
CREATE INDEX idx_soal_kategori ON soal(kategori);
CREATE INDEX idx_soal_tipe ON soal(tipe_soal);
CREATE INDEX idx_materi_hukum ON materi(hukum_tajwid);
CREATE INDEX idx_created_at ON materi(created_at DESC);
CREATE INDEX idx_soal_created_at ON soal(created_at DESC);
```
