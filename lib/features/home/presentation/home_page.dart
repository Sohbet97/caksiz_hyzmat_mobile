import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/core/bloc/main_bloc.dart';
import 'package:mobile/features/category/bloc/category_bloc.dart';
import 'package:mobile/features/category/extensions/category_localization_extension.dart';
import 'package:mobile/features/home/bloc/tab_bar_visibility_bloc.dart';
import 'package:mobile/features/home/presentation/pages/all_body_widget.dart';
import 'package:mobile/features/home/presentation/pages/tab_body_widget.dart';
import 'package:mobile/features/home/presentation/widgets/home_error_widget.dart';
import 'package:mobile/features/home/presentation/widgets/home_shimmer_loader.dart';
import 'package:mobile/features/home/presentation/widgets/search_widget.dart';
import 'package:mobile/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(LoadCategoriesEvent());
  }

  int _languageFromCode(String code) {
    switch (code) {
      case 'ru':
        return 1;
      case 'en':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    return BlocProvider(
      create: (context) => TabBarVisibilityBloc(),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryError) {
            return HomeErrorWidget();
          }

          if (state is CategoryLoading) {
            return const HomeShimmerLoader();
          }

          if (state is CategoryLoaded) {
            final categories = state.categories;
            if (categories.isEmpty) {
              return const AllBodyWidget();
            }

            final allCategoryTab = Tab(text: localization.all);
            final categoryTabs = categories.map(
              (item) => Tab(
                text: item.localizedName(
                  _languageFromCode(
                    context.select(
                      (MainBloc bloc) => bloc.state.locale.languageCode,
                    ),
                  ),
                ),
              ),
            );

            final tabBodyWidgets = state.categories.map(
              (item) => TabBodyWidget(model: item),
            );

            final tabs = [allCategoryTab, ...categoryTabs];
            final bodyWidgets = <Widget>[
              const AllBodyWidget(),
              ...tabBodyWidgets,
            ];

            return DefaultTabController(
              length: tabs.length,
              child: SafeArea(
                child: Column(
                  children: [
                    const MyProductSearchWidget(),
                    BlocBuilder<TabBarVisibilityBloc, TabBarVisibilityState>(
                      builder: (context, visibility) {
                        final visible = visibility is! TabBarHidden;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          height: visible ? 50 : 0,
                          child: visible
                              ? TabBar(
                                  isScrollable: true,
                                  tabAlignment: TabAlignment.start,
                                  tabs: tabs,
                                )
                              : const SizedBox.shrink(),
                        );
                      },
                    ),
                    Expanded(
                      child: NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          final tabBarVisibilityBloc = context
                              .read<TabBarVisibilityBloc>();
                          if (notification.direction ==
                              ScrollDirection.reverse) {
                            tabBarVisibilityBloc.add(HideTabBar());
                          } else if (notification.direction ==
                              ScrollDirection.forward) {
                            tabBarVisibilityBloc.add(ShowTabBar());
                          }
                          return false;
                        },
                        child: TabBarView(children: bodyWidgets),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
