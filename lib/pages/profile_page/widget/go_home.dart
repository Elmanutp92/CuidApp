import 'package:cuida_app/pages/home/home.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:flutter/material.dart';

class GoToHome extends StatefulWidget {
  const GoToHome({super.key});

  @override
  State<GoToHome> createState() => _GoToHomeState();
}

class _GoToHomeState extends State<GoToHome> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
      icon: const Icon(Icons.arrow_back),
      color: AppColors.textColor,
    );
  }
}
