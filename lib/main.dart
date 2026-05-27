// ========================================================================== //
// MARK: - SYSTEM IMPORTS
// ========================================================================== //

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ========================================================================== //
// MARK: - ENTRY POINT
// ========================================================================== //

void main() {
  runApp(const MyApp());
}

// ========================================================================== //
// MARK: - MAIN APP ROOT
// ========================================================================== //

/// The entry point configuration widget for the H.I.D.U.P S.E.H.A.T application.
///
/// Sets up global Material 3 configurations with a curated Teal seed color
/// and standardizes margins and layouts across all platform environments.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'H.I.D.U.P S.E.H.A.T',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// ========================================================================== //
// MARK: - DATA DOMAIN MODELS
// ========================================================================== //

/// Represents a single lifestyle evaluation question.
///
/// Identifies the question position and contains the localized text content
/// detailing the healthy habit being evaluated.
class Question {
  final int id;
  final String text;

  const Question({
    required this.id,
    required this.text,
  });
}

/// Represents one of the 10 lifestyle categories under the H.I.D.U.P S.E.H.A.T acronym.
///
/// Each category contains an acronym letter, a verbose name, and its corresponding questions.
class QuestionCategory {
  final String letter;
  final String name;
  final List<Question> questions;

  const QuestionCategory({
    required this.letter,
    required this.name,
    required this.questions,
  });
}

/// Visual design token mappings for categories.
///
/// Defines custom brand colors, backgrounds, and specific icons associated with
/// each lifestyle category to enhance user navigation and engagement.
class CategoryMetadata {
  final IconData icon;
  final Color primaryColor;
  final Color accentColor;

  const CategoryMetadata({
    required this.icon,
    required this.primaryColor,
    required this.accentColor,
  });
}

// ========================================================================== //
// MARK: - METADATA CONFIGURATION
// ========================================================================== //

/// A visual catalog linking each H.I.D.U.P S.E.H.A.T category to a unique
/// icon and color coding to minimize user cognitive load during assessment.
final List<CategoryMetadata> categoryMetaList = [
  const CategoryMetadata(
    icon: Icons.favorite,
    primaryColor: Colors.pink,
    accentColor: Color(0xFFFCE4EC),
  ), // H - Hati yang Gembira
  const CategoryMetadata(
    icon: Icons.nights_stay,
    primaryColor: Colors.indigo,
    accentColor: Color(0xFFE8EAF6),
  ), // I - Istirahat yang Cukup
  const CategoryMetadata(
    icon: Icons.restaurant,
    primaryColor: Colors.green,
    accentColor: Color(0xFFE8F5E9),
  ), // D - Diet yang Seimbang
  const CategoryMetadata(
    icon: Icons.air,
    primaryColor: Colors.teal,
    accentColor: Color(0xFFE0F2F1),
  ), // U - Udara yang Bersih
  const CategoryMetadata(
    icon: Icons.self_improvement,
    primaryColor: Colors.orange,
    accentColor: Color(0xFFFFF3E0),
  ), // P - Pengendalian Diri
  const CategoryMetadata(
    icon: Icons.wb_sunny,
    primaryColor: Colors.amber,
    accentColor: Color(0xFFFFFDE7),
  ), // S - Sinar Matahari yang Cukup
  const CategoryMetadata(
    icon: Icons.directions_run,
    primaryColor: Colors.deepOrange,
    accentColor: Color(0xFFFBE9E7),
  ), // E - Enerjik Berolahraga
  const CategoryMetadata(
    icon: Icons.people,
    primaryColor: Colors.purple,
    accentColor: Color(0xFFF3E5F5),
  ), // H - Hubungan Sosial yang Baik
  const CategoryMetadata(
    icon: Icons.water_drop,
    primaryColor: Colors.blue,
    accentColor: Color(0xFFE3F2FD),
  ), // A - Air Jernih yang Cukup
  const CategoryMetadata(
    icon: Icons.auto_awesome,
    primaryColor: Colors.deepPurple,
    accentColor: Color(0xFFEDE7F6),
  ), // T - Tuhan yang Terutama
];

// ========================================================================== //
// MARK: - STATIC DATABASE
// ========================================================================== //

