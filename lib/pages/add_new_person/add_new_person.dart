

import 'package:cuida_app/pages/add_new_person/widget/form_new_person.dart';
import 'package:cuida_app/pages/loading_page.dart';


import 'package:cuida_app/styles/responsive.dart';
import 'package:flutter/material.dart';


class AddNewPerson extends StatefulWidget {
  const AddNewPerson(
      {super.key, required this.newPersonOk, required this.newPersonFail});
  final Function newPersonOk;
  final Function newPersonFail;

  @override
  State<AddNewPerson> createState() => _AddNewPersonState();
}

class _AddNewPersonState extends State<AddNewPerson> {
 
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double dz = responsive.diagonal;
    //double wz = responsive.screenWidth;
    double hz = responsive.screenHeight;
    return !isLoading
        ? Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  height: hz,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Agregar Nueva Persona',
                            style: TextStyle(
                              fontSize: dz * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ))
                        ],
                      ),
                     
                      FormNewPerson(
                        setLoading: setLoading,
                        newPersonOk: widget.newPersonOk,
                        newPersonFail: widget.newPersonFail,
                      )
                      // Agregar campos de entrada, botones, etc. aquí.
                    ],
                  ),
                ),
              ),
            ),
          )
        : const LoadingPage();
  }

  void setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
  
}
