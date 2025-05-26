class Validators {
  static String? notEmpty(String? value) =>
      (value == null || value.isEmpty) ? 'Campo requerido' : null;

  static String? email(String? value) => (value == null || !value.contains('@'))
      ? 'Email inválido'
      : null;
}
