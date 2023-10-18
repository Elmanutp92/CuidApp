import 'package:cuida_app/Firebase/db/get_person_list.dart';
import 'package:cuida_app/pages/card_prueba.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PeopleListDataBase extends StatefulWidget {
  const PeopleListDataBase({Key? key}) : super(key: key);

  @override
  State<PeopleListDataBase> createState() => _PeopleListDataBaseState();
}

class _PeopleListDataBaseState extends State<PeopleListDataBase> {
  bool eliminar = false;
  bool isLoading = false;
  String userId = '';
  String userEmail = '';

  @override
  void initState() {
   
    super.initState();
     FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
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

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: personListFuture(userEmail, userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de carga mientras esperas los datos.
          print('Esperando datos...');
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Muestra un mensaje de error si hay un problema con la obtención de datos.
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Maneja el caso en el que no hay datos.
          print('No hay personas registradas');
          return const Center(
            child: Text(
              'No hay personas registradas',
              style: TextStyle(
                color: AppColors.textColor,
              ),
            ),
          );
        } else {
          // Datos cargados correctamente, construye tu interfaz de usuario.
          print('Datos cargados correctamente: ${snapshot.data}');
          final List<Map<String, dynamic>> personas = snapshot.data!;

          return SizedBox(
            width: wz * 0.99,
            height: hz * 0.21,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: personas.length,
              itemBuilder: (context, index) {
                final person = personas[index];
                return CardPrueba(
                  personName: person['name'],
                  personLastName: person['lastName'],
                  personId: person['id'],
                  personAge: person['age'],
                  personGender: person['gender'],
                );
              },
            ),
          );
        }
      },
    );
  }
}
