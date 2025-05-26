class Enfermedad {
  final String id;
  final String nombre;
  final String? descripcion;

  Enfermedad({
    required this.id,
    required this.nombre,
    this.descripcion,
  });

  factory Enfermedad.fromMap(Map<String, dynamic> map) {
    return Enfermedad(
      id: map['id'] as String,
      nombre: map['nombre'] as String,
      descripcion: map['descripcion'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}
