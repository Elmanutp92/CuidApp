import 'package:flutter/material.dart';

class DeteleConfirmation extends StatefulWidget {
  const DeteleConfirmation({super.key});

  @override
  State<DeteleConfirmation> createState() => _DeteleConfirmationState();
}

class _DeteleConfirmationState extends State<DeteleConfirmation> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Eliminar persona'),
      content: const Text('¿Está seguro que desea eliminar esta persona?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Eliminar')),
      ],
    );
  }
}
