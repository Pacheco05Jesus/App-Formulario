class Contacto {
  final String nombre;


  Contacto({
    required this.nombre,

  });

  factory Contacto.fromJson(Map<String, dynamic> json) {
    return Contacto(
      nombre: json['name'],
    );
  }
}
