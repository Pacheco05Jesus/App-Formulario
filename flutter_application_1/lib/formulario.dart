import 'package:flutter/material.dart';

class SimpleForm extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            style: TextStyle(color: const Color.fromARGB(255, 236, 15, 15)),
            decoration: InputDecoration(
              labelText: 'Nombre',
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: emailController,
            style: TextStyle(color: const Color.fromARGB(255, 228, 19, 19)),
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Acción vacía
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.tealAccent[400],
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
