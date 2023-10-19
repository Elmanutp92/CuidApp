import 'package:cuida_app/pages/add_new_person/add_new_person.dart';
import 'package:cuida_app/pages/home/widget/people_list_data_base.dart';
import 'package:cuida_app/styles/colors.dart';
import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PeopleList extends StatefulWidget {
  const PeopleList({Key? key, required this.newPersonOk, required this.newPersonFail}) : super(key: key);

  final Function newPersonOk;
  final Function newPersonFail;

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
   // double wz = responsive.screenHeight;
   // double hz = responsive.screenHeight;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 20,
      color: Colors.blue[10],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Personas',
                    style: GoogleFonts.poppins(
                      fontSize: dz * 0.02,
                      color: AppColors.textColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => AddNewPerson(
                          newPersonOk: widget.newPersonOk,
                          newPersonFail: widget.newPersonFail,
                        ),
                      );
                    },
                    child: Text(
                      'Agregar',
                      style: GoogleFonts.poppins(
                        fontSize: dz * 0.015,
                        color: AppColors.accentColor,
                      ),
                    ),
                  ),
                ],
              ),
              const PeopleListDataBase(),
            ],
          ),
        ),
      ),
    );
  }
}
