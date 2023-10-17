import 'package:cuida_app/Firebase/db/get_person_stream.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoData extends StatefulWidget {
  const InfoData({super.key, required, required this.personId});
  final String personId;

  @override
  State<InfoData> createState() => _InfoDataState();
}

class _InfoDataState extends State<InfoData> {
  String userName = '';
  String userEmail = '';
  @override
  Widget build(BuildContext context) {
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
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    return StreamBuilder<Map<String, dynamic>>(
      stream: personStream(widget.personId, userEmail, userName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mientras se carga el stream, puedes mostrar un indicador de carga.
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Si hay un error, puedes mostrar un mensaje de error.
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          // Si no hay datos, puedes mostrar un mensaje indicando que no hay información disponible.
          return Text('No hay información disponible');
        } else {
          // Si hay datos disponibles, puedes acceder a ellos utilizando snapshot.data.
          final Map<String, dynamic> data = snapshot.data!;
          return Column(
      children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text('informacion de la persona', style: GoogleFonts.poppins(
            fontSize: dz * 0.03,
            )),
         ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Nombre: '),
            Text(data['name']),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Apellido: '),
            Text(data['lastName']),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Edad: '),
            Text(data['age']),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           const  Text('Genero: '),
            Text(data['gender']),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Id:'),
              Text(data['id']),
            ],
          ),
        ),
      ],
    );
        }
      },
    );

    
  }
}
