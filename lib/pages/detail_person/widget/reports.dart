import 'package:cuida_app/pages/detail_person/widget/report_page.dart';
import 'package:cuida_app/pages/detail_person/widget/reports_data_base.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reports extends StatefulWidget {
  const Reports({super.key, required this.personName, required this.personId});
  final String personName;
  final String personId;

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    double dw = responsive.screenWidth;
    double dh = responsive.screenHeight;

    return SizedBox(
      height: dh * 0.65,
      width: dw * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reportes de ${widget.personName}',
                  style: GoogleFonts.poppins(
                    fontSize: dz * 0.02,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReportsPage(
                                  personId: widget.personId,
                                  userName: widget.personName,
                                )));
                  },
                  child: Text('Agregar',
                      style: GoogleFonts.poppins(
                        fontSize: dz * 0.015,
                      ))),
            ],
          ),
          SizedBox(
            height: dh * 0.28,
            //color: Colors.amber,
            child: ReportsDataBase(
              personName: widget.personName,
              personId: widget.personId,
            ),
          )
        ],
      ),
    );
  }
}
