class ActividadPlanificada {
  final String id;
  final DateTime fechaProgramada;
  final String descripcion;
  final String tipoActividadId;
  final String perfilAsignadoId;
  final String estado;

  ActividadPlanificada({
    required this.id,
    required this.fechaProgramada,
    required this.descripcion,
    required this.tipoActividadId,
    required this.perfilAsignadoId,
    required this.estado,
  });

  factory ActividadPlanificada.fromMap(Map<String, dynamic> map) {
    return ActividadPlanificada(
      id: map['id'] as String,
      fechaProgramada: DateTime.parse(map['fecha_programada']),
      descripcion: map['descripcion'] as String,
      tipoActividadId: map['tipo_actividad_id'] as String,
      perfilAsignadoId: map['perfil_asignado_id'] as String,
      estado: map['estado'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha_programada': fechaProgramada.toIso8601String(),
      'descripcion': descripcion,
      'tipo_actividad_id': tipoActividadId,
      'perfil_asignado_id': perfilAsignadoId,
      'estado': estado,
    };
  }
}
