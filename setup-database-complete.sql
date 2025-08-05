-- Database Setup Lengkap untuk Media Pembelajaran Tajwid
-- Jalankan script ini di SQL Editor Supabase

-- Buat tabel materi
CREATE TABLE IF NOT EXISTS materi (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  judul TEXT NOT NULL,
  judul_latin TEXT NOT NULL,
  deskripsi TEXT,
  level TEXT DEFAULT 'Pemula',
  gambar_url TEXT,
  link_url TEXT,
  -- Kolom baru untuk materi detail
  pengertian_awal TEXT,
  materi_inti JSONB,
  latihan_praktis JSONB,
  jumlah_hukum INTEGER DEFAULT 5,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Buat index untuk pencarian
CREATE INDEX IF NOT EXISTS idx_materi_judul_latin ON materi(judul_latin);
CREATE INDEX IF NOT EXISTS idx_materi_judul ON materi USING gin(to_tsvector('indonesian', judul));
CREATE INDEX IF NOT EXISTS idx_materi_deskripsi ON materi USING gin(to_tsvector('indonesian', deskripsi));

-- Insert data awal
INSERT INTO materi (judul, judul_latin, deskripsi, level, gambar_url, link_url) VALUES
(
  'النون الساكنة والتنوين',
  'Nun Sukun & Tanwin',
  'والمقصود بالنون الميتة هي النون الساكنة التي لا تصطف، فهي تستعمل سكون الحركات، فلا يمكن أن تنطق النون إلا إذا سبقها حرف آخر. أما التنوين فهو النون الميتة التي تقع في آخر النون الساكنة التي تظهر عند قراءتها غسلاً (متصلة بكلمة أخرى) وتختفي عند كتابتها (ممثلة).',
  'Pemula',
  'gambar/Belajar-Membaca-Alquran_Fotor.jpg',
  'nun_sukun.html'
),
(
  'الميم الساكنة والتنوين',
  'Mim Sukun & Tanwin',
  'ميم السكون من قوانين التجويد، وهو أحد قوانين التجويد التي توضح أحكام القراءة عند وجود ميم السكون والتنوين مع حروف الهجاء.',
  'Menengah',
  'gambar/quran-removebg-preview.png',
  'mim_sukun.html'
),
(
  'لام التعريف',
  'Lam Ta''rif',
  'لام التعريف أو ال (التعريف) هي الألف واللام التي دخلت على الاسم بحيث لو حذفت ماتغيرت الكلمة عن معناها الأصلى. للام التعريف بمناسبة ما وقع بعدها من الأحرف الهجائية حكمان و هما : إظهار قمريةوإدغام شمسية',
  'Lanjutan',
  'gambar/ilustasi al quran.jpg',
  'lam_tarif.html'
),
(
  'القلقلة',
  'Qolqolah',
  'وتعريف القلقلة في علم التجويد هو إظهار الذبذبات الصوتية عند تلاوة الكلمات الواردة في حرف القلقلة، وهو ما كان لفظه غير منون أوموقوفاً',
  'Lanjutan',
  'gambar/Al Quran tafsir.jpg',
  'qalqalah.html'
);

-- Buat fungsi untuk update timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Buat trigger untuk auto-update timestamp
CREATE TRIGGER update_materi_updated_at 
    BEFORE UPDATE ON materi 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Enable Row Level Security (RLS)
ALTER TABLE materi ENABLE ROW LEVEL SECURITY;

-- Buat policy untuk read access (public)
CREATE POLICY "Allow public read access" ON materi
    FOR SELECT USING (true);

-- Buat policy untuk insert/update/delete (hanya untuk authenticated users)
CREATE POLICY "Allow authenticated users to manage materi" ON materi
    FOR ALL USING (auth.role() = 'authenticated');

-- Update data Nun Sukun & Tanwin dengan konten lengkap
UPDATE materi SET 
  pengertian_awal = 'النون الساكنة والتنوين علامتا ترقيم في القرآن الكريم لهما أحكام تجويدية خاصة. والتنوين هو حرف من حروف النون الساكنة التي ليس لها حرف، بينما التنوين هو علامة ترقيم تشير إلى وجود حرف من حروف النون الساكنة في ظروف معينة.',
  materi_inti = '[
    {
      "id": 1,
      "judul": "الإظهار الحلق",
      "judul_latin": "Idzhar Halqi",
      "deskripsi": "الإظهار معناه: الوضوح وأماالإظهار في القراءة فهو إخراج كل حرف من مخرج من غير غنة",
      "contoh_ayat": "مَنْ آمَنَ",
      "terjemahan": "Dari orang yang beriman (QS. Al-Baqarah: 62)",
      "audio_url": "sound/idzhar halqi.opus",
      "tips": {
        "judul": "حروف الحلق",
        "konten": "أ - ع - غ - ح - خ - ه"
      }
    },
    {
      "id": 2,
      "judul": "الإدغام مع الغنّة",
      "judul_latin": "Idgham Ma''al Ghunnah",
      "deskripsi": "الإدغام معناه: الإدخال واما الإدغام في القراءة فهو: خلط الحرفين وإدخال أحدهماالآخرفتدغم النون الساكنة أو التنوين بغنة عندما إتصل بأحدهمااحدأحرف",
      "contoh_ayat": "مِنْ وَرَائِهِمْ",
      "terjemahan": "Dari belakang mereka (QS. Yasin: 9)",
      "audio_url": "sound/idham bigu.mp3",
      "tips": {
        "judul": "حروف الإدغام مع الغنّة",
        "konten": "ي - ن - م - و"
      }
    },
    {
      "id": 3,
      "judul": "الإدغام بغيرالغنّة",
      "judul_latin": "Idgham Bila Ghunnah",
      "deskripsi": "وتدغم النون الساكنة أو التنوين بغير غنة عندما إتصلت باحدهما الإدغام معناه: الإدخال",
      "contoh_ayat": "هُدًى لِّلْمُتَّقِيْنَ",
      "terjemahan": "petunjuk bagi orang-orang yang bertakwa (QS. Al-Baqarah: 2)",
      "audio_url": "sound/contoh01.opus",
      "tips": {
        "judul": "حروف الإدغام بغيرالغنّة",
        "konten": "ل - ر"
      }
    },
    {
      "id": 4,
      "judul": "الإقلاب",
      "judul_latin": "Iqlab",
      "deskripsi": "الإقلاب معناه تحويل شيءٍ عن وجهه وأما الإقلاب في القراءة فهو جعل صوتٍ النون الساكنة أو التنوين ميماً وحروْف الإقلاب واحدٌهو ب",
      "contoh_ayat": "لَنَسْفَعًاۢ بِٱلنَّاصِيَةِ",
      "terjemahan": "Sungguh Kami akan menarik ubun-ubun (QS. Al-Alaq: 15)",
      "audio_url": "sound/iqlab.opus",
      "tips": {
        "judul": "حروف الإقلاب",
        "konten": "ب"
      }
    },
    {
      "id": 5,
      "judul": "الإخفاء حقيقي",
      "judul_latin": "Ikhfa Haqiqi",
      "deskripsi": "الإخفاء معناه الإخباء وأما الإخفاء في القراءه فهو عبارة عن النطق بحرف ساكن خال عن التشديد على صفة بين الإظهار والإدغام مع ثبوت الغنة في الحرف الأول والإخفاء هنا الإخفاء حقيقي",
      "contoh_ayat": "أَنْصَارُ ٱللَّهِ",
      "terjemahan": "Penolong-penolong Allah (QS. As-Saff: 14)",
      "audio_url": "sound/ikhfa haqiqi.opus",
      "tips": {
        "judul": "حروف الإخفاءحقيقي",
        "konten": "ت ث ج د ذ ز س ش ص ض ط ظ ف ق ك"
      }
    }
  ]',
  latihan_praktis = '[
    {
      "id": 1,
      "judul": "Latihan Praktis",
      "deskripsi": "Praktikkan bacaan berikut dengan memperhatikan hukum nun mati dan tanwin:",
      "contoh": "إِنَّ ٱلْإِنْسَٰنَ لَفِى خُسْرٍ إِلَّا ٱلَّذِينَ ءَامَنُوا۟",
      "terjemahan": "Sesungguhnya manusia berada dalam kerugian, kecuali orang-orang yang beriman (QS. Al-Asr: 2-3)",
      "audio_url": "sound/contoh nun sukun.opus",
      "jawaban": "Latihan praktis membaca ayat dengan hukum nun sukun dan tanwin",
      "penjelasan": "Perhatikan hukum nun sukun dan tanwin pada setiap kata dalam ayat tersebut"
    }
  ]',
  jumlah_hukum = 5
