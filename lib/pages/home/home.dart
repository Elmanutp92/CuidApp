import 'package:cuida_app/pages/home/widget/bienvenido.dart';
import 'package:cuida_app/pages/home/widget/people_list.dart';
import 'package:cuida_app/provider/user_data_info.dart';

import 'package:cuida_app/styles/colors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  final User? user = FirebaseAuth.instance.currentUser;
  final userName = FirebaseAuth.instance.currentUser!.displayName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final Responsive responsive = Responsive(context);
    //double dz = responsive.diagonal;
    //double wz = responsive.screenWidth;
    //double hz = responsive.screenHeight;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Consumer<UserDataInfo>(builder: (context, dataInfo, child) {
                      return const Bienvenido();
                    }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PeopleList(
                    newPersonOk: newPersonOk,
                    newPersonFail: newPersonFail,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void newPersonOk() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primaryColor,
        content: Text(
          'Persona agregada correctamente',
          style: GoogleFonts.poppins(color: AppColors.textColor),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
    Navigator.pop(context);
  }

  void newPersonFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ups, Error inesperado'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
