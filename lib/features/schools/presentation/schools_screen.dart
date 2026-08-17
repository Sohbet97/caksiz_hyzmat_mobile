import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/schools/bloc/schools_bloc.dart';
import 'package:mobile/features/schools/data/models/school_model.dart';
import 'package:mobile/features/schools/presentation/widgets/school_error_widget.dart';
import 'package:mobile/features/schools/presentation/widgets/school_list_item.dart';
import 'package:mobile/features/schools/presentation/widgets/schools_alphabet_sidebar_widget.dart';
import 'package:mobile/features/schools/presentation/widgets/schools_empty_widget.dart';
import 'package:mobile/features/schools/presentation/widgets/schools_header_widget.dart';
import 'package:mobile/generated/l10n.dart';

import '../../../core/theme/app_colors.dart';

class SchoolsScreen extends StatefulWidget {
  const SchoolsScreen({super.key});

  @override
  State<SchoolsScreen> createState() => _SchoolsScreenState();
}

class _SchoolsScreenState extends State<SchoolsScreen> {
  final _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {};
  String? _selectedLetter;

  @override
  void initState() {
    super.initState();
    context.read<SchoolsBloc>().add(LoadSchools());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<SchoolsBloc>().add(LoadMoreSchools());
    }
  }

  void _onSearchChanged(String query) {
    context.read<SchoolsBloc>().add(
      LoadSchools(search: query.isEmpty ? null : query),
    );
  }

  void _onLetterTap(String letter) {
    setState(() => _selectedLetter = letter);
    final key = _sectionKeys[letter];
    final ctx = key?.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.light;
    final locale = Localizations.localeOf(context);
    final localization = S.of(context);

    return Scaffold(
      backgroundColor: AppColors.light.background,
      body: SafeArea(
        child: Column(
          children: [
            SchoolsHeaderWidget(
              onSearchChanged: _onSearchChanged,
              onFilterTap: () {},
            ),
            Expanded(
              child: BlocBuilder<SchoolsBloc, SchoolsState>(
                builder: (context, state) {
                  if (state is SchoolsInitial || state is SchoolsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is SchoolsError) {
                    return Center(
                      child: SchoolErrorWidget(
                        errorText: localization.schoolsLoadError,
                        onTap: () {
                          context.read<SchoolsBloc>().add(LoadSchools());
                        },
                        icon: Icons.error,
                      ),
                    );
                  }

                  final loaded = state as SchoolsLoaded;
                  if (loaded.schools.isEmpty) {
                    return Center(
                      child: SchoolsEmptyWidget(
                        icon: Icons.school,
                        title: localization.noSchoolsFound,
                        subtitle: localization.noSchoolsFoundDEsc,
                        actionLabel: localization.retry,
                        onAction: () {
                          context.read<SchoolsBloc>().add(LoadSchools());
                        },
                      ),
                    );
                  }

                  final sorted = List<SchoolModel>.from(loaded.schools)
                    ..sort(
                      (a, b) => a
                          .localizedName(locale)
                          .toUpperCase()
                          .compareTo(b.localizedName(locale).toUpperCase()),
                    );

                  final Map<String, List<SchoolModel>> grouped = {};
                  for (final school in sorted) {
                    final name = school.localizedName(locale);
                    final letter = name.isNotEmpty
                        ? name[0].toUpperCase()
                        : '#';
                    grouped.putIfAbsent(letter, () => []).add(school);
                  }

                  final letters = grouped.keys.toList()..sort();
                  for (final letter in letters) {
                    _sectionKeys.putIfAbsent(letter, () => GlobalKey());
                  }

                  final visibleLetters = _selectedLetter == null
                      ? letters
                      : letters.where((l) => l == _selectedLetter).toList();

                  final featured = sorted.take(3).toList();

                  return ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [
                      if (featured.isNotEmpty) ...[
                        _SectionLabel(text: localization.schoolsFeaturedTitle),
                        ...featured.map(
                          (school) => SchoolListItem(
                            school: school,
                            featured: true,
                            onTap: () => context.go(
                              AppRoutes.schoolDetails,
                              extra: school,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      _SectionLabel(text: localization.schoolsAllTitle),
                      const SizedBox(height: 4),
                      SchoolsAlphabetSidebarWidget(
                        availableLetters: letters.toSet(),
                        selectedLetter: _selectedLetter,
                        onLetterTap: _onLetterTap,
                        onAllTap: () => setState(() => _selectedLetter = null),
                      ),
                      const SizedBox(height: 8),
                      for (final letter in visibleLetters) ...[
                        Container(
                          key: _sectionKeys[letter],
                          padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                          child: Text(
                            letter,
                            style: TextStyle(
                              color: colors.primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        ...grouped[letter]!.map(
                          (school) => SchoolListItem(
                            school: school,
                            onTap: () => context.go(
                              AppRoutes.schoolDetails,
                              extra: school,
                            ),
                          ),
                        ),
                      ],
                      if (!loaded.hasReachedMax)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.light;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [colors.primaryDark, colors.warning],
        ).createShader(bounds),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'serif',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}