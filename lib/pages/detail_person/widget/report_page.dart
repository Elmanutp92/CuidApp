import 'package:cuida_app/pages/detail_person/widget/form_report.dart';
import 'package:cuida_app/pages/loading_page.dart';
import 'package:cuida_app/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key, required this.userName, required this.docId}) : super(key: key);
  final String userName;
  final String docId;

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
   //final Responsive responsive = Responsive(context);
    

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
        backgroundColor: Colors.transparent,
        title: Text('Agregar Reporte a ${widget.userName}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.black,
            )),
      ),
      body: !isLoading ?  FormReport(
        docId: widget.docId,
        setLoading: setLoading,
        newReportOk: newReportOk,
        newReportFail: newReportFail,
      ) : const LoadingPage(),
    );
  }
   void newReportOk() {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        backgroundColor: AppColors.primaryColor,
        content: Text('Reporte agregada correctamente', style: GoogleFonts.poppins(
          color: AppColors.textColor
        
        ),),
        duration: const Duration(seconds: 1),
      ),
    );
    Navigator.pop(context);
  }

  void newReportFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ups, Error inesperado'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
