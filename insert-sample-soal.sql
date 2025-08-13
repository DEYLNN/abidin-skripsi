-- Insert sample soal (questions) for testing database integration
-- This script inserts sample questions for each category: harian, mingguan, ujian

-- Sample soal for kategori 'harian' (daily practice)
INSERT INTO soal (kategori, pertanyaan, tipe_soal, jawaban_benar, pilihan_jawaban, penjelasan) VALUES
('harian', 'مَا هُوَ عِلْمُ التَّجْوِيْدِ؟', 'essay', 'علم تجويد القرآن الكريم هو علم يبحث في أحكام النطق الصحيح للحروف العربية', NULL, 'Ilmu tajwid adalah ilmu yang mempelajari cara membaca Al-Quran dengan benar sesuai dengan kaidah-kaidah yang telah ditentukan.'),
('harian', 'مَا فَائِدَتُهُ؟', 'essay', 'لحفظ اللسان من الخطأ في لفظ كتاب الله تعالى', NULL, 'Manfaat ilmu tajwid adalah untuk menjaga lidah dari kesalahan dalam melafalkan kitab Allah SWT.'),
('harian', 'مَا حُكْمُ اسْتِعْمَالِهِ؟', 'pilihan_ganda', 'فرض كفاية', '["فرض عين", "فرض كفاية", "سنة مؤكدة", "مباح"]', 'Hukum mempelajari ilmu tajwid adalah fardhu kifayah, artinya wajib dipelajari oleh sebagian umat Islam.'),
('harian', 'كَمْ حُكْمًا لِلنُّوْنِ السَّاكِنَةِ وَالتَّنْوِيْنِ؟', 'pilihan_ganda', '4', '["3", "4", "5", "6"]', 'Hukum nun sukun dan tanwin ada 4: Idzhar, Idgham, Iqlab, dan Ikhfa.'),
('harian', 'اُذْكُرْ لِلنُّوْنِ السَّاكِنَةِ وَالتَّنْوِيْنِ', 'essay', 'الإظهار، الإدغام، الإقلاب، الإخفاء', NULL, 'Empat hukum nun sukun dan tanwin: Idzhar (jelas), Idgham (masuk), Iqlab (membalik), dan Ikhfa (samar).');

-- Sample soal for kategori 'mingguan' (weekly practice)
INSERT INTO soal (kategori, pertanyaan, tipe_soal, jawaban_benar, pilihan_jawaban, penjelasan) VALUES
('mingguan', 'مَا مَعْنَى الْإِدْغَامُ فِي الْقِرَاءَةِ؟', 'essay', 'إدخال حرف ساكن في حرف متحرك بحيث يصيران حرفاً واحداً مشدداً', NULL, 'Idgham adalah memasukkan huruf sukun ke dalam huruf berharakat sehingga menjadi satu huruf yang ditasydid.'),
('mingguan', 'كَمْ نَوْعًا لِلْإِدْغَامِ لِلنُّوْنِ السَّاكِنَةِ؟ اُذْكُرْ', 'pilihan_ganda', '2', '["1", "2", "3", "4"]', 'Idgham untuk nun sukun ada 2 jenis: Idgham Bighunnah dan Idgham Bilaghunnah.'),
('mingguan', 'مَتَى تَقْرَأُ الْإِخْفَاءُ شَفَوِيًّا؟', 'essay', 'عندما يأتي بعد النون الساكنة أو التنوين حرف الباء', NULL, 'Ikhfa syafawi dibaca ketika setelah nun sukun atau tanwin diikuti huruf ba.'),
('mingguan', 'كَمْ حَرْفًالَهُ؟ اُذْكُرْ', 'pilihan_ganda', '1', '["1", "2", "3", "4"]', 'Ikhfa syafawi hanya memiliki 1 huruf yaitu huruf ba.'),
('mingguan', 'كَمْ حُكْمًا لِلْألِفِ وَاللَّامِ التَّعْرِيْفِ؟ اُذْكُرْ', 'pilihan_ganda', '2', '["1", "2", "3", "4"]', 'Alif lam ta'rif memiliki 2 hukum: Idzhar Qamariyah dan Idgham Syamsiyah.');

-- Sample soal for kategori 'ujian' (exam)
INSERT INTO soal (kategori, pertanyaan, tipe_soal, jawaban_benar, pilihan_jawaban, penjelasan) VALUES
('ujian', 'مَا الْفَرْقُ بَيْنَ الْقَلْقَلَةِ الْكُبْرَى وَالْقَلْقَلَةِ الصُّغْرَى؟', 'essay', 'القلقلة الكبرى تكون في آخر الكلمة، والقلقلة الصغرى تكون في أول الكلمة', NULL, 'Qalqalah kubra terjadi di akhir kata, sedangkan qalqalah sughra terjadi di awal kata.'),
('ujian', 'اُذْكُر حُرُوْفُ اْلإِظْهَارِالْحَلْقِيِّ', 'essay', 'ء ه ع ح غ خ', NULL, 'Huruf-huruf idzhar halqi adalah: hamzah, ha, ain, ha, ghain, dan kha.'),
('ujian', 'اُذْكُر حُرُوْفِ الإِخْفَاءِ الْحَقِيْقِيِّ', 'essay', 'ص ذ ث ك ج ش ق س د ط ز ف ت ض ظ', NULL, 'Huruf-huruf ikhfa haqiqi ada 15 huruf: shad, dzal, tsa, kaf, jim, syin, qaf, sin, dal, tha, zay, fa, ta, dhad, dan zha.'),
('ujian', 'اُذْكُرْأَحْكَامَ التَّجْوِيْدِ مِنَ الآيَاتِ الآتِيَةِ "صُمٌّ بُكْمٌ عُمْيٌ فَهُمْ لاَيَرْجِعُوْنَ"', 'essay', 'إدغام بغير غنة في كلمة "لا يرجعون"', NULL, 'Hukum tajwid dalam ayat tersebut adalah idgham bilaghunnah pada kata "لا يرجعون" karena nun sukun bertemu dengan huruf ya.'),
('ujian', 'اُذْكُرْأَحْكَامَ التَّجْوِيْدِ مِنَ الآيَاتِ الآتِيَةِ قَدْأَفْلَحَ مَنْ تَزَكَّىٰ * وَذَكَرَاسْمَ رَبِّهِ فَصَلَّىٰ', 'essay', 'إدغام بغير غنة في "قد أفْلَحَ" و "ذَكَرَاسْمَ"', NULL, 'Hukum tajwid dalam ayat tersebut adalah idgham bilaghunnah pada kata "قد أفْلَحَ" dan "ذَكَرَاسْمَ" karena nun sukun bertemu dengan huruf alif dan sin.');

-- Verify the inserted data
SELECT 
    kategori,
    COUNT(*) as jumlah_soal,
    STRING_AGG(tipe_soal, ', ') as tipe_soal_available
FROM soal 
GROUP BY kategori 
ORDER BY kategori; 