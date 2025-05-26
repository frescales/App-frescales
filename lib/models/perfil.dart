class Perfil {
  final String id;
  final String userId;
  final String nombre;
  final String rol;
  final String? telefono;

  Perfil({
    required this.id,
    required this.userId,
    required this.nombre,
    required this.rol,
    this.telefono,
  });

  factory Perfil.fromMap(Map<String, dynamic> map) {
    return Perfil(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      nombre: map['nombre'] as String,
      rol: map['rol'] as String,
      telefono: map['telefono'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'nombre': nombre,
      'rol': rol,
      'telefono': telefono,
    };
  }
}
