import 'package:flutter/material.dart';

class MapPickerWidget extends StatelessWidget {
  final VoidCallback onPickLocation;

  const MapPickerWidget({super.key, required this.onPickLocation});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPickLocation,
      icon: const Icon(Icons.location_on),
      label: const Text('Seleccionar ubicación'),
    );
  }
}
