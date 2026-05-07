// ignore: unused_import
import 'dart:math' as math;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protifolio/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  Locale _locale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleLocale() {
    setState(() {
      _locale =
          _locale.languageCode == 'en'
              ? const Locale('ar')
              : const Locale('en');
    });
  }

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = _locale.languageCode == 'ar';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ahmed Abdelfatah Portifolio',
      themeMode: _themeMode,
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      builder:
          (context, child) => Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: child!,
          ),
      home: PortfolioHome(
        onToggleLocale: _toggleLocale,
        onToggleTheme: _toggleTheme,
        themeMode: _themeMode,
        locale: _locale,
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    const seed = Color(0xFFB38A57);
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: brightness,
      ),
      textTheme: GoogleFonts.manropeTextTheme(
        ThemeData(brightness: brightness).textTheme,
      ),
      cardColor: isDark ? const Color(0xFF1F1A15) : const Color(0xFFFFFCF7),
      scaffoldBackgroundColor:
          isDark ? const Color(0xFF14110E) : const Color(0xFFF6F1E9),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  final VoidCallback onToggleLocale;
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;
  final Locale locale;

  const PortfolioHome({
    super.key,
    required this.onToggleLocale,
    required this.onToggleTheme,
    required this.themeMode,
    required this.locale,
  });

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with TickerProviderStateMixin {
  late final AnimationController _pageController;
  late final Animation<double> _pageFade;
  late final Animation<Offset> _pageSlide;
  final ScrollController _scrollController = ScrollController();
  final _heroKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _contactKey = GlobalKey();
  _SectionId _activeSection = _SectionId.home;

  final String email = 'aabdelfatah732@gmail.com';
  final String phone = '+20 1005074635';
  final String linkedIn =
      'https://www.linkedin.com/in/ahmed-abdelfatah-897553243/';
  final String github = 'https://github.com/95658';
  final String resumeUrl =
      'https://drive.google.com/file/d/1OsXrd1IyTk7ix7Y1EaJWwBmZlZZRo2ig/view?usp=sharing';

  final List<Project> _projects = const [
    Project(
      titleEn: 'Bashair',
      titleAr: 'بشاير',
      subtitleEn:
          'Agriculture marketplace – Buy crops, sell products, and manage farms',
      subtitleAr: 'سوق زراعي – اشترِ المحاصيل وبيع المنتجات وأدّر المزارع',
      playStore:
          'https://play.google.com/store/apps/details?id=com.sort6.bashayer&hl=en',
      appStore:
          'https://apps.apple.com/eg/app/%D8%A8%D8%B4%D8%A7%D9%8A%D8%B1/id1171446105',
      status: ProjectStatus.live,
    ),
    Project(
      titleEn: 'Stayro',
      titleAr: 'ستايرو',
      subtitleEn:
          'Travel booking for apartments, chalets and hotels with direct contact',
      subtitleAr: 'حجز السفر للشقق والشاليهات والفنادق مع تواصل مباشر',
      playStore: 'https://play.google.com/store/apps/details?id=com.stayro',
      appStore: 'https://apps.apple.com/app/stayro/id123456789',
      status: ProjectStatus.live,
    ),
    Project(
      titleEn: 'China Parts',
      titleAr: 'قطع الصين',
      subtitleEn:
          'Import auto parts directly from China – Advanced platform for car enthusiasts',
      subtitleAr: 'استيراد قطع غيار السيارات مباشرةً من الصين',
      appStore: 'https://apps.apple.com/app/china-parts/id123456789',
      status: ProjectStatus.live,
    ),
    Project(
      titleEn: 'Key Car',
      titleAr: 'كي كار',
      subtitleEn:
          'Hassle-free car rentals and additional services for all your travel needs',
      subtitleAr: 'تأجير السيارات وخدمات إضافية لجميع احتياجات سفرك',
      playStore: 'https://play.google.com/store/apps/details?id=com.keycar',
      appStore:
          'https://apps.apple.com/eg/app/key-car-%D9%83%D9%8A-%D9%83%D8%A7%D8%B1/id6575369494',
      status: ProjectStatus.live,
    ),
    Project(
      titleEn: 'Check In',
      titleAr: 'تشيك إن',
      subtitleEn:
          'Travel booking platform – Add places and contact place holders for trips',
      subtitleAr: 'منصة حجز السفر – أضف الأماكن وتواصل مع أصحابها',
      playStore: 'https://play.google.com/store/apps/details?id=com.checkin',
      status: ProjectStatus.live,
    ),
    Project(
      titleEn: 'AKHI-Go',
      titleAr: 'أخي-جو',
      subtitleEn: 'Delivery service application',
      subtitleAr: 'تطبيق خدمة التوصيل',
      status: ProjectStatus.development,
    ),
  ];

  final List<String> _skills = const [
    'Flutter',
    'Dart',
    'C++',
    'Problem Solving',
    'Firebase',
    'Git & GitHub',
    'RESTful APIs',
  ];

  final List<Certification> _certifications = const [
    Certification(
      name: 'Basic Programming STLs',
      org: 'Club Of Technology',
      date: 'Nov 2020',
    ),
    Certification(
      name: 'Basic Data Structure and Algorithms',
      org: 'Club Of Technology',
      date: 'Feb 2021',
    ),
    Certification(
      name: 'Advanced Data Structure and Algorithms',
      org: 'Club Of Technology',
      date: 'Aug 2021',
    ),
    Certification(
      name: 'Object Oriented Programming (OOP)',
      org: 'Club Of Technology',
      date: 'Aug 2021',
    ),
    Certification(
      name: 'Intro to Python and AI with Android',
      org: 'TSA',
      date: 'Nov 2020',
    ),
    Certification(
      name: 'Intro to Flutter Development',
      org: 'Instant Software',
      date: 'May 2022',
    ),
    Certification(
      name: 'Advanced Flutter Development',
      org: 'MASA',
      date: 'May 2022',
    ),
  ];

  bool get _isArabic => widget.locale.languageCode == 'ar';

  String _tr(String en, String ar) => _isArabic ? ar : en;

  @override
  void initState() {
    super.initState();
    _pageController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _pageFade = CurvedAnimation(parent: _pageController, curve: Curves.easeIn);
    _pageSlide = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _pageController, curve: Curves.easeOutCubic),
    );
    _scrollController.addListener(_updateActiveSection);
    _pageController.forward();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveSection);
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isArabic = widget.locale.languageCode == 'ar';
    final topInset = MediaQuery.paddingOf(context).top;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:
                    isDark
                        ? [const Color(0xFF14110E), const Color(0xFF251D17)]
                        : [const Color(0xFFF6F1E9), const Color(0xFFEEE2D0)],
              ),
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(top: topInset + 92, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hero Section
                  FadeTransition(
                    opacity: _pageFade,
                    child: SlideTransition(
                      position: _pageSlide,
                      child: KeyedSubtree(
                        key: _heroKey,
                        child: _buildHeroSection(context, loc),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Projects Carousel Section
                  KeyedSubtree(
                    key: _projectsKey,
                    child: _buildProjectsCarousel(context, loc, isArabic),
                  ),
                  const SizedBox(height: 60),

                  // About Section
                  KeyedSubtree(
                    key: _aboutKey,
                    child: _buildAboutSection(context, loc),
                  ),
                  const SizedBox(height: 60),

                  // Skills Section
                  _buildSkillsSection(context, loc),
                  const SizedBox(height: 60),

                  // Stats Section
                  _buildStatsSection(context, loc),
                  const SizedBox(height: 60),

                  // Experience Section
                  _buildExperienceSection(context, loc),
                  const SizedBox(height: 60),

                  // Education Section
                  _buildEducationSection(context, loc),
                  const SizedBox(height: 60),

                  // Contact CTA Section
                  KeyedSubtree(
                    key: _contactKey,
                    child: _buildContactCTASection(context, loc),
                  ),
                  const SizedBox(height: 40),

                  // Footer
                  Center(
                    child: Text(
                      loc.builtWith,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, topInset + 8, 24, 0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withValues(alpha: 0.93),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: _buildTopBar(context, loc, isArabic),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(
    BuildContext context,
    AppLocalizations loc,
    bool isArabic,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 920;
        final navGroup = Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _NavPill(
              label: isArabic ? 'الرئيسية' : 'Home',
              isActive: _activeSection == _SectionId.home,
              onTap: () => _scrollToSection(_heroKey),
            ),
            _NavPill(
              label: isArabic ? 'المشاريع' : 'Projects',
              isActive: _activeSection == _SectionId.projects,
              onTap: () => _scrollToSection(_projectsKey),
            ),
            _NavPill(
              label: isArabic ? 'نبذة' : 'About',
              isActive: _activeSection == _SectionId.about,
              onTap: () => _scrollToSection(_aboutKey),
            ),
            _NavPill(
              label: isArabic ? 'تواصل' : 'Contact',
              isActive: _activeSection == _SectionId.contact,
              onTap: () => _scrollToSection(_contactKey),
            ),
          ],
        );

        final actionGroup = Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            _PillButton(
              label: isArabic ? loc.switchToEnglish : loc.switchToArabic,
              icon: Icons.translate,
              onTap: widget.onToggleLocale,
            ),
            _PillButton(
              label: isDark ? loc.lightMode : loc.darkMode,
              icon: isDark ? Icons.light_mode : Icons.dark_mode,
              onTap: widget.onToggleTheme,
            ),
          ],
        );

        if (compact) {
          return Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 10,
            children: [navGroup, actionGroup],
          );
        }

        return Row(
          children: [
            Expanded(child: navGroup),
            const SizedBox(width: 14),
            actionGroup,
          ],
        );
      },
    );
  }

  Future<void> _scrollToSection(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
      alignment: 0.06,
    );
  }

  void _updateActiveSection() {
    final sections = <_SectionId, GlobalKey>{
      _SectionId.home: _heroKey,
      _SectionId.projects: _projectsKey,
      _SectionId.about: _aboutKey,
      _SectionId.contact: _contactKey,
    };

    const targetY = 140.0;
    _SectionId? nearest;
    double nearestDelta = double.infinity;

    for (final entry in sections.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject();
      if (box is! RenderBox) continue;
      final dy = box.localToGlobal(Offset.zero).dy;
      final delta = (dy - targetY).abs();
      if (delta < nearestDelta) {
        nearestDelta = delta;
        nearest = entry.key;
      }
    }

    if (nearest != null && nearest != _activeSection && mounted) {
      setState(() => _activeSection = nearest!);
    }
  }

  Widget _buildHeroSection(BuildContext context, AppLocalizations loc) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              _PulsingAvatar(),
              const SizedBox(height: 32),
              Text(
                loc.fullName,
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 52,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              DefaultTextStyle(
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      loc.jobTitle,
                      speed: const Duration(milliseconds: 60),
                      cursor: '|',
                    ),
                  ],
                  totalRepeatCount: 1,
                  displayFullTextOnTap: true,
                ),
              ),
              // const SizedBox(height: 16),
              // Text(
              //   loc.profileBody,
              //   textAlign: TextAlign.center,
              //   style: GoogleFonts.poppins(
              //     fontSize: 15,
              //     height: 1.6,
              //     color: Theme.of(
              //       context,
              //     ).colorScheme.onSurface.withValues(alpha: 0.7),
              //   ),
              // ),
              const SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  _GlassChip(
                    label: loc.linkedin,
                    icon: Icons.work_outline,
                    url: linkedIn,
                  ),
                  _GlassChip(
                    label: loc.githubLabel,
                    icon: Icons.code,
                    url: github,
                  ),
                  _GlassChip(
                    label: loc.emailLabel,
                    icon: Icons.email_outlined,
                    url: 'mailto:$email',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsCarousel(
    BuildContext context,
    AppLocalizations loc,
    bool isArabic,
  ) {
    final live =
        _projects.where((p) => p.status == ProjectStatus.live).toList();
    final dev =
        _projects.where((p) => p.status == ProjectStatus.development).toList();

    return Column(
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    _tr('Featured Projects', 'المشاريع المميزة'),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _tr(
                      'A showcase of my latest work and accomplishments',
                      'عرض لأحدث أعمالي وإنجازاتي',
                    ),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int columns = 1;
                  if (constraints.maxWidth > 980) {
                    columns = 3;
                  } else if (constraints.maxWidth > 640) {
                    columns = 2;
                  }

                  final double cardWidth =
                      (constraints.maxWidth - ((columns - 1) * 16)) / columns;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.live,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          for (final project in live)
                            SizedBox(
                              width: cardWidth,
                              child: _ProjectShowcaseCard(
                                project: project,
                                isArabic: isArabic,
                                liveLbl: loc.live,
                                devLbl: loc.inDev,
                              ),
                            ),
                        ],
                      ),
                      if (dev.isNotEmpty) ...[
                        const SizedBox(height: 30),
                        Text(
                          loc.inDevelopmentLabel,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            for (final project in dev)
                              SizedBox(
                                width: cardWidth,
                                child: _ProjectShowcaseCard(
                                  project: project,
                                  isArabic: isArabic,
                                  liveLbl: loc.live,
                                  devLbl: loc.inDev,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context, AppLocalizations loc) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _tr('ABOUT ME', 'نبذة عني'),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _tr('Who I Am', 'من أنا'),
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Text(
                  loc.profileBody,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    height: 1.7,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context, AppLocalizations loc) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _tr('EXPERTISE', 'المهارات'),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _tr('My Skills', 'مهاراتي'),
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children:
                    _skills.asMap().entries.map((e) {
                      return _BounceChip(
                        label: e.value,
                        delay: 300 + (e.key * 60),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, AppLocalizations loc) {
    final live = _projects.where((p) => p.status == ProjectStatus.live).length;
    final stats = [
      MapEntry(_tr('Apps', 'تطبيقات'), '${_projects.length}+'),
      MapEntry(_tr('Live', 'منشور'), '$live'),
      MapEntry(_tr('Users', 'مستخدمون'), '1M+'),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children:
                stats.map((stat) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          stat.value,
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          stat.key,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context, AppLocalizations loc) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _tr('EXPERIENCE', 'الخبرات'),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _tr('My Journey', 'رحلتي'),
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _ExpTile(
                      title: loc.exp1Title,
                      company: loc.exp1Company,
                      period: loc.exp1Period,
                      type: loc.exp1Type,
                      description: loc.exp1Desc,
                    ),
                    const _TimelineDivider(),
                    _ExpTile(
                      title: loc.exp2Title,
                      company: loc.exp2Company,
                      period: loc.exp2Period,
                      type: loc.exp2Type,
                      description: loc.exp2Desc,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationSection(BuildContext context, AppLocalizations loc) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _tr('EDUCATION', 'التعليم'),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _tr('Learning & Growth', 'التعلم والتطور'),
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_balance_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 32,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loc.schoolName,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  loc.degree,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  loc.studyPeriod,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _SectionLabel(label: loc.certifications),
                    const SizedBox(height: 12),
                    ..._certifications.map(
                      (cert) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.verified_outlined,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${cert.name} • ${cert.org}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            Text(
                              cert.date,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCTASection(BuildContext context, AppLocalizations loc) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.tertiary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.35),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  _tr('Let\'s Work Together', 'لنعمل معاً'),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _tr(
                    'I\'m always interested in hearing about new projects and opportunities.',
                    'يسعدني دائماً التعرف على المشاريع الجديدة والفرص المتاحة.',
                  ),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _HoverScale(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final uri = Uri.parse('mailto:$email');
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        icon: const Icon(Icons.email_outlined),
                        label: Text(_tr('Send Email', 'إرسال بريد')),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          backgroundColor: Colors.white,
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    _HoverScale(
                      child: OutlinedButton.icon(
                        onPressed: () => _launchUrl(linkedIn),
                        icon: const Icon(Icons.work_outline),
                        label: const Text('LinkedIn'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          side: const BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }
}

// Components

class _ProjectShowcaseCard extends StatelessWidget {
  final Project project;
  final bool isArabic;
  final String liveLbl;
  final String devLbl;

  const _ProjectShowcaseCard({
    required this.project,
    required this.isArabic,
    required this.liveLbl,
    required this.devLbl,
  });

  @override
  Widget build(BuildContext context) {
    final title = isArabic ? project.titleAr : project.titleEn;
    final subtitle = isArabic ? project.subtitleAr : project.subtitleEn;
    final isLive = project.status == ProjectStatus.live;
    final noLinksLabel =
        isArabic ? 'لا توجد روابط عامة بعد' : 'No public links yet';

    return _HoverScale(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isLive
                            ? Colors.green.withValues(alpha: 0.15)
                            : Colors.orange.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    isLive ? liveLbl : devLbl,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isLive ? Colors.green[700] : Colors.orange[800],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.68),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (project.playStore != null)
                  _StoreBtn(
                    url: project.playStore!,
                    icon: Icons.android,
                    color: Colors.green,
                  ),
                if (project.appStore != null)
                  _StoreBtn(
                    url: project.appStore!,
                    icon: Icons.apple,
                    color: Colors.blue,
                  ),
                if (project.playStore == null && project.appStore == null)
                  Text(
                    isLive ? '' : noLinksLabel,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.55),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BounceChip extends StatefulWidget {
  final String label;
  final int delay;
  const _BounceChip({required this.label, this.delay = 0});
  @override
  State<_BounceChip> createState() => _BounceChipState();
}

class _BounceChipState extends State<_BounceChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: _HoverScale(
        child: Chip(
          label: Text(widget.label),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
          elevation: 2,
          side: BorderSide.none,
        ),
      ),
    );
  }
}

class _HoverScale extends StatefulWidget {
  final Widget child;
  const _HoverScale({required this.child});
  @override
  State<_HoverScale> createState() => _HoverScaleState();
}

class _HoverScaleState extends State<_HoverScale> {
  bool _h = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _h = true),
    onExit: (_) => setState(() => _h = false),
    child: AnimatedScale(
      scale: _h ? 1.06 : 1.0,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
      child: widget.child,
    ),
  );
}

class _GlassChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;
  const _GlassChip({
    required this.label,
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor =
        isDark ? Colors.white : Theme.of(context).colorScheme.onSurface;
    final bgColor =
        isDark
            ? Colors.white.withValues(alpha: 0.2)
            : Theme.of(context).colorScheme.surface.withValues(alpha: 0.94);
    final borderColor =
        isDark
            ? Colors.white.withValues(alpha: 0.3)
            : Theme.of(context).colorScheme.primary.withValues(alpha: 0.25);

    return _HoverScale(
      child: ActionChip(
        onPressed: () async {
          final uri = Uri.parse(url);
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        },
        avatar: Icon(icon, size: 16, color: fgColor),
        label: Text(
          label,
          style: TextStyle(color: fgColor, fontWeight: FontWeight.w600),
        ),
        backgroundColor: bgColor,
        side: BorderSide(color: borderColor),
        elevation: 0,
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _PillButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return _HoverScale(
      child: FilledButton.tonalIcon(
        onPressed: onTap,
        icon: Icon(icon, size: 16),
        label: Text(label, style: const TextStyle(fontSize: 13)),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}

class _NavPill extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _NavPill({
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.primary;
    return _HoverScale(
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor:
              isActive ? activeColor : activeColor.withValues(alpha: 0.12),
          foregroundColor: isActive ? Colors.white : activeColor,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          elevation: isActive ? 2 : 0,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

enum _SectionId { home, projects, about, contact }

class _PulsingAvatar extends StatefulWidget {
  @override
  State<_PulsingAvatar> createState() => _PulsingAvatarState();
}

class _PulsingAvatarState extends State<_PulsingAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _pulse = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulse,
      child: Container(
        width: 112,
        height: 112,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
        ),
        child: ClipOval(
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.white24),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: Image.asset(
                  'assets/me.jpeg',
                  width: 106,
                  height: 106,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TimelineDivider extends StatelessWidget {
  const _TimelineDivider();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: Container(
              height: 1.5,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpTile extends StatelessWidget {
  final String title, company, period, type, description;
  const _ExpTile({
    required this.title,
    required this.company,
    required this.period,
    required this.type,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          company,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          period,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(description, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class _StoreBtn extends StatelessWidget {
  final String url;
  final IconData icon;
  final Color color;
  const _StoreBtn({required this.url, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    final isArabic = Directionality.of(context) == TextDirection.rtl;
    return _HoverScale(
      child: IconButton(
        onPressed: () async {
          final uri = Uri.parse(url);
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        },
        icon: Icon(icon, color: color, size: 22),
        tooltip:
            url.contains('play.google')
                ? (isArabic ? 'جوجل بلاي' : 'Google Play')
                : (isArabic ? 'آب ستور' : 'App Store'),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

enum ProjectStatus { live, development }

class Project {
  final String titleEn, titleAr, subtitleEn, subtitleAr;
  final String? playStore, appStore;
  final ProjectStatus status;

  const Project({
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.subtitleAr,
    this.playStore,
    this.appStore,
    required this.status,
  });
}

class Certification {
  final String name, org, date;
  const Certification({
    required this.name,
    required this.org,
    required this.date,
  });
}
