import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../images/images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) => context.go('/home'),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Image.asset(
          logoDevPY,
        ),
      ),
    );
  }
}
