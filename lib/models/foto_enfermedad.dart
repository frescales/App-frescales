class FotoEnfermedad {
  final String id;
  final String enfermedadDetectadaId;
  final String fotoUrl;

  FotoEnfermedad({
    required this.id,
    required this.enfermedadDetectadaId,
    required this.fotoUrl,
  });

  factory FotoEnfermedad.fromMap(Map<String, dynamic> map) {
    return FotoEnfermedad(
      id: map['id'] as String,
      enfermedadDetectadaId: map['enfermedad_detectada_id'] as String,
      fotoUrl: map['foto_url'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'enfermedad_detectada_id': enfermedadDetectadaId,
      'foto_url': fotoUrl,
    };
  }
}
