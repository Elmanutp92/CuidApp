import 'package:cuida_app/Firebase/db/get_person_list.dart';
import 'package:cuida_app/pages/card_prueba.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';


class PeopleListDataBase extends StatefulWidget {
  const PeopleListDataBase({Key? key}) : super(key: key);

  @override
  State<PeopleListDataBase> createState() => _PeopleListDataBaseState();
}

class _PeopleListDataBaseState extends State<PeopleListDataBase> {
  bool eliminar = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: personListStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final List<Map<String, dynamic>> personas = snapshot.data!;
          // Construir tu interfaz de usuario con la lista de personas
          return personas.isNotEmpty
              ? SizedBox(
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
                )
              : const Center(
                  child: Text(
                    'No hay personas registradas',
                    style: TextStyle(
                      color: AppColors.textColor,
                    ),
                  ),
                );
        }
      },
    );

   
  }
}
