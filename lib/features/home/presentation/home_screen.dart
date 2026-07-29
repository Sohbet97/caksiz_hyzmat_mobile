import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/cart/presentation/cart_page.dart';
import 'package:mobile/features/category/presentation/category_page.dart';
import 'package:mobile/features/home/presentation/home_page.dart';
import 'package:mobile/features/person/presentation/person_page.dart';

import '../../../core/bloc/main_bloc.dart';
import 'widgets/home_navigation_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = const [
      HomePage(),
      CategoryPage(),
      PersonPage(),
      CartPage(),
    ];
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.navigationIndex],
          bottomNavigationBar: const MyNavigationWidget(),
        );
      },
    );
  }
}
