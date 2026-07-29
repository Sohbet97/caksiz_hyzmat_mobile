import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/main_bloc.dart';
import 'widgets/home_navigation_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = const [
      Center(child: Text('home')),
      Center(child: Text('category')),
      Center(child: Text('person')),
      Center(child: Text('cart')),
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
