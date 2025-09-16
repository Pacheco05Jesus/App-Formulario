class Contacto {
  final int id;
  final String nombre;
  final String email;
  final String avatarUrl;
  final String lastMessage;
  final String lastMessageTime;

  Contacto({
    required this.id,
    required this.nombre,
    required this.email,
    required this.avatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  factory Contacto.fromJson(Map<String, dynamic> json) {
    return Contacto(
      id: json['id'],
      nombre: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'] ?? '', 
      lastMessage: json['lastMessage'] ?? '',
      lastMessageTime: json['lastMessageTime'] ?? '',
    );
  }
}
