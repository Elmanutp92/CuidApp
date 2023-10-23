
import 'package:cuida_app/pages/detail_person/detail.person.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPerson extends StatefulWidget {
  const CardPerson(
      {super.key, required this.personLastName, required this.eliminar, required this.setEliminar, required this.personId, required this.setLoading, required this.personAge, required this.personGender, required this.personName,
      });

  final String personLastName;
  final bool eliminar;
  final Function setEliminar;
  final String personId;
  final Function setLoading;
  final String personAge;
  final String personGender;
  final String personName;

  @override
  State<CardPerson> createState() => _CardPersonState();
}

class _CardPersonState extends State<CardPerson> {
  String userName = '';

  @override
  Widget build(BuildContext context) {
     FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        
      } else {
        setState(() {
          userName = user.displayName.toString();
        });
      }
    });
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
        color: Colors.amber,
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
                    !widget.eliminar
                        ? IconButton(
                            onPressed: () {
                              widget.setEliminar();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: dz * 0.02,
                            ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    widget.setEliminar();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.green,
                                    size: dz * 0.02,
                                  )),
                              TextButton(
                                  onPressed: () async {
                                   
                                  },
                                  child: Text(
                                    'Eliminar',
                                    style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontSize: dz * 0.015),
                                  )),
                            ],
                          )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                FirebaseAuth.instance.currentUser!.displayName!,
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
