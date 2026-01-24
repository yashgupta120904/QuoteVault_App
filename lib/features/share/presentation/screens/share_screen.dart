
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quotevault/core/constants/app_colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../quotes/presentation/provider/quote_provider.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final GlobalKey _previewKey = GlobalKey();
  

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<QuoteProvider>();

      /// 🚫 DO NOT override active quote
      if (provider.activeQuote == null) {
        provider.loadInitial(
          Supabase.instance.client.auth.currentUser!.id,
        );
      }
    });
  }

  double getEffectiveFontSize() {
    if (selectedRatio == '4:5') {
      return fontSize > 30 ? 30 : fontSize;
    }

    if (selectedRatio == '1:1') {
      return fontSize > 23 ? 23 : fontSize;
    }
    return fontSize; // 9:16
  }

  String selectedRatio = '9:16';
  String selectedTab = 'background';
  int selectedStyle = 0;
  String selectedFont = 'sans';
  double fontSize = 24;
  String alignment = 'center';
  bool isLoading = false;
  bool isBottomSheetExpanded = false;

  String quoteText = '"The only way to do great work is to love what you do."';
  String authorText = '— Steve Jobs';

  final List<Map<String, dynamic>> backgroundStyles = [
    {
      'name': 'Gradient Purple',
      'gradient':const  LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
         Color(0xFF310755),
       Color(0xFF3211d4),
  Color(0xFF1a0033)
        ],
      ),
    },
    {
      'name': 'Dark',
      'color': const Color(0xFF1a1a2e),
    },
    {
      'name': 'Sunset',
      'gradient': LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFFf97316), const Color(0xFFec4899)],
      ),
    },
    {
      'name': 'Ocean',
      'gradient': LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [const Color(0xFF10b981), const Color(0xFF06b6d4)],
      ),
    },
    {
      'name': 'Forest',
      'gradient': LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFF1b4332), const Color(0xFF2d6a4f)],
      ),
    },
    {
      'name': 'Midnight',
      'gradient': LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [const Color(0xFF0f1419), const Color(0xFF1a2634)],
      ),
    },
    {
      'name': 'Coral',
      'gradient': LinearGradient(
        colors: [const Color(0xFFff6b6b), const Color(0xFFffa94d)],
      ),
    },
    {
      'name': 'Aurora',
      'gradient': LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFF667eea), const Color(0xFF764ba2)],
      ),
    },
    {
      'name': 'Rose',
      'gradient': LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFFf472b6), const Color(0xFFec4899)],
      ),
    },
    {
      'name': 'Lime',
      'gradient': LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFFbef264), const Color(0xFF65a30d)],
      ),
    },
    {
      'name': 'Sky',
      'gradient': LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFF38bdf8), const Color(0xFF0369a1)],
      ),
    },
    {
      'name': 'Indigo',
      'gradient': LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [const Color(0xFF818cf8), const Color(0xFF312e81)],
      ),
    },
  ];

  double getAspectRatio() {
    switch (selectedRatio) {
      case '1:1':
        return 1.0;
      case '4:5':
        return 4 / 5;
      case '9:16':
      default:
        return 9 / 16;
    }
  }

  TextAlign getAlignment() {
    switch (alignment) {
      case 'left':
        return TextAlign.left;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.center;
    }
  }

  TextStyle getQuoteStyle() {
    switch (selectedFont) {
      case 'serif':
        return GoogleFonts.playfairDisplay(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          height: 1.3,
        );
      case 'mono':
        return GoogleFonts.jetBrainsMono(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.3,
        );
      case 'hand':
        return GoogleFonts.caveat(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 1.3,
        );
      default:
        return GoogleFonts.inter(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.white,
          height: 1.3,
        );
    }
  }

  TextStyle getFontPreviewStyle(String font) {
    switch (font) {
      case 'serif':
        return GoogleFonts.playfairDisplay(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        );
      case 'mono':
        return GoogleFonts.jetBrainsMono(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        );
      case 'hand':
        return GoogleFonts.caveat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        );
      default:
        return GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        );
    }
  }

  Future<void> shareQuote() async {
    try {
      setState(() => isLoading = true);
      final boundary = _previewKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.5);
      final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/quote.png');
      await file.writeAsBytes(bytes);

      await Share.shareXFiles([XFile(file.path)],
          text: 'Created with QuoteVault');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quote shared successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> saveQuote() async {
    try {
      setState(() => isLoading = true);
      final boundary = _previewKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.5);
      final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!
          .buffer
          .asUint8List();

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/quote.png');
      await file.writeAsBytes(bytes);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quote prepared for sharing!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void resetQuote() {
    setState(() {
      selectedStyle = 0;
      selectedFont = 'sans';
      fontSize = 24;
      alignment = 'center';
      quoteText = '"The only way to do great work is to love what you do."';
      authorText = '— Steve Jobs';
    });
  }

  @override
  Widget build(BuildContext context) {
      final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final provider = context.watch<QuoteProvider>();

    final quote = provider.activeQuote ?? provider.quoteOfDay;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:  isDark? AppColors.darkBg :AppColors.lightBg  ,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: isDark? AppColors.lightBg : AppColors.darkBg ,),
        ),
        title: Text(
          'Share Your Quote',
          style: TextStyle(
            color:isDark? AppColors.lightBg : AppColors.darkBg ,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: resetQuote,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Reset',
                style: TextStyle(
                  color: isDark?  AppColors.lightBg :AppColors.darkBg,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark? AppColors.lightBg.withOpacity(0.1) : AppColors.darkBg.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: ['9:16', '1:1', '4:5'].map((ratio) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => selectedRatio = ratio),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: selectedRatio == ratio 
                                            ? (isDark
          ? Colors.white.withOpacity(0.2)   // SAME as current dark UI
          : Colors.black.withOpacity(0.08)) // light-mode equivalent
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      ratio,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        RepaintBoundary(
                          key: _previewKey,
                          child: SizedBox(
                            width: 280,
                            child: AspectRatio(
                              aspectRatio: getAspectRatio(),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 20,
                                      offset: const Offset(0, 20),
                                    )
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: backgroundStyles[
                                                    selectedStyle]
                                                .containsKey('gradient')
                                            ? backgroundStyles[selectedStyle]
                                                ['gradient']
                                            : null,
                                        color: backgroundStyles[selectedStyle]
                                                .containsKey('color')
                                            ? backgroundStyles[selectedStyle]
                                                ['color']
                                            : null,
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.format_quote,
                                            size: 60,
                                            color:
                                                Colors.white.withOpacity(0.3),
                                          ),
                                          const SizedBox(height: 24),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0,
                                            ),
                                            child: Text(
                                              '"${quote!.text}"',
                                              textAlign: getAlignment(),
                                              style: getQuoteStyle().copyWith(
                                                fontSize:
                                                    getEffectiveFontSize(),
                                              ),
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                          Column(
                                            children: [
                                              Container(
                                                width: 32,
                                                height: 2,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                margin: const EdgeInsets.only(
                                                    bottom: 8),
                                              ),
                                              Text(
                                                "— ${quote.author}",
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1.2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Preview: Quote Card',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7B7B8E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            bottom: 0,
            left: 0,
            right: 0,
            height: isBottomSheetExpanded
                ? MediaQuery.of(context).size.height * 0.4
                : 80,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBg.withOpacity(0.8) : AppColors.lightBg.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark ?Colors.black.withOpacity(0.1) : AppColors.lightBg.withOpacity(0.1),
                    blurRadius: 40,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(
                        () => isBottomSheetExpanded = !isBottomSheetExpanded),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Icon(
                        isBottomSheetExpanded
                            ? Icons.expand_more
                            : Icons.expand_less,
                        color: isDark ? AppColors.lightBg : AppColors.darkBg,size: 30,
                      ),
                    ),
                  ),
                  if (isBottomSheetExpanded)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  _tabButton('background', 'Background'),
                                  _tabButton('typography', 'Typography'),
                                  _tabButton('custom', 'Custom'),
                                ],
                              ),
                            ),
                            if (selectedTab == 'background') _backgroundTab(),
                            if (selectedTab == 'typography') _typographyTab(),
                            if (selectedTab == 'custom') _customTab(),
                            const SizedBox(height: 16),
                            _actionsSection(),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String tab, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = tab),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selectedTab == tab
                    ? const Color(0xFF3211d4)
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _backgroundTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Style Presets',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: ui.Color.fromARGB(255, 98, 92, 128),
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: backgroundStyles.length + 1,
              itemBuilder: (context, index) {
                if (index == backgroundStyles.length) {
                  return const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8.0),
                  
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedStyle = index),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedStyle == index
                              ? const Color(0xFF3211d4)
                              : Colors.white.withOpacity(0.2),
                          width: selectedStyle == index ? 2 : 1,
                        ),
                        gradient:
                            backgroundStyles[index].containsKey('gradient')
                                ? backgroundStyles[index]['gradient']
                                : null,
                        color: backgroundStyles[index].containsKey('color')
                            ? backgroundStyles[index]['color']
                            : null,
                        boxShadow: selectedStyle == index
                            ? [
                                BoxShadow(
                                  color:
                                      const Color(0xFF3211d4).withOpacity(0.3),
                                  blurRadius: 8,
                                )
                              ]
                            : [],
                      ),
                      child: selectedStyle == index
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _typographyTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Font Style',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: ui.Color.fromARGB(255, 122, 113, 166),
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['sans', 'serif', 'mono', 'hand']
                  .map((font) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () => setState(() => selectedFont = font),
                          child: Column(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: selectedFont == font
                                        ? const Color(0xFF3211d4)
                                        : Colors.white.withOpacity(0.2),
                                    width: selectedFont == font ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    'Aa',
                                    style: getFontPreviewStyle(font),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                font[0].toUpperCase() + font.substring(1),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9b92c9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Font Size',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ui.Color.fromARGB(255, 122, 113, 166),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'A',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7B7B8E),
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: fontSize,
                            onChanged: (value) {
                              setState(() {
                                fontSize = value;
                              });
                            },
                            min: 16,
                            max: 48,
                            divisions: 32,
                            activeColor: const Color(0xFF3211d4),
                            inactiveColor: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        const Text(
                          'A',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Current: ${fontSize.toStringAsFixed(0)}px',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9b92c9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'Alignment',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ui.Color.fromARGB(255, 122, 113, 166),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      _buildAlignmentButton(
                        Icons.format_align_left,
                        'left',
                      ),
                      _buildAlignmentButton(
                        Icons.format_align_center,
                        'center',
                      ),
                      _buildAlignmentButton(
                        Icons.format_align_right,
                        'right',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _customTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Quote Text',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9b92c9),
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              maxLines: 3,
              controller: TextEditingController(text: quoteText),
              onChanged: (value) => setState(() => quoteText = value),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Enter quote text',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF3b3267)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF3211d4)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Author',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9b92c9),
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: TextEditingController(text: authorText),
              onChanged: (value) => setState(() => authorText = value),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Enter author name',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF3b3267)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF3211d4)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: isLoading ? null : shareQuote,
            icon: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.share),
            label: Text(isLoading ? 'Sharing...' : 'Share Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3211d4),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlignmentButton(IconData icon, String value) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => alignment = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: alignment == value
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon),
        ),
      ),
    );
  }
}
