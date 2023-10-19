
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoData extends StatefulWidget {
  const InfoData({super.key, required, required this.personId, required this.personName, required this.personLastName, required this.personAge, required this.personGender});
  final String personId;
  final String personName;
  final String personLastName;
  final String personAge;
  final String personGender;





  @override
  State<InfoData> createState() => _InfoDataState();
}

class _InfoDataState extends State<InfoData> {
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
   
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
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('informacion de la persona',
                    style: GoogleFonts.poppins(
                      fontSize: dz * 0.03,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Nombre: '),
                  Text(widget.personName),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Apellido: '),
                  Text(widget.personLastName),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Edad: '),
                  Text(widget.personAge),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Genero: '),
                  Text(widget.personGender),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Id:'),
                    Text(widget.personId),
                  ],
                ),
              ),
            ],
          );
        }
      
    
  
}
