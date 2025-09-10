import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_bloc.dart';
import '../bloc/bloc_event.dart';
import '../bloc/bloc_state.dart'; 

class SimpleForm extends StatefulWidget {
  @override
  State<SimpleForm> createState() => _SimpleFormState();
}

class _SimpleFormState extends State<SimpleForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocBloc, BlocState>(
      listener: (context, state) {
        if (state is LoadingView) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(child: CircularProgressIndicator()),
          );
        } else if (state is Success) {
          Navigator.of(context).pop(); 
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Formulario enviado con éxito")),
          );
        } else if (state is ErrorView ) {
          Navigator.of(context).pop(); 
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.error}")),
          );
        }
      },
      child: Container(
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
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo electrónico'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final email = emailController.text.trim();

                context.read<BlocBloc>().add(
                      SubmitForm(name: name, email: email),
                    );
              },
              child: Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
