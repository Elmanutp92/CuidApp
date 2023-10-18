import 'package:cuida_app/pages/home/home.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:flutter/material.dart';

class GoProfile extends StatefulWidget {
  const GoProfile({super.key});

  @override
  State<GoProfile> createState() => _GoProfileState();
}

class _GoProfileState extends State<GoProfile> {
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