/// Static source of truth database holding the complete set of 50 health assessment questions,
/// grouped logically into their 10 distinct categories.
const List<QuestionCategory> staticCategories = [
  QuestionCategory(
    letter: 'H',
    name: 'HATI YANG GEMBIRA',
    questions: [
      Question(id: 1, text: 'Memikirkan hal-hal yang positif'),
      Question(id: 2, text: 'Mengucapkan hal-hal yang positif'),
      Question(id: 3, text: 'Melakukan hal-hal yang positif untuk kebaikan orang lain'),
      Question(id: 4, text: 'Memiliki minat & senang dalam melakukan kegiatan yang positif'),
      Question(id: 5, text: 'Mengampuni orang yang bersalah kepada saya'),
      Question(id: 6, text: 'Tertawa gembira pada situasi yang tepat'),
      Question(id: 7, text: 'Tersenyum pada orang-orang di sekitar saya'),
    ],
  ),
  QuestionCategory(
    letter: 'I',
    name: 'ISTIRAHAT YANG CUKUP',
    questions: [
      Question(id: 8, text: 'Tidur nyenyak 7-8 jam setiap malam'),
      Question(id: 9, text: 'Tidur dalam ruangan yang gelap tanpa terpapar dengan gelombang elektromagnetik (TV, HP, Laptop, dll)'),
      Question(id: 10, text: 'Tidur tanpa beban pikiran/kemarahan/kebencian/dendam/sakit hati/kekuatiran & tanpa minum obat tidur'),
      Question(id: 11, text: 'Tidak mengantuk & merasa lelah saat melakukan tugas di siang hari'),
      Question(id: 12, text: 'Beristirahat dari pekerjaan rutin 1 hari/minggu'),
    ],
  ),
  QuestionCategory(
    letter: 'D',
    name: 'DIET YANG SEIMBANG',
    questions: [
      Question(id: 13, text: 'Memakan makanan dengan gizi seimbang (karbohidrat 45-65% total kalori, protein 10-35% total kalori, lemak 20-35% total kalori)'),
      Question(id: 14, text: 'Memakan makanan yang berbasis tumbuh-tumbuhan termasuk 5 porsi sayuran & buah-buahan serta polong-polongan setiap hari'),
      Question(id: 15, text: 'Memakan makanan dalam jumlah secukupnya'),
      Question(id: 16, text: 'Makan secara teratur 2 atau 3 kali sehari'),
      Question(id: 17, text: 'Tidak ngemil atau makan di antara jam makan'),
      Question(id: 18, text: 'Menghindari kebiasaan makan di luar rumah/restoran/kedai cepat saji'),
      Question(id: 19, text: 'Menghindari makanan ultra proses yaitu makanan yang telah melalui proses pengolahan yang lama/rumit & mengandung bahan tambahan/pengawet (misalnya makanan kaleng, mie instan, dll)'),
    ],
  ),
  QuestionCategory(
    letter: 'U',
    name: 'UDARA YANG BERSIH',
    questions: [
      Question(id: 20, text: 'Menghirup udara bersih dengan membuka jendela rumah/ruangan kerja setiap hari'),
      Question(id: 21, text: 'Melakukan latihan pernapasan yang dalam setiap pagi di udara terbuka & di bawah pepohonan'),
      Question(id: 22, text: 'Menjaga lingkungan rapih, bersih, & bebas polusi setiap hari serta AC di ruangan dibersihkan secara rutin'),
    ],
  ),
  QuestionCategory(
    letter: 'P',
    name: 'PENGENDALIAN DIRI',
    questions: [
      Question(id: 23, text: 'Mampu mengatasi ketegangan pikiran & kemarahan/emosi yg meluap-luap'),
      Question(id: 24, text: 'Mampu mengendalikan diri terhadap aktivitas dan nafsu yang merugikan (nonton, sex/pornografi, judi, games, olahraga & bekerja berlebihan)'),
      Question(id: 25, text: 'Tidak merokok'),
      Question(id: 26, text: 'Tidak minum alkohol, kafein (kopi/teh) atau obat-obatan terlarang'),
      Question(id: 27, text: 'Patuh mengikuti aturan yang berlaku & disiplin melaksanakan tugas yang dipercayakan'),
    ],
  ),
  QuestionCategory(
    letter: 'S',
    name: 'SINAR MATAHARI YANG CUKUP',
    questions: [
      Question(id: 28, text: 'Kulit terpapar langsung sinar matahari pagi atau sore sekitar 30-60 menit setiap hari'),
      Question(id: 29, text: 'Kulit terpapar langsung sinar matahari pada siang hari selama 5-10 menit setiap hari'),
      Question(id: 30, text: 'Membuka pintu atau jendela sehingga cahaya matahari masuk ke dalam ruangan setiap hari'),
    ],
  ),
  QuestionCategory(
    letter: 'E',
    name: 'ENERJIK BEROLAH RAGA',
    questions: [
      Question(id: 31, text: 'Berolah raga secara teratur minimal 5 kali per-minggu'),
      Question(id: 32, text: 'Berolah raga selama 30-60 menit per-sesi olah raga'),
      Question(id: 33, text: 'Melakukan olah raga peregangan, penguatan, aerobik & ketahanan 2-3x seminggu'),
      Question(id: 34, text: 'Berolah raga hingga nafas terengah-engah'),
      Question(id: 35, text: 'Berjalan 10 menit setelah makan'),
    ],
  ),
  QuestionCategory(
    letter: 'H',
    name: 'HUBUNGAN SOSIAL YANG BAIK',
    questions: [
      Question(id: 36, text: 'Memiliki waktu setiap hari berkomunikasi dengan keluarga (suami, isteri, anak, orang tua)'),
      Question(id: 37, text: 'Mempertimbangkan dahulu kata-kata yang akan disampaikan apakah benar, baik & bermanfaat sebelum diucapkan'),
      Question(id: 38, text: 'Mampu mengutarakan isi pikiran & perasaan dengan nada suara dan bahasa tubuh yang baik'),
      Question(id: 39, text: 'Mampu berinteraksi dengan orang lain dalam situasi & kondisi apapun'),
      Question(id: 40, text: 'Merasa nyaman bila berada bersama orang lain'),
    ],
  ),
  QuestionCategory(
    letter: 'A',
    name: 'AIR JERNIH YANG CUKUP',
    questions: [
      Question(id: 41, text: 'Minum air jernih (tidak berwarna, tidak berasa, tidak berbau) rata-rata 2 (dua) liter per-hari'),
      Question(id: 42, text: 'Minum air jernih tidak saat makan'),
      Question(id: 43, text: 'Mandi secara teratur minimal 1 kali per-hari'),
    ],
  ),
  QuestionCategory(
    letter: 'T',
    name: 'TUHAN YANG TERUTAMA',
    questions: [
      Question(id: 44, text: 'Berdoa secara pribadi dengan Tuhan setiap hari'),
      Question(id: 45, text: 'Belajar Firman Tuhan (Kitab Suci) secara pribadi setiap hari'),
      Question(id: 46, text: 'Beribadah menyembah Tuhan setiap hari'),
      Question(id: 47, text: 'Bersaksi tentang kebaikan Tuhan setiap hari'),
      Question(id: 48, text: 'Melakukan perbuatan baik ke sesama oleh karena mengasihi Tuhan'),
      Question(id: 49, text: 'Bersyukur, memuji & memuliakan nama Tuhan atas berkat & kebaikan Tuhan setiap hari'),
      Question(id: 50, text: 'Percaya & berharap kepada Tuhan dalam segala situasi'),
    ],
  ),
];

