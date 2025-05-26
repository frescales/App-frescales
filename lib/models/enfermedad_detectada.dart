class EnfermedadDetectada {
  final String id;
  final DateTime fecha;
  final String ubicacionId;
  final String enfermedadId;
  final String severidad;
  final String? observaciones;

  EnfermedadDetectada({
    required this.id,
    required this.fecha,
    required this.ubicacionId,
    required this.enfermedadId,
    required this.severidad,
    this.observaciones,
  });

  factory EnfermedadDetectada.fromMap(Map<String, dynamic> map) {
    return EnfermedadDetectada(
      id: map['id'] as String,
      fecha: DateTime.parse(map['fecha']),
      ubicacionId: map['ubicacion_id'] as String,
      enfermedadId: map['enfermedad_id'] as String,
      severidad: map['severidad'] as String,
      observaciones: map['observaciones'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'ubicacion_id': ubicacionId,
      'enfermedad_id': enfermedadId,
      'severidad': severidad,
      'observaciones': observaciones,
    };
  }
}
