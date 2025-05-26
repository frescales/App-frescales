class Producto {
  final String id;
  final String nombre;
  final String? descripcion;

  Producto({
    required this.id,
    required this.nombre,
    this.descripcion,
  });

  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
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
