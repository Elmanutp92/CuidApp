import 'package:cuida_app/Firebase/db/get_reports_stream.dart';
import 'package:cuida_app/pages/detail_person/widget/card_report.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportsDataBase extends StatefulWidget {
  const ReportsDataBase({
    Key? key,
    required this.personId,
  }) : super(key: key);

  final String personId;

  @override
  State<ReportsDataBase> createState() => _ReportsDataBaseState();
}

class _ReportsDataBaseState extends State<ReportsDataBase> {
  bool eliminar = false;
  bool isLoading = false;
  String uId = '';
  String uEmail = '';

  @override
  void initState() {
    getUserId();
    super.initState();
     FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        setState(() {
          userName = user.displayName.toString();
          userEmail = user.email.toString();
        });
      }
    });

  }

  void getUserId() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuario = auth.currentUser;

    if (usuario != null) {
      setState(() {
        uId = usuario.uid;
        uEmail = usuario.email!;
      });
    } else {
      // Manejar el caso en que no hay usuario autenticado
    }
  }

  String userName = '';
  String userEmail = '';

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;
    double dz = responsive.diagonal;

    return !isLoading
        ? SizedBox(
            width: wz * 0.99,
            height: hz * 0.21,
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: reportStream(widget.personId, uEmail, userName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay reportes registrados',
                      style: TextStyle(
                        color: AppColors.textColor,
                      ),
                    ),
                  );
                } else {
                  final List<Map<String, dynamic>> reportes = snapshot.data!;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: reportes.length,
                    itemBuilder: (context, index) {
                      final report = reportes[index];
                      return CardReport(
                        setLoading: setLoading,
                        personId: widget.personId,
                        reportId: report['id'],
                        titulo: report['titulo'],
                        descripcion: report['descripcion'],
                      );
                    },
                  );
                }
              },
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Eliminando reporte',
                style: GoogleFonts.poppins(
                  color: AppColors.textColor,
                  fontSize: dz * 0.02,
                ),
              ),
              const CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ],
          );
  }

  setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  setEliminar() {
    setState(() {
      eliminar = !eliminar;
    });
  }
}
