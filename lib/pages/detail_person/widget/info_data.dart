import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class InfoData extends StatefulWidget {
  const InfoData(
      {super.key,
      required,
      required this.personId,
      required this.personName,
      required this.personLastName,
      required this.personAge,
      required this.personGender});
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
     String generalInfoHombre18Mas =
        '${widget.personName}, es un hombre adulto de ${widget.personAge} años. En esta etapa de la vida, es fundamental cuidar de su bienestar integral. Le recomendamos mantener una alimentación equilibrada, incorporar hábitos de ejercicio y prestar atención a su salud mental. Explorar secciones específicas sobre nutrición, fitness y bienestar emocional en CuidApp puede proporcionarle consejos adaptados a sus necesidades. Gracias a ${widget.personName} por confiar en CuidApp para su salud y bienestar';
     String generalInfoHombre18Menos =
        '${widget.personName} es un joven hombre de ${widget.personAge} años, y en CuidApp, queremos apoyarlo en su camino hacia un futuro saludable y feliz. Como joven hombre, es esencial construir buenos hábitos desde temprano. Le recomendamos enfocarse en una alimentación balanceada, mantener la actividad física y prestar atención a su bienestar emocional. En CuidApp, ${widget.personName} encontrará recursos específicos que lo ayudarán a navegar por esta etapa de la vida y establecer las bases para un futuro saludable. Gracias a [Nombre] por ser parte de nuestra comunidad en CuidApp.';
     String generalInfoMujer18Mas =
        '${widget.personName}, es una mujer adulta de ${widget.personAge} años. En esta etapa de la vida, es esencial cuidar de su bienestar integral. Le recomendamos mantener una alimentación equilibrada, incorporar hábitos de ejercicio y prestar atención a su salud mental. Descubrir secciones específicas sobre nutrición, fitness y bienestar emocional en CuidApp puede proporcionarle consejos adaptados a sus necesidades. Gracias a ${widget.personName} por confiar en CuidApp para su salud y bienestar.';
     String generalInfoMujer18Menos =
        '${widget.personName} es una joven mujer de ${widget.personAge} años, y en CuidApp, queremos apoyarla en su camino hacia un futuro saludable y feliz. Como joven mujer, es esencial construir buenos hábitos desde temprano. Le recomendamos enfocarse en una alimentación balanceada, mantener la actividad física y prestar atención a su bienestar emocional. En CuidApp, ${widget.personName} encontrará recursos específicos que la ayudarán a navegar por esta etapa de la vida y establecer las bases para un futuro saludable. Gracias a ${widget.personName} por ser parte de nuestra comunidad en CuidApp.';
  final personAge = int.parse(widget.personAge);

    
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;

    final generalInfo = GoogleFonts.poppins(
      fontSize: dz * 0.015,
      fontWeight: FontWeight.w500,
    );

    final userInfoStyle = GoogleFonts.poppins(
      fontSize: dz * 0.015,
      fontWeight: FontWeight.w500,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Información personal',
                    style: GoogleFonts.poppins(
                      fontSize: dz * 0.02,
                    )),
                IconButton(
                    onPressed: () {
                      showMenu(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: AppColors.backgroundColor,
                        context: context,
                        position: const RelativeRect.fromLTRB(10, 30, 0, 0),
                        items: [
                           PopupMenuItem(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text(
                                        'Información general',
                                        style: TextStyle(
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: dz * 0.015,
                                        ),
                                                                       ),
                                     ),
                                   SizedBox(
                                    width: wz * 0.8,
                                    height: hz * 0.4,
                                  
                                    child: personAge < 18 && widget.personGender == 'mujer' ? Text(generalInfoMujer18Menos, style: generalInfo) : personAge > 18 && widget.personGender == 'mujer' ?  Text(generalInfoMujer18Mas, style: generalInfo) : personAge < 18 && widget.personGender == 'hombre' ? Text(generalInfoHombre18Menos, style: generalInfo) : Text(generalInfoHombre18Mas, style: generalInfo),
                                   )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).then((value) {
                        // Maneja la opción seleccionada si es necesario
                        if (value != null) {
                      
                        }
                      });
                    },
                    icon: Icon(Iconsax.info_circle,
                        size: dz * 0.025, color: AppColors.accentColor)),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.textColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: hz * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    //color: Colors.red,
                    width: wz * 0.2,
                    child: const Icon(Iconsax.user)),
                Expanded(
                    child: Center(
                        child: Text(
                            '${widget.personName}' '${widget.personLastName}',
                            style: userInfoStyle))),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.textColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: hz * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: wz * 0.2,
                    child: widget.personGender == 'hombre'
                        ? const Icon(Iconsax.man)
                        : const Icon(Iconsax.woman)),
                Expanded(
                    child: Center(
                        child:
                            Text(widget.personGender, style: userInfoStyle))),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.textColor,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: hz * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: wz * 0.2, child: const Icon(Iconsax.favorite_chart)),
                Expanded(
                    child: Center(
                        child: Text(widget.personAge, style: userInfoStyle))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
