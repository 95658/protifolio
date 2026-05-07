import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Simple hand-rolled localization class for EN / AR.
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Delegates required by MaterialApp.localizationsDelegates.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  bool get isArabic => locale.languageCode == 'ar';

  // ─── General ────────────────────────────────────────────────────────────────
  String get appTitle => isArabic ? 'ملفي الشخصي' : 'My Portfolio';
  String get builtWith =>
      isArabic
          ? 'مبني بـ Flutter 💙 • متجاوب للويب'
          : 'Built with Flutter 💙 • Responsive for Web';

  // ─── Header ─────────────────────────────────────────────────────────────────
  String get fullName => 'Ahmed Abd-Elfatah';
  String get jobTitle =>
      isArabic ? 'مطوّر Flutter متوسط المستوى' : 'Mid-Level Flutter Developer';
  String get headerStats =>
      isArabic
          ? 'خبرة +2 سنة • 9 تطبيقات مُطلقة • القاهرة، مصر'
          : '2+ years • 9 apps launched • Cairo, Egypt';
  String get linkedin => 'LinkedIn';
  String get githubLabel => 'GitHub';
  String get resumeLabel => isArabic ? 'السيرة الذاتية' : 'Resume';

  // ─── Toggle ─────────────────────────────────────────────────────────────────
  String get switchToArabic => 'العربية';
  String get switchToEnglish => 'English';

  // ─── Summary ────────────────────────────────────────────────────────────────
  String get profileSection =>
      isArabic ? 'الملف المهني' : 'Professional Profile';
  String get profileBody =>
      isArabic
          ? 'مطوّر Flutter متوسط المستوى بخبرة تزيد عن سنتين في بناء وإطلاق 7 تطبيقات على Google Play و App Store (9 تطبيقات بحلول نهاية العام). أتخصص في إنشاء تطبيقات جوّال عالية الأداء وسهلة الاستخدام باستخدام Flutter و Dart. أمتلك مهارات قوية في حل المشكلات وشغفاً بالتطور المستمر، مع التركيز على تقديم حلول جودتها عالية وتحسين أداء التطبيقات.'
          : 'I\'m a Mid-Level Flutter Developer with 2+ years of experience building and launching 7 apps on Google Play and App Store (9 apps by year-end). I specialize in creating high-performance, user-friendly mobile applications using Flutter and Dart. With strong problem-solving skills and a passion for continuous improvement, I focus on delivering quality solutions and optimizing app performance.';

  // ─── Skills ─────────────────────────────────────────────────────────────────
  String get skillsSection =>
      isArabic ? 'المهارات التقنية' : 'Technical Skills';

  // ─── Experience ─────────────────────────────────────────────────────────────
  String get experienceSection =>
      isArabic ? 'الخبرة العملية' : 'Work Experience';
  String get exp1Title =>
      isArabic
          ? 'مهندس برمجيات موبايل Flutter'
          : 'Flutter Mobile Software Engineer';
  String get exp1Company => 'Dipdux Analytica';
  String get exp1Period =>
      isArabic ? 'نوفمبر 2023 – حتى الآن' : 'November 2023 – Present';
  String get exp1Type => isArabic ? 'دوام كامل' : 'Full-Time';
  String get exp1Desc =>
      isArabic
          ? 'تطوير وصيانة تطبيقات الجوّال • إطلاق التطبيقات على المتجرين'
          : 'Develop and maintain mobile apps • Launch apps on both stores';
  String get exp2Title => isArabic ? 'مدرّس برمجة' : 'Coding Instructor';
  String get exp2Company => 'Coach Academy';
  String get exp2Period =>
      isArabic ? 'يوليو 2022 – حتى الآن' : 'July 2022 – Present';
  String get exp2Type => isArabic ? 'دوام جزئي' : 'Part-Time';
  String get exp2Desc =>
      isArabic
          ? 'تدريس أساسيات البرمجة باستخدام C++ و Python'
          : 'Teaching basic programming and coding structure using C++ and Python';

  // ─── Projects ───────────────────────────────────────────────────────────────
  String get projectsSection => isArabic ? 'المشاريع' : 'Projects';
  String get live => isArabic ? 'مباشر' : 'Live';
  String get inDev => isArabic ? 'قيد التطوير' : 'Dev';
  String get inDevelopmentLabel => isArabic ? 'قيد التطوير' : 'In Development';
  String liveCount(int n) => isArabic ? '$n مباشر' : '$n Live';
  String devCount(int n) => isArabic ? '$n قيد التطوير' : '$n In Development';

  // ─── Education ──────────────────────────────────────────────────────────────
  String get educationSection => isArabic ? 'التعليم' : 'Education';
  String get schoolName => isArabic ? 'أكاديمية طيبة' : 'Thebes Academy';
  String get degree => isArabic ? 'علوم الحاسب (B+)' : 'Computer Science (B+)';
  String get studyPeriod =>
      isArabic ? 'مايو 2019 – مايو 2023' : 'May 2019 – May 2023';
  String get certifications =>
      isArabic ? 'الشهادات والدورات' : 'Certifications & Courses';

  // ─── Contact ────────────────────────────────────────────────────────────────
  String get contactSection => isArabic ? 'التواصل' : 'Contact';
  String get emailLabel => isArabic ? 'البريد الإلكتروني' : 'Email';
  String get phoneLabel => isArabic ? 'الهاتف' : 'Phone';
  String get locationLabel => isArabic ? 'الموقع' : 'Location';
  String get locationValue => isArabic ? 'القاهرة، مصر' : 'Cairo, Egypt';
  String get languagesLabel => isArabic ? 'اللغات: ' : 'Languages: ';
  String get languagesValue =>
      isArabic
          ? 'العربية (اللغة الأم)، الإنجليزية (بطلاقة)'
          : 'Arabic (Native), English (Fluent)';

  // ─── Resume ─────────────────────────────────────────────────────────────────
  String get downloadResume =>
      isArabic ? 'تحميل السيرة الذاتية' : 'Download Resume';
  String get downloadResumeSubtitle =>
      isArabic
          ? 'احصل على سيرتي الذاتية كاملةً بصيغة PDF'
          : 'Get my full CV in PDF format';

  // ─── Dark mode ──────────────────────────────────────────────────────────────
  String get darkMode => isArabic ? 'الوضع الداكن' : 'Dark Mode';
  String get lightMode => isArabic ? 'الوضع الفاتح' : 'Light Mode';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
