import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/theme/app_colors.dart';

import '../../../core/bloc/main_bloc.dart';
import '../../../core/router/app_router.dart';
import '../../../generated/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;

  late Animation<double> _logoOpacity;
  late Animation<double> _logoScale;
  late Animation<double> _textOpacity;

  String message = 'message';

  @override
  void initState() {
    super.initState();
    context.read<MainBloc>().add(MainStarted());
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    _logoScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
    _startApp();
    _logoController.forward().then((_) {
      _textController.forward();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _startApp() async {
    bool isConnected = await _isConnectedToServer();

    if (!isConnected) {
      // TODO show dialog
    } else {
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted) {
          context.go(AppRoutes.home);
        }
      });
    }
  }

  Future<bool> _isConnectedToServer() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final t = S.of(context);
    final size = MediaQuery.of(context).size;
    return BlocListener<MainBloc, MainState>(
      listenWhen: (previous, current) =>
          previous.isLoading && !current.isLoading,
      listener: (context, state) => context.go(AppRoutes.home),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              ScaleTransition(
                scale: _logoScale,
                child: FadeTransition(
                  opacity: _logoOpacity,
                  child: Image.asset(
                    'assets/images/horizontal_logo.png',
                    height: size.height * 0.2,
                    width: size.width * 0.6,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Center(child: Icon(Icons.error)),
                  ),
                ),
              ),

              const SizedBox(height: 15),
              FadeTransition(
                opacity: _textOpacity,
                child: Column(
                  children: [
                    Text(
                      t.AppName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      t.ynam_sizden.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.light.primaryLight,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      t.netije_bizden.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.light.primaryLight,
                        letterSpacing: 1,
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
}
