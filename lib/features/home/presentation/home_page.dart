import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/category/bloc/category_bloc.dart';
import 'package:mobile/features/home/presentation/widgets/home_error_widget.dart';
import 'package:mobile/features/home/presentation/widgets/home_shimmer_loader.dart';
import 'package:mobile/generated/l10n.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController? _tabController;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(LoadCategoriesEvent());
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = S.of(context);
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryError) {
          return HomeErrorWidget();
        }

        if (state is CategoryLoading) {
          return const HomeShimmerLoader();
        }

        if (state is CategoryLoaded) {
          return const HomeShimmerLoader();
        }

        return SizedBox.shrink();
      },
    );
  }
}
