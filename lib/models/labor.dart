class Labor {
  final String id;
  final DateTime fecha;
  final String tipoLaborId;
  final String ubicacionId;
  final String perfilId;
  final String? observaciones;

  Labor({
    required this.id,
    required this.fecha,
    required this.tipoLaborId,
    required this.ubicacionId,
    required this.perfilId,
    this.observaciones,
  });

  factory Labor.fromMap(Map<String, dynamic> map) {
    return Labor(
      id: map['id'] as String,
      fecha: DateTime.parse(map['fecha']),
      tipoLaborId: map['tipo_labor_id'] as String,
      ubicacionId: map['ubicacion_id'] as String,
      perfilId: map['perfil_id'] as String,
      observaciones: map['observaciones'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'tipo_labor_id': tipoLaborId,
      'ubicacion_id': ubicacionId,
      'perfil_id': perfilId,
      'observaciones': observaciones,
    };
  }
}