// ==========================================
// MARK: - PERSISTENCE SERVICES
// ==========================================

/// Represents a completed assessment record stored in history.
class AssessmentRecord {
  final int totalScore;
  final double percentage;
  final String date;

  const AssessmentRecord({
    required this.totalScore,
    required this.percentage,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'totalScore': totalScore,
        'percentage': percentage,
        'date': date,
      };

  factory AssessmentRecord.fromJson(Map<String, dynamic> json) => AssessmentRecord(
        totalScore: json['totalScore'] as int? ?? 0,
        percentage: (json['percentage'] as num? ?? 0.0).toDouble(),
        date: json['date'] as String? ?? '',
      );
}

/// Local storage service coordinating state persistence using [SharedPreferences].
///
/// Implements client-side history storage to satisfy the Zero-Cost Infrastructure
/// requirements, ensuring user data is entirely kept offline on the client device.
class PreferencesService {
  static const String _keyHistory = 'assessment_history';

  /// Saves the results of the completed questionnaire locally.
  static Future<void> saveAssessment({
    required int totalScore,
    required double percentage,
    required String date,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getAssessmentHistory();
    
    final newRecord = AssessmentRecord(
      totalScore: totalScore,
      percentage: percentage,
      date: date,
    );
    
    history.add(newRecord);
    
    final stringList = history.map((record) => jsonEncode(record.toJson())).toList();
    await prefs.setStringList(_keyHistory, stringList);
  }

  /// Retrieves all recorded assessment scores, with backwards compatibility
  /// migration for previous single-record formats.
  static Future<List<AssessmentRecord>> getAssessmentHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_keyHistory);
    if (list != null) {
      try {
        return list.map((item) {
          final decoded = jsonDecode(item) as Map<String, dynamic>;
          return AssessmentRecord.fromJson(decoded);
        }).toList();
      } catch (_) {
        // ignore error decoding
      }
    }
    
