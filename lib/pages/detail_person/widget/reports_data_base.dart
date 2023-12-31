import 'package:cuida_app/Firebase/db/get_reports_list.dart';
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
    required this.personName,
  }) : super(key: key);

  final String personId;
  final String personName;

  @override
  State<ReportsDataBase> createState() => _ReportsDataBaseState();
}

class _ReportsDataBaseState extends State<ReportsDataBase> {
  bool eliminar = false;
  bool isLoading = false;
  String userId = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
      } else {
        setState(() {
          userId = user.uid.toString();
          userEmail = user.email.toString();
        });
      }
    });
  }

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
            child: FutureBuilder<List<Map<String, dynamic>>>(
                future: reportFuture(widget.personId, userEmail, userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: wz * 0.9,
                      height: hz * 0.21,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accentColor,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Muestra un mensaje de error si hay un problema con la obtención de datos.

                    return Text('Error Manuel mirame: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // Maneja el caso en el que no hay datos.

                    return Center(
                      child: Text(
                        'No hay reportes registrados para ${widget.personName}',
                        style: const TextStyle(
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
                          isEmpty: false,
                          isError: false,
                          isLoading: false,
                          setLoading: setLoading,
                          personId: widget.personId,
                          reportId: report['id'],
                          titulo: report['titulo'],
                          descripcion: report['descripcion'],
                        );
                      },
                    );
                  }
                }))
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
