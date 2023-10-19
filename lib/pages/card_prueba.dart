import 'package:cuida_app/Firebase/storage/get_image_person.dart';
import 'package:cuida_app/widget/with_peron_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CardPrueba extends StatefulWidget {
  const CardPrueba({
    super.key,
    required this.personLastName,
    required this.personId,
    required this.personName,
    required this.personAge,
    required this.personGender,
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
  String userEmail = '';
  String urlImage = '';
  String userName = '';
  String userId = '';
  bool isFutureCalled = false;

  Future<void> loadUrlImage() async {
    final url =
        await getUrlImagePerson(widget.personId, userId, userEmail, userName);
    if (url.toString().isNotEmpty || url.toString() != '') {
      // Solo actualizamos el estado si la URL no es nula
      setState(() {
        urlImage = url;
      });
    }
  }

  @override
  void initState() {
    print('urlImage desde init state: $urlImage');
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        setState(() {
          userName = user.displayName.toString();
          userId = user.uid.toString();
          userEmail = user.email.toString();
        });

        // Llamamos al Future solo si no se ha llamado antes
        if (!isFutureCalled) {
          isFutureCalled = true;
          loadUrlImage();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: Future.value(urlImage),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.hasError) {
            WithImagePerson(
              personLastName: widget.personLastName,
              personId: widget.personId,
              personName: widget.personName,
              personAge: widget.personAge,
              personGender: widget.personGender,
              urlPersonImage: snapshot.data.toString(),
            );
          } else if (!snapshot.hasData ||
              snapshot.data!.isEmpty ||
              snapshot.data == null) {
            return WithImagePerson(
              personLastName: widget.personLastName,
              personId: widget.personId,
              personName: widget.personName,
              personAge: widget.personAge,
              personGender: widget.personGender,
              urlPersonImage: snapshot.data.toString(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras esperas los datos.

            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data! == '') {
            const Text('url vacias');
          }
          return WithImagePerson(
            personLastName: widget.personLastName,
            personId: widget.personId,
            personName: widget.personName,
            personAge: widget.personAge,
            personGender: widget.personGender,
            urlPersonImage: snapshot.data.toString(),
          );
        });
  }
}