    // Check if old format exists, migrate it
    const String oldKeyScore = 'last_total_score';
    if (prefs.containsKey(oldKeyScore)) {
      final oldScore = prefs.getInt(oldKeyScore) ?? 0;
      final oldPct = prefs.getDouble('last_percentage') ?? 0.0;
      final oldDate = prefs.getString('last_date') ?? '';
      
      final migratedRecord = AssessmentRecord(
        totalScore: oldScore,
        percentage: oldPct,
        date: oldDate,
      );
      
      // Clean up old keys
      await prefs.remove(oldKeyScore);
      await prefs.remove('last_percentage');
      await prefs.remove('last_date');
      
      // Save in new format
      final stringList = [jsonEncode(migratedRecord.toJson())];
      await prefs.setStringList(_keyHistory, stringList);
      
      return [migratedRecord];
    }
    
    return [];
  }

  /// Wipes all cached assessment history from the local storage cache.
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyHistory);
  }
}

// ==========================================
// MARK: - PRESENTATION LAYER (HOME SPA SCREEN)
// ==========================================

/// The screen enum representing each main view state of the Single Page Application (SPA).
enum AppScreen {
  /// The introductory dashboard showing history and the welcome message.
  welcome,

  /// The active 10-category multi-step evaluation questionnaire view.
  questionnaire,

  /// The final summary dashboard reflecting score breakdown and analytics.
  result,
}

/// Main screen of the Single Page Application (SPA).
///
/// Handles structural layout constraints, screen transitions, and orchestrates the
/// lifecycle of the lifestyle assessment questionnaire.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// ==========================================
// MARK: - SCREEN STATE MANAGEMENT
// ==========================================

class _HomeScreenState extends State<HomeScreen> {
  AppScreen _currentScreen = AppScreen.welcome;
  int _currentCategoryIndex = 0;
  final PageController _pageController = PageController();
  final Map<int, int> _selectedAnswers = {}; // questionId -> score (0-3)
  List<AssessmentRecord> _assessmentHistory = [];
  bool _isLoadingHistory = true;

