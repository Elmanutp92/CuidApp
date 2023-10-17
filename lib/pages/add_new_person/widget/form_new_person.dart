import 'package:cuida_app/Firebase/db/new_person.dart';

import 'package:flutter/material.dart';

class FormNewPerson extends StatefulWidget {
  const FormNewPerson(
      {super.key,
      required this.setLoading,
      required this.newPersonOk,
      required this.newPersonFail});
  final Function setLoading;
  final Function newPersonOk;
  final Function newPersonFail;

  @override
  State<FormNewPerson> createState() => _FormNewPersonState();
}

class _FormNewPersonState extends State<FormNewPerson> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un apellido';
                  }
                  return null;
                },
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una edad';
                  }
                  return null;
                },
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un sexo';
                  }
                  return null;
                },
                controller: _sexController,
                decoration: const InputDecoration(
                  labelText: 'Sexo',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await newPerson(
                            _nameController.text,
                            _lastNameController.text,
                            _ageController.text,
                            _sexController.text,
                            widget.newPersonOk,
                            widget.newPersonFail,
                            widget.setLoading);
                      }
                      
                    },
                    child: const Text('Guardar')),
              )
            ],
          ),
        ));
  }
}
