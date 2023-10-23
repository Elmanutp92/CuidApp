import 'package:cuida_app/Firebase/db/delete_report.dart';
import 'package:cuida_app/pages/loading_page.dart';

import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardReport extends StatefulWidget {
  const CardReport({
    Key? key,
    required this.titulo,
    required this.descripcion,
    required this.personId,
    required this.reportId,
    required this.setLoading,
    this.isLoading,
    this.isError,
    this.isEmpty,
  }) : super(key: key);

  final String titulo;
  final String descripcion;
  final String personId;
  final String reportId;
  final Function setLoading;
  final bool? isLoading;
  final bool? isError;
  final bool? isEmpty;

  @override
  State<CardReport> createState() => _CardReportState();
}

class _CardReportState extends State<CardReport> {
  String userId = '';
  String userEmail = '';

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // ...
      } else {
        setState(() {
          userId = user.uid.toString();
          userEmail = user.email.toString();
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;

    return !widget.isLoading!
        ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              width: wz * 0.5,
              height: hz * 0.1,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 12,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.accentColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            )),
                        height: hz * 0.04,
                        width: wz * 0.9,
                        child: widget.isLoading!
                            ? const CircularProgressIndicator()
                            : Text(
                                widget.isError!
                                    ? 'Error'
                                    : widget.isEmpty!
                                        ? 'isEmpty'
                                        : widget.titulo,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: wz * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: wz * 0.8,
                          height: hz * 0.13,
                          child: widget.isLoading!
                              ? const CircularProgressIndicator()
                              : Text(
                                  widget.isError!
                                      ? 'Error'
                                      : widget.isEmpty!
                                          ? 'isEmpty'
                                          : widget.descripcion,
                                  style: GoogleFonts.poppins(
                                    fontSize: wz * 0.04,
                                  ),
                                ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await deleteReport(
                            deleteOk,
                            deleteNotOK,
                            widget.personId,
                            widget.setLoading,
                            widget.reportId,
                            userId,
                            userEmail,
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        )
        : const LoadingPage();
  }

  void deleteOk() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reporte eliminado'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void deleteNotOK() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error al eliminar el reporte'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