  @override
  void initState() {
    super.initState();
    _loadAssessmentHistory();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Fetches history data from local shared preferences.
  Future<void> _loadAssessmentHistory() async {
    setState(() {
      _isLoadingHistory = true;
    });
    final history = await PreferencesService.getAssessmentHistory();
    setState(() {
      _assessmentHistory = history;
      _isLoadingHistory = false;
    });
  }

  /// Displays the formal book attribution reference details in a custom dialog.
  void _showReferencesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.menu_book_rounded, color: Colors.teal.shade700),
            const SizedBox(width: 10),
            const Text(
              'Referensi Instrumen',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Asesmen ini diadaptasi dari buku referensi resmi:',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROGRAM H.I.D.U.P S.E.H.A.T',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.teal.shade900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Persembahan Rumah Sakit Advent Bandung bagi Indonesia Tercinta',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.teal.shade800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Semua hak cipta instrumen penilaian dan materi kuesioner dimiliki oleh penulis buku dan Rumah Sakit Advent Bandung.',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  /// Builds a formatted string representing the current system date in Indonesian.
  String _formatCurrentDate() {
    final now = DateTime.now();
    final months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  /// Registers user choice score for a specific question.
  void _handleAnswerSelection(int questionId, int score) {
    setState(() {
      _selectedAnswers[questionId] = score;
    });
  }

  /// Checks if all questions inside a specific category have been completed.
  bool _isCategoryFullyAnswered(int categoryIndex) {
    final category = staticCategories[categoryIndex];
    for (final question in category.questions) {
      if (!_selectedAnswers.containsKey(question.id)) {
        return false;
      }
    }
    return true;
  }

  // ==========================================
  // MARK: - NAVIGATION LOGIC
  // ==========================================

  /// Moves the PageView display backward to the previous question category.
  void _navigateToPreviousCategory() {
    if (_currentCategoryIndex > 0) {
      setState(() {
        _currentCategoryIndex--;
      });
      _pageController.animateToPage(
        _currentCategoryIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Moves the PageView display forward to the next question category.
  ///
  /// Automatically triggers completion logic when ending the final category step.
  void _navigateToNextCategory() {
    if (_isCategoryFullyAnswered(_currentCategoryIndex)) {
      if (_currentCategoryIndex < 9) {
        setState(() {
          _currentCategoryIndex++;
        });
        _pageController.animateToPage(
          _currentCategoryIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _completeAndSaveAssessment();
      }
    }
  }

  /// Aggregates points, saves data, and advances to the results screen.
  Future<void> _completeAndSaveAssessment() async {
    final int totalScore = _calculateTotalScore();
    final double percentage = (totalScore / 150.0) * 100.0;
    final String dateStr = _formatCurrentDate();

    await PreferencesService.saveAssessment(
      totalScore: totalScore,
      percentage: percentage,
      date: dateStr,
    );

    await _loadAssessmentHistory();

    setState(() {
      _currentScreen = AppScreen.result;
    });
  }

  /// Resets questionnaire answers and jumps back to the initial step.
  void _resetAndRestartAssessment() {
    setState(() {
      _selectedAnswers.clear();
      _currentCategoryIndex = 0;
      _currentScreen = AppScreen.questionnaire;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
    });
  }

  /// Prompts a dialog to wipe saved assessment records.
  Future<void> _deleteAssessmentHistory() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Riwayat'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus seluruh riwayat asesmen Anda?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await PreferencesService.clearHistory();
      await _loadAssessmentHistory();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Seluruh riwayat berhasil dihapus.')),
        );
      }
    }
  }

  /// Prompt confirmation when user tries to abandon active survey process.
  Future<void> _confirmAndExitAssessment() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar dari Asesmen'),
        content: const Text(
          'Jawaban Anda saat ini tidak akan disimpan. Apakah Anda yakin ingin keluar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Lanjutkan Asesmen'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Keluar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _currentScreen = AppScreen.welcome;
        _selectedAnswers.clear();
        _currentCategoryIndex = 0;
      });
    }
  }

  // ==========================================
  // MARK: - CALCULATION UTILITIES
  // ==========================================

  /// Sums scores of all answered questions.
  int _calculateTotalScore() {
    int total = 0;
    for (final score in _selectedAnswers.values) {
      total += score;
    }
    return total;
  }

  /// Computes cumulative score for a single category dimension.
  int _calculateCategorySubtotal(QuestionCategory category) {
    int subtotal = 0;
    for (final q in category.questions) {
      subtotal += _selectedAnswers[q.id] ?? 0;
    }
    return subtotal;
  }

  /// Determines color theme tokens representing the habit score quality percentage.
  Color _getColorForScorePercentage(double percentage) {
    if (percentage <= 25.0) return Colors.red.shade600;
    if (percentage <= 50.0) return Colors.orange.shade700;
    if (percentage <= 75.0) return Colors.blue.shade700;
    return Colors.green.shade700;
  }

  /// Returns the category label matching the score range.
  String _getInterpretationLabel(double percentage) {
    if (percentage <= 25.0) return 'Buruk';
    if (percentage <= 50.0) return 'Kurang';
    if (percentage <= 75.0) return 'Cukup';
    return 'Baik';
  }

  /// Returns a descriptive feedback text matched to the assessment results.
  String _getInterpretationDescription(double percentage) {
    if (percentage <= 25.0) {
      return 'Pola hidup Anda membutuhkan perbaikan segera. Mari mulailah membangun kebiasaan sehat dari langkah-langkah kecil.';
    }
    if (percentage <= 50.0) {
      return 'Pola hidup Anda masih kurang optimal. Berusahalah lebih konsisten berolahraga, beristirahat, dan menjaga asupan nutrisi.';
    }
    if (percentage <= 75.0) {
      return 'Pola hidup Anda cukup baik. Tingkatkan beberapa aspek yang masih kurang agar tubuh terasa lebih prima dan bertenaga.';
    }
    return 'Luar biasa! Pola hidup Anda sangat baik. Pertahankan kebiasaan sehat ini untuk investasi kesehatan jangka panjang Anda!';
  }

  // ==========================================
  // MARK: - MAIN BUILD METHOD
  // ==========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 600;
          final content = _buildCurrentScreenContent();

          if (isDesktop) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.teal.shade50,
                    Colors.blue.shade50,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Container(
                  width: 500,
                  height: 850,
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: content,
                ),
              ),
            );
          } else {
            return SafeArea(child: content);
          }
        },
      ),
    );
  }

  /// Dispatches the active display widget representing the current workflow state.
  Widget _buildCurrentScreenContent() {
    switch (_currentScreen) {
      case AppScreen.welcome:
        return _buildWelcomeScreen();
      case AppScreen.questionnaire:
        return _buildQuestionnaireScreen();
      case AppScreen.result:
        return _buildResultScreen();
    }
  }

  // ==========================================
  // MARK: - SUB-VIEWS: WELCOME SCREEN
  // ==========================================

  /// Builds the greeting screen view, showing instructions and score history.
  Widget _buildWelcomeScreen() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline_rounded, color: Colors.teal.shade700),
            tooltip: 'Referensi Buku',
            onPressed: _showReferencesDialog,
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildWelcomeHeader(),
                  const SizedBox(height: 24),
                  const _LetterAcronymWidget(),
                  const SizedBox(height: 32),
                  _isLoadingHistory
                      ? const Center(child: CircularProgressIndicator())
                      : _buildHistoryCard(),
                  const SizedBox(height: 24),
                  _buildGuideCard(),
                  const SizedBox(height: 24),
                  _buildFootnote(),
                ],
              ),
            ),
          ),
          _buildStartButton(),
        ],
      ),
    );
  }

  /// Renders application logo and title text.
  Widget _buildWelcomeHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.health_and_safety,
            size: 64,
            color: Colors.teal.shade700,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'H.I.D.U.P S.E.H.A.T',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
            letterSpacing: 2.0,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Asesmen Pola Hidup Sehat\n(Evaluasi 2 Minggu Terakhir)',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Builds the assessment history summary container.
  Widget _buildHistoryCard() {
    if (_assessmentHistory.isEmpty) {
      return Card(
        color: Colors.teal.shade50.withValues(alpha: 0.5),
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(Icons.history_rounded, color: Colors.teal.shade300, size: 40),
              const SizedBox(height: 12),
              Text(
                'Belum Ada Riwayat Asesmen',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.teal.shade900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Data asesmen Anda akan tersimpan secara lokal setelah selesai mengisi seluruh kuesioner.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.teal.shade700.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      shadowColor: Colors.teal.withValues(alpha: 0.15),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.history_rounded,
                      color: Colors.teal.shade700,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Riwayat & Perkembangan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.teal.shade900,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: _deleteAssessmentHistory,
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    size: 16,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Hapus Semua',
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                  ),
                ),
              ],
            ),
            const Divider(height: 16),
            Column(
              children: List.generate(_assessmentHistory.length, (idx) {
                final record = _assessmentHistory[_assessmentHistory.length - 1 - idx];
                final double pct = record.percentage;
                final int score = record.totalScore;
                final String date = record.date;
                final color = _getColorForScorePercentage(pct);
                final interp = _getInterpretationLabel(pct);
                
                Widget? trendWidget;
                if (idx < _assessmentHistory.length - 1) {
                  final prevRecord = _assessmentHistory[_assessmentHistory.length - 2 - idx];
                  final diff = record.totalScore - prevRecord.totalScore;
                  if (diff > 0) {
                    trendWidget = Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.trending_up_rounded, color: Colors.green, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          '+$diff',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    );
                  } else if (diff < 0) {
                    trendWidget = Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.trending_down_rounded, color: Colors.red, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          '$diff',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    );
                  } else {
                    trendWidget = Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.trending_flat_rounded, color: Colors.grey, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          '0',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    );
                  }
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: idx == 0 ? Colors.teal.shade200 : Colors.grey.shade200,
                        width: idx == 0 ? 1.5 : 1.0,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: idx == 0 ? Colors.teal.shade700 : Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${_assessmentHistory.length - idx}',
                            style: TextStyle(
                              color: idx == 0 ? Colors.white : Colors.grey.shade700,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    date,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: idx == 0 ? FontWeight.bold : FontWeight.normal,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  if (idx == 0) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: Colors.teal.shade700,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'Terbaru',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    'Skor: $score/150 (${pct.toStringAsFixed(1)}%)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  if (trendWidget != null) ...[
                                    const SizedBox(width: 8),
                                    trendWidget,
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            interp,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a subtle footnote referencing the source book.
  Widget _buildFootnote() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Column(
        children: [
          Text(
            'Berdasarkan instrumen "PROGRAM H.I.D.U.P S.E.H.A.T"',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Rumah Sakit Advent Bandung',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }

  /// Renders application assessment guidelines details.
  Widget _buildGuideCard() {
    return Card(
      color: Colors.grey.shade50,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Panduan Pengisian:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.teal.shade900,
              ),
            ),
            const SizedBox(height: 12),
            _buildGuideItem(
              Icons.playlist_add_check_rounded,
              '50 Pertanyaan dalam 10 kategori utama pola hidup sehat.',
            ),
            _buildGuideItem(
              Icons.query_stats_rounded,
              'Skala penilaian dari Jarang Sekali (0) sampai Sering Sekali (3).',
            ),
            _buildGuideItem(
              Icons.timer_rounded,
              'Hanya memerlukan waktu 5-10 menit untuk menyelesaikan.',
            ),
            _buildGuideItem(
              Icons.history_edu_rounded,
              'Hasil subtotal skor per kategori akan dianalisis untuk melihat area yang perlu ditingkatkan.',
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a single bullet item for the welcome page guide card.
  Widget _buildGuideItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.teal.shade600),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade800,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the start action button docked at the bottom of welcome panel.
  Widget _buildStartButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _selectedAnswers.clear();
              _currentCategoryIndex = 0;
              _currentScreen = AppScreen.questionnaire;
            });
          },
          icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
          label: const Text(
            'Mulai Asesmen Baru',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal.shade700,
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 2,
          ),
        ),
      ),
    );
  }

  // ==========================================
  // MARK: - SUB-VIEWS: QUESTIONNAIRE
  // ==========================================

  /// Builds the active questionnaire evaluation screen.
  Widget _buildQuestionnaireScreen() {
    final meta = categoryMetaList[_currentCategoryIndex];
    final category = staticCategories[_currentCategoryIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Asesmen H.I.D.U.P',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: _confirmAndExitAssessment,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${_selectedAnswers.length} / 50 Terjawab',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          _buildProgressBar(meta, category),
          _buildCategoryHeaderCard(meta, category),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nilailah kebiasaan Anda dalam 2 minggu terakhir:',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          _buildQuestionPageView(meta),
          _buildBottomNavigation(meta),
        ],
      ),
    );
  }

  /// Builds the survey overall process progress bar.
  Widget _buildProgressBar(CategoryMetadata meta, QuestionCategory category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: (_currentCategoryIndex + 1) / 10.0,
            color: meta.primaryColor,
            backgroundColor: meta.primaryColor.withValues(alpha: 0.12),
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kategori ${_currentCategoryIndex + 1} dari 10',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                ),
              ),
              Text(
                'Huruf: ${category.letter}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: meta.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Renders category details summary banner box.
  Widget _buildCategoryHeaderCard(
    CategoryMetadata meta,
    QuestionCategory category,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: meta.accentColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: meta.primaryColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: meta.primaryColor,
            radius: 22,
            child: Icon(meta.icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ELEMEN POLA HIDUP',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: meta.primaryColor.withValues(alpha: 0.85),
                  ),
                ),
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Renders PageView holding active questions lists scroll view frame.
  Widget _buildQuestionPageView(CategoryMetadata meta) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: staticCategories.length,
        itemBuilder: (context, index) {
          final cat = staticCategories[index];
          final catMeta = categoryMetaList[index];
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 24, top: 4),
            itemCount: cat.questions.length,
            itemBuilder: (ctx, qIdx) {
              final q = cat.questions[qIdx];
              return _buildQuestionCard(q, catMeta);
            },
          );
        },
      ),
    );
  }

  /// Builds a single question card containing layout questions details.
  Widget _buildQuestionCard(Question question, CategoryMetadata catMeta) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: catMeta.primaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${question.id}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: catMeta.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    question.text,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildOptionSelector(question.id, catMeta.primaryColor),
          ],
        ),
      ),
    );
  }

  /// Generates the custom 2x2 grid selector for answering a question.
  ///
  /// Replaces small native radio buttons with large, touch-friendly, color-coded cards.
  Widget _buildOptionSelector(int questionId, Color categoryColor) {
    final currentScore = _selectedAnswers[questionId];

    Widget buildOptionButton(int scoreValue, String label, Color scoreColor) {
      final isSelected = currentScore == scoreValue;
      return Expanded(
        child: InkWell(
          onTap: () => _handleAnswerSelection(questionId, scoreValue),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? scoreColor.withValues(alpha: 0.12)
                  : Colors.transparent,
              border: Border.all(
                color: isSelected ? scoreColor : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: isSelected ? scoreColor : Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$scoreValue',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? scoreColor : Colors.grey.shade700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final colors = [
      Colors.red.shade600,
      Colors.orange.shade700,
      Colors.blue.shade700,
      Colors.green.shade700,
    ];

    return Column(
      children: [
        Row(
          children: [
            buildOptionButton(0, "Jarang Sekali", colors[0]),
            const SizedBox(width: 8),
            buildOptionButton(1, "Jarang", colors[1]),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            buildOptionButton(2, "Sering", colors[2]),
            const SizedBox(width: 8),
            buildOptionButton(3, "Sering Sekali", colors[3]),
          ],
        ),
      ],
    );
  }

  /// Builds sticky navigation bar for controlling categories steps.
  Widget _buildBottomNavigation(CategoryMetadata meta) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentCategoryIndex > 0
              ? OutlinedButton.icon(
                  onPressed: _navigateToPreviousCategory,
                  icon:
                      Icon(Icons.arrow_back_rounded, color: meta.primaryColor),
                  label: Text(
                    'Kembali',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: meta.primaryColor,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: meta.primaryColor, width: 1.5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          ElevatedButton.icon(
            onPressed: _isCategoryFullyAnswered(_currentCategoryIndex)
                ? _navigateToNextCategory
                : null,
            icon: Icon(
              _currentCategoryIndex == 9
                  ? Icons.check_circle_rounded
                  : Icons.arrow_forward_rounded,
              color: Colors.white,
            ),
            label: Text(
              _currentCategoryIndex == 9 ? 'Lihat Hasil' : 'Lanjut',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: meta.primaryColor,
              disabledBackgroundColor: Colors.grey.shade300,
              disabledForegroundColor: Colors.grey.shade500,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: _isCategoryFullyAnswered(_currentCategoryIndex) ? 2 : 0,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // MARK: - SUB-VIEWS: RESULTS SCREEN
  // ==========================================

  /// Builds the results view showcasing score gauge and category summaries.
  Widget _buildResultScreen() {
    final int totalScore = _calculateTotalScore();
    final double percentage = (totalScore / 150.0) * 100.0;
    final color = _getColorForScorePercentage(percentage);
    final interp = _getInterpretationLabel(percentage);
    final message = _getInterpretationDescription(percentage);

    return Column(
      children: [
        AppBar(
          title: const Text(
            'Hasil Asesmen Anda',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildScoreGaugeCard(
                  totalScore,
                  percentage,
                  color,
                  interp,
                  message,
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      'Rekapitulasi Kategori (H.I.D.U.P S.E.H.A.T)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildCategoryBreakdownsList(),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        _buildResultActions(),
      ],
    );
  }

  /// Renders circular dial gauge representing the overall percentage score.
  Widget _buildScoreGaugeCard(
    int totalScore,
    double percentage,
    Color color,
    String interp,
    String message,
  ) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: percentage / 100.0,
                    strokeWidth: 12,
                    color: color,
                    backgroundColor: color.withValues(alpha: 0.12),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${percentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      '$totalScore / 150 Skor',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                interp.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Lists subtotal progress bars representing category-specific details.
  Widget _buildCategoryBreakdownsList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: staticCategories.length,
      itemBuilder: (context, index) {
        final cat = staticCategories[index];
        final meta = categoryMetaList[index];
        final int subtotal = _calculateCategorySubtotal(cat);
        final int maxSubtotal = cat.questions.length * 3;
        final double catPct = (subtotal / maxSubtotal) * 100;
        final catColor = _getColorForScorePercentage(catPct);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          elevation: 0.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: meta.primaryColor,
                  radius: 18,
                  child: Text(
                    cat.letter,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              cat.name,
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$subtotal / $maxSubtotal (${catPct.toStringAsFixed(0)}%)',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: catColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: subtotal / maxSubtotal,
                          color: catColor,
                          backgroundColor: catColor.withValues(alpha: 0.1),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Renders execution triggers docked at the bottom of results panel.
  Widget _buildResultActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _resetAndRestartAssessment,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.teal, width: 1.5),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Ulangi Asesmen',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentScreen = AppScreen.welcome;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Selesai',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ========================================================================== //
// MARK: - DECORATIVE CUSTOM WIDGETS
// ========================================================================== //

/// Generates letter acronym circles banner decoration on the welcome screen.
class _LetterAcronymWidget extends StatelessWidget {
  const _LetterAcronymWidget();

  @override
  Widget build(BuildContext context) {
    final letters = ['H', 'I', 'D', 'U', 'P', 'S', 'E', 'H', 'A', 'T'];
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      alignment: WrapAlignment.center,
      children: List.generate(letters.length, (index) {
        final meta = categoryMetaList[index];
        return Tooltip(
          message: staticCategories[index].name,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: meta.primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: meta.primaryColor.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              letters[index],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        );
      }),
    );
  }
}
