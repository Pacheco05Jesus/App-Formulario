class Contact {
  final String name;
  final String lastMessage;
  final String avatarUrl;
  final String lastMessageTime;

  Contact({
    required this.name,
    required this.lastMessage,
    required this.avatarUrl,
    required this.lastMessageTime,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      lastMessage: json['lastMessage'],
      avatarUrl: json['avatarUrl'],
      lastMessageTime: json['lastMessageTime'],
    );
  }
}