WHERE judul_latin = 'Nun Sukun & Tanwin';

-- Update untuk Mim Sukun
UPDATE materi SET 
  pengertian_awal = 'ميم السكون من قوانين التجويد، وهو أحد قوانين التجويد التي توضح أحكام القراءة عند وجود ميم السكون والتنوين مع حروف الهجاء.',
  materi_inti = '[
    {
      "id": 1,
      "judul": "إخفاء شفوي",
      "judul_latin": "Ikhfa Syafawi",
      "deskripsi": "إخفاء الميم الساكنة عند الباء مع الغنة",
      "contoh_ayat": "هُمْ بِهِ",
      "terjemahan": "Mereka dengannya (QS. Al-Baqarah: 2)",
      "audio_url": "sound/ikhfa syafawi.opus",
      "tips": {
        "judul": "حرف الإخفاء الشفوي",
        "konten": "ب"
      }
    },
    {
      "id": 2,
      "judul": "إدغام متماثلين",
      "judul_latin": "Idgham Mutsamatsilain",
      "deskripsi": "إدغام الميم الساكنة في الميم المتحركة",
      "contoh_ayat": "لَهُمْ مَثَلٌ",
      "terjemahan": "Bagi mereka ada perumpamaan (QS. Al-Baqarah: 2)",
      "audio_url": "sound/idhgham mimi.opus",
      "tips": {
        "judul": "حرف الإدغام المتماثلين",
        "konten": "م"
      }
    },
    {
      "id": 3,
      "judul": "إظهار شفوي",
      "judul_latin": "Idzhar Syafawi",
      "deskripsi": "إظهار الميم الساكنة عند جميع الحروف ما عدا الباء والميم",
      "contoh_ayat": "عَلَيْهِمْ أَلْقَى",
      "terjemahan": "Kepada mereka dilemparkan (QS. Al-Baqarah: 2)",
      "audio_url": "sound/idzhar syafawi.opus",
      "tips": {
        "judul": "حروف الإظهار الشفوي",
        "konten": "جميع الحروف ما عدا الباء والميم"
      }
    }
  ]',
  latihan_praktis = '[
    {
      "id": 1,
      "judul": "Latihan 1: Pengenalan Hukum Mim",
      "deskripsi": "Latihan untuk mengenali hukum mim sukun",
      "contoh": "هُمْ بِهِ",
      "terjemahan": "Mereka dengannya (QS. Al-Baqarah: 2)",
      "audio_url": "sound/ikhfa syafawi.opus",
      "jawaban": "Ikhfa Syafawi",
      "penjelasan": "Karena mim sukun bertemu dengan huruf ba (ب)"
    }
  ]',
  jumlah_hukum = 3
