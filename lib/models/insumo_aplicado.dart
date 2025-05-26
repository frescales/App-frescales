class InsumoAplicado {
  final String id;
  final DateTime fecha;
  final String ubicacionId;
  final String aplicadorPerfilId;
  final String? observaciones;

  InsumoAplicado({
    required this.id,
    required this.fecha,
    required this.ubicacionId,
    required this.aplicadorPerfilId,
    this.observaciones,
  });

  factory InsumoAplicado.fromMap(Map<String, dynamic> map) {
    return InsumoAplicado(
      id: map['id'] as String,
      fecha: DateTime.parse(map['fecha']),
      ubicacionId: map['ubicacion_id'] as String,
      aplicadorPerfilId: map['aplicador_perfil_id'] as String,
      observaciones: map['observaciones'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'ubicacion_id': ubicacionId,
      'aplicador_perfil_id': aplicadorPerfilId,
      'observaciones': observaciones,
    };
  }
}
