import 'package:flutter/material.dart';
import 'package:flutter_application_1/modelo/contacto.dart';

class SuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChatListScreen();
  }
}

class ChatListScreen extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(
      name: 'Ana Gómez',
      lastMessage: '¿Nos vemos mañana?',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      lastMessageTime: '10:30 AM',
    ),
    Contact(
      name: 'Carlos López',
      lastMessage: 'Te mando los archivos.',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      lastMessageTime: '9:15 AM',
    ),
    Contact(
      name: 'María Pérez',
      lastMessage: '¡Feliz cumpleaños!',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      lastMessageTime: 'Ayer',
    ),
    Contact(
      name: 'Juan Torres',
      lastMessage: '¿Dónde estás?',
      avatarUrl: 'https://i.pravatar.cc/150?img=4',
      lastMessageTime: 'Lunes',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: ListView.separated(
        itemCount: contacts.length,
        separatorBuilder: (_, __) => Divider(color: Colors.white24),
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(contact.avatarUrl),
            ),
            title: Text(
              contact.name,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              contact.lastMessage,
              style: TextStyle(color: Colors.white70),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              contact.lastMessageTime,
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(contact: contact),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.blueGrey[900],
    );
  }
}

class ChatScreen extends StatefulWidget {
  final Contact contact;

  ChatScreen({required this.contact});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> messages = [
    "Hola, ¿cómo estás?",
    "Bien, gracias. ¿Y tú?",
    "Muy bien, gracias por preguntar.",
  ];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final contact = widget.contact;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(contact.avatarUrl),
            ),
            SizedBox(width: 12),
            Text(contact.name),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (_, index) {
                final msg = messages[index];
                bool isMe = index % 2 == 0; // Simula mensajes alternados

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.tealAccent[400]
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      msg,
                      style: TextStyle(
                        color: isMe ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.blueGrey[800],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.blueGrey[700],
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.tealAccent[400]),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