WHERE judul_latin = 'Mim Sukun & Tanwin';

-- Update untuk Lam Ta'rif
UPDATE materi SET 
  pengertian_awal = 'لام التعريف أو ال (التعريف) هي الألف واللام التي دخلت على الاسم بحيث لو حذفت ماتغيرت الكلمة عن معناها الأصلى. للام التعريف بمناسبة ما وقع بعدها من الأحرف الهجائية حكمان و هما : إظهار قمريةوإدغام شمسية',
  materi_inti = '[
    {
      "id": 1,
      "judul": "الإظهار القمري",
      "judul_latin": "Idzhar Qamari",
      "deskripsi": "إظهار اللام التعريف عند الحروف القمرية",
      "contoh_ayat": "الْقَمَر",
      "terjemahan": "Bulan (QS. Al-Baqarah: 2)",
      "audio_url": "sound/idzhar qamari.opus",
      "tips": {
        "judul": "الحروف القمرية",
        "konten": "أ ب ج ح خ ع غ ف ق ك م ه و ي"
      }
    },
    {
      "id": 2,
      "judul": "الإدغام الشمسي",
      "judul_latin": "Idgham Syamsi",
      "deskripsi": "إدغام اللام التعريف عند الحروف الشمسية",
      "contoh_ayat": "الشَّمْس",
      "terjemahan": "Matahari (QS. Al-Baqarah: 2)",
      "audio_url": "sound/idgham syamsi.opus",
      "tips": {
        "judul": "الحروف الشمسية",
        "konten": "ت ث د ذ ر ز س ش ص ض ط ظ ل ن"
      }
    }
  ]',
  latihan_praktis = '[
    {
      "id": 1,
      "judul": "Latihan 1: Pengenalan Lam Ta''rif",
      "deskripsi": "Latihan untuk mengenali hukum lam ta''rif",
      "contoh": "الْقَمَر",
      "terjemahan": "Bulan (QS. Al-Baqarah: 2)",
      "audio_url": "sound/idzhar qamari.opus",
      "jawaban": "Idzhar Qamari",
      "penjelasan": "Karena lam ta''rif bertemu dengan huruf qaf (ق) yang termasuk huruf qamari"
    }
  ]',
  jumlah_hukum = 2
