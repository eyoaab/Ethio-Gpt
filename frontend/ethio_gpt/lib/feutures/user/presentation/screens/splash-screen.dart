import 'dart:async';
import 'package:ethio_gpt/cors/widgets/bg-box-decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ethio_gpt/cors/utility-functions/token-validation.dart';
import 'package:ethio_gpt/feutures/chat/presentation/screens/make-caht-page.dart';
import 'package:ethio_gpt/feutures/user/domain/entity/user-entity.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_bloc.dart';
import 'package:ethio_gpt/feutures/user/presentation/bloc/user_event.dart';
import 'package:ethio_gpt/feutures/user/presentation/screens/login-page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final TokenValidation _tokenValidation = TokenValidation();

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _navigateToNextScreen();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMod =
        Theme.of(context).scaffoldBackgroundColor == Colors.black;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: bgBoxDecoration(isDarkMod),
        child: Center(
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: Image.asset(
              'assets/images/logo.png',
              height: 170,
              width: 170,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToNextScreen() async {
    try {
      final bool isTokenSet = await _tokenValidation.isTokenSet();
      String? token;

      if (isTokenSet) {
        token = await _tokenValidation.getToken();
        if (token != null) {
          final UserEntity user = UserEntity(token: token);
          context.read<UserBloc>().add(EmitUserLoginState(userEntity: user));
        }
      }

      Timer(
        const Duration(seconds: 5),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => (isTokenSet && token != null)
                  ? ChatScreen()
                  : const LoginScreen(),
            ),
          );
        },
      );
    } catch (error) {
      await _tokenValidation.removeToken();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }
}
