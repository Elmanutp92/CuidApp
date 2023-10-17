import 'package:cuida_app/pages/detail_person/detail.person.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPrueba extends StatefulWidget {
  const CardPrueba(
      {super.key, required this.personLastName, required this.personId, required this.personName, required this.personAge, required this.personGender,
      });

  final String personLastName;
  final String personId;
final String personName;
  final String personAge;
  final String personGender;

  @override
  State<CardPrueba> createState() => _CardPruebaState();
}

class _CardPruebaState extends State<CardPrueba> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    double wz = responsive.screenHeight;

    final styleCard =
        GoogleFonts.poppins(fontSize: wz * 0.02, color: AppColors.textColor);
    final styleCardPerson = GoogleFonts.poppins(
        fontSize: wz * 0.02,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold);

    return SizedBox(
      width: wz * 0.3,
      child: Card(
          color: Colors.blue.withOpacity(0.2),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: Icon(Icons.person)),
                    Row(
                      children: [
                        Text(
                          'Informacion',
                          style: GoogleFonts.poppins(
                            fontSize: dz * 0.012,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailPerson(
                          personName: widget.personName,
                          personGender: widget.personGender,
                          personAge: widget.personAge,
                          personId: widget.personId,
                          personLastName: widget.personLastName,
                        );
                      }));
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Nombre: ',
                                    style: styleCard,
                                  ),
                                  Text(
                                    'Apellido:',
                                    style: styleCard,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    widget.personName,
                                    style: styleCardPerson,
                                  ),
                                  Text(
                                    widget.personLastName,
                                    style: styleCardPerson,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