WHERE judul_latin = 'Lam Ta''rif';

-- Update untuk Qalqalah
UPDATE materi SET 
  pengertian_awal = 'وتعريف القلقلة في علم التجويد هو إظهار الذبذبات الصوتية عند تلاوة الكلمات الواردة في حرف القلقلة، وهو ما كان لفظه غير منون أوموقوفاً',
  materi_inti = '[
    {
      "id": 1,
      "judul": "قلقلة كبرى",
      "judul_latin": "Qalqalah Kubra",
      "deskripsi": "القلقلة الكبرى هي القلقلة التي تكون في آخر الكلمة",
      "contoh_ayat": "أَحَد",
      "terjemahan": "Satu (QS. Al-Ikhlas: 1)",
      "audio_url": "sound/qalqalah kubra.opus",
      "tips": {
        "judul": "حروف القلقلة",
        "konten": "ق ط ب ج د"
      }
    },
    {
      "id": 2,
      "judul": "قلقلة وسطى",
      "judul_latin": "Qalqalah Wustha",
      "deskripsi": "القلقلة الوسطى هي القلقلة التي تكون في وسط الكلمة",
      "contoh_ayat": "قُلْ",
      "terjemahan": "Katakanlah (QS. Al-Ikhlas: 1)",
      "audio_url": "sound/qalqalah wustha.opus",
      "tips": {
        "judul": "حروف القلقلة",
        "konten": "ق ط ب ج د"
      }
    },
    {
      "id": 3,
      "judul": "قلقلة صغرى",
      "judul_latin": "Qalqalah Sughra",
      "deskripsi": "القلقلة الصغرى هي القلقلة التي تكون في أول الكلمة",
      "contoh_ayat": "قَدْ",
      "terjemahan": "Sesungguhnya (QS. Al-Baqarah: 2)",
      "audio_url": "sound/qalqalah sughra.opus",
      "tips": {
        "judul": "حروف القلقلة",
        "konten": "ق ط ب ج د"
      }
    }
  ]',
  latihan_praktis = '[
    {
      "id": 1,
      "judul": "Latihan 1: Pengenalan Qalqalah",
      "deskripsi": "Latihan untuk mengenali hukum qalqalah",
      "contoh": "أَحَد",
      "terjemahan": "Satu (QS. Al-Ikhlas: 1)",
      "audio_url": "sound/qalqalah kubra.opus",
      "jawaban": "Qalqalah Kubra",
      "penjelasan": "Karena huruf dal (د) berada di akhir kata dan termasuk huruf qalqalah"
    }
  ]',
  jumlah_hukum = 3
WHERE judul_latin = 'Qolqolah';

-- Verifikasi update
SELECT id, judul_latin, jumlah_hukum, 
       CASE WHEN materi_inti IS NOT NULL THEN 'Ada' ELSE 'Tidak ada' END as materi_inti,
       CASE WHEN latihan_praktis IS NOT NULL THEN 'Ada' ELSE 'Tidak ada' END as latihan_praktis
FROM materi 
ORDER BY created_at; 