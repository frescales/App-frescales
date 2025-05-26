class DetalleInsumo {
  final String id;
  final String insumoAplicadoId;
  final String insumoId;
  final double cantidad;
  final String unidadId;

  DetalleInsumo({
    required this.id,
    required this.insumoAplicadoId,
    required this.insumoId,
    required this.cantidad,
    required this.unidadId,
  });

  factory DetalleInsumo.fromMap(Map<String, dynamic> map) {
    return DetalleInsumo(
      id: map['id'] as String,
      insumoAplicadoId: map['insumo_aplicado_id'] as String,
      insumoId: map['insumo_id'] as String,
      cantidad: (map['cantidad'] as num).toDouble(),
      unidadId: map['unidad_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'insumo_aplicado_id': insumoAplicadoId,
      'insumo_id': insumoId,
      'cantidad': cantidad,
      'unidad_id': unidadId,
    };
  }
}
