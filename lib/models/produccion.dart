class Produccion {
  final String id;
  final DateTime fecha;
  final String ubicacionId;
  final String productoId;
  final double cantidad;
  final String unidadId;
  final String? observaciones;
  final double? latitud;
  final double? longitud;

  Produccion({
    required this.id,
    required this.fecha,
    required this.ubicacionId,
    required this.productoId,
    required this.cantidad,
    required this.unidadId,
    this.observaciones,
    this.latitud,
    this.longitud,
  });

  factory Produccion.fromMap(Map<String, dynamic> map) {
    return Produccion(
      id: map['id'] as String,
      fecha: DateTime.parse(map['fecha']),
      ubicacionId: map['ubicacion_id'] as String,
      productoId: map['producto_id'] as String,
      cantidad: (map['cantidad'] as num).toDouble(),
      unidadId: map['unidad_id'] as String,
      observaciones: map['observaciones'] as String?,
      latitud: (map['latitud'] as num?)?.toDouble(),
      longitud: (map['longitud'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'ubicacion_id': ubicacionId,
      'producto_id': productoId,
      'cantidad': cantidad,
      'unidad_id': unidadId,
      'observaciones': observaciones,
      'latitud': latitud,
      'longitud': longitud,
    };
  }
}
