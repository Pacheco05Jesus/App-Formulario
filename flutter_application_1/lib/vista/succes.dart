  import 'package:flutter/material.dart';

class SuccessView extends StatelessWidget {
  final String message;

  const SuccessView({Key? key, this.message = "¡Operación exitosa!"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.tealAccent[400], size: 100),
            SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(
                color: Colors.tealAccent[400],
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 135, 213, 252),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cerrar', style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }
}
