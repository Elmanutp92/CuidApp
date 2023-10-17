import 'package:cuida_app/Firebase/db/new_report.dart';
import 'package:cuida_app/styles/colors.dart';

import 'package:flutter/material.dart';

class FormReport extends StatefulWidget {
  const FormReport(
      {super.key,
      required this.setLoading,
      required this.newReportOk,
      required this.newReportFail,
      required this.docId});
  final Function setLoading;
  final Function newReportOk;
  final Function newReportFail;
  final String docId;

  @override
  State<FormReport> createState() => _FormReportState();
}

class _FormReportState extends State<FormReport> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final Responsive responsive = Responsive(context);
    //double dz = responsive.diagonal;
    //double wz = responsive.screenWidth;
    //double hz = responsive.screenHeight;
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un titulo';
                    }
                    return null;
                  },
                  cursorColor: AppColors.textColor,
                  controller: _titleController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    labelText: 'Titulo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una descripcion';
                    }
                    return null;
                  },
                  cursorColor: AppColors.textColor,
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    labelText: 'Descripcion',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      newReport(
                          _titleController.text,
                          _descriptionController.text,
                          widget.setLoading,
                          widget.newReportOk,
                          widget.newReportFail,
                          widget.docId);
                    }
                  },
                  child: const Text('Enviar'))
            ],
          ),
        ));
  }
}
