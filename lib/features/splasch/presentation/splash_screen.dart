import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/bloc/main_bloc.dart';
import '../../../core/router/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MainBloc>().add(MainStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listenWhen: (previous, current) =>
          previous.isLoading && !current.isLoading,
      listener: (context, state) => context.go(AppRoutes.home),
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
