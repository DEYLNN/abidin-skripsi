// Soal Service - Handle questions from Supabase database
class SoalService {
  constructor() {
    // Initialize Supabase client
    this.supabase = window.supabase.createClient(
      window.ENV.SUPABASE_URL,
      window.ENV.SUPABASE_ANON_KEY
    );
  }

  // Fetch questions by category (harian, mingguan, ujian)
  async getSoalByKategori(kategori) {
    try {
      const { data, error } = await this.supabase
        .from("soal")
        .select("*")
        .eq("kategori", kategori)
        .order("created_at", { ascending: true })
        .execute();

      if (error) {
        console.error("Error fetching soal:", error);
        return [];
      }

      return data || [];
    } catch (error) {
      console.error("Error in getSoalByKategori:", error);
      return [];
    }
  }

  // Render questions to HTML
  renderSoal(soalList, containerId) {
    const container = document.getElementById(containerId);
    if (!container) {
      console.error(`Container with id '${containerId}' not found`);
      return;
    }

    // Clear existing content
    container.innerHTML = "";

    if (!soalList || soalList.length === 0) {
      container.innerHTML = `
        <div style="text-align: center; padding: 2rem; color: #666;">
          <p>Belum ada soal tersedia untuk kategori ini.</p>
        </div>
      `;
      return;
    }

    // Create question cards
    soalList.forEach((soal, index) => {
      const card = this.createSoalCard(soal, index + 1);
      container.appendChild(card);
    });
  }

  // Create individual question card
  createSoalCard(soal, number) {
    const card = document.createElement("div");
    card.className = "latihan-card";

    let cardContent = `
      <div class="card-num">${number}</div>
      <div style="text-align: right" class="question-title">
        ${soal.pertanyaan}
      </div>
    `;

    // Add verse if exists in pertanyaan (for Arabic text)
    if (soal.pertanyaan.includes('"') || soal.pertanyaan.includes('"')) {
      // Extract verse from pertanyaan if it contains quotes
      const verseMatch = soal.pertanyaan.match(/"([^"]+)"/);
      if (verseMatch) {
        cardContent += `
          <div style="
            text-align: right;
            font-family: 'Traditional Arabic', Arial, sans-serif;
            font-size: 24px;
            margin: 10px 0;
          " class="question-title">
            "${verseMatch[1]}"
          </div>
        `;
      }
    }

    // Add answer space based on question type
    if (soal.tipe_soal === "pilihan_ganda") {
      cardContent += this.createMultipleChoiceOptions(soal);
    } else {
      cardContent += `<span class="verse arabic-text"> ............. </span>`;
    }

    card.innerHTML = cardContent;
    return card;
  }

  // Create multiple choice options
  createMultipleChoiceOptions(soal) {
    if (!soal.pilihan_jawaban || !Array.isArray(soal.pilihan_jawaban)) {
      return `<span class="verse arabic-text"> ............. </span>`;
    }

    let optionsHtml =
      '<div class="options-container" style="margin-top: 15px;">';
    soal.pilihan_jawaban.forEach((option, index) => {
      const optionLetter = String.fromCharCode(65 + index); // A, B, C, D, etc.
      optionsHtml += `
        <div class="option-item" style="
          margin: 8px 0;
          padding: 8px 12px;
          background: #f8f9fa;
          border-radius: 6px;
          border: 1px solid #e9ecef;
        ">
          <span style="font-weight: bold; margin-right: 8px;">${optionLetter}.</span>
          <span>${option}</span>
        </div>
      `;
    });
    optionsHtml += "</div>";

    return optionsHtml;
  }

  // Load and display questions for a specific page
  async loadSoalForPage(kategori, containerId) {
    try {
      console.log(`Loading soal for kategori: ${kategori}`);
      const soalList = await this.getSoalByKategori(kategori);
      console.log(`Found ${soalList.length} soal for ${kategori}:`, soalList);
      this.renderSoal(soalList, containerId);
    } catch (error) {
      console.error(`Error loading soal for ${kategori}:`, error);
      // Show fallback content
      const container = document.getElementById(containerId);
      if (container) {
        container.innerHTML = `
          <div style="text-align: center; padding: 2rem; color: #666;">
            <p>Gagal memuat soal. Silakan coba lagi nanti.</p>
            <button onclick="location.reload()" style="
              background: #2e7d32;
              color: white;
              border: none;
              padding: 10px 20px;
              border-radius: 5px;
              cursor: pointer;
              margin-top: 10px;
            ">Muat Ulang</button>
          </div>
        `;
      }
    }
  }
}

// Initialize global soal service
window.soalService = new SoalService();

// Helper function to load soal when page loads
window.loadSoal = function (kategori, containerId) {
  if (window.soalService) {
    window.soalService.loadSoalForPage(kategori, containerId);
  } else {
    console.error("SoalService not initialized");
  }
};

console.log("SoalService loaded successfully");
