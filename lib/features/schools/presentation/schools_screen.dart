import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/features/schools/bloc/schools_bloc.dart';
import 'package:mobile/features/schools/presentation/widgets/school_error_widget.dart';
import 'package:mobile/features/schools/presentation/widgets/school_list_item.dart';
import 'package:mobile/features/schools/presentation/widgets/schools_empty_widget.dart';
import 'package:mobile/features/schools/presentation/widgets/schools_search_field.dart';
import 'package:mobile/generated/l10n.dart';

class SchoolsScreen extends StatefulWidget {
  const SchoolsScreen({super.key});

  @override
  State<SchoolsScreen> createState() => _SchoolsScreenState();
}

class _SchoolsScreenState extends State<SchoolsScreen> {
  final _scrollController = ScrollController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SchoolsSearchField(onChanged: _onSearchChanged),
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
                        errorText: S.of(context).schoolsLoadError,
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
                        title: S.of(context).noSchoolsFound,
                        subtitle: S.of(context).noSchoolsFoundDEsc,
                        actionLabel: S.of(context).retry,
                        onAction: () {
                          context.read<SchoolsBloc>().add(LoadSchools());
                        },
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        loaded.schools.length + (loaded.hasReachedMax ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index >= loaded.schools.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return SchoolListItem(
                        school: loaded.schools[index],
                        onTap: () {
                          context.go(
                            AppRoutes.schoolDetails,
                            extra: loaded.schools[index],
                          );
                        },
                      );
                    },
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
