import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'vista/cargar.dart'; 
import 'vista/error.dart';  
import 'vista/inicial.dart'; 
import 'bloc/bloc_bloc.dart';
import 'bloc/bloc_event.dart';
import 'bloc/bloc_state.dart' as bloc_state;
import 'formulario.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario con BLoC',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => BlocBloc(),
        child: FormScreen(),
      ),
    );
  }
}

class FormScreen extends StatefulWidget {
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool _isDialogShowing = false;

  void _showLoadingDialog() {
    if (!_isDialogShowing) {
      _isDialogShowing = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => LoadingView(),
      );
    }
  }

  void _hideLoadingDialog() {
    if (_isDialogShowing) {
      _isDialogShowing = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text('Formulario con BLoC'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: BlocListener<BlocBloc, bloc_state.BlocState>(
        listener: (context, state) {
          if (state is bloc_state.LoadingView) {
            _showLoadingDialog();
          } else {
            _hideLoadingDialog();
          }

          if (state is bloc_state.Success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Formulario enviado correctamente!')),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => initial()),
            );
          } else if (state is bloc_state.ErrorView ) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        child: BlocBuilder<BlocBloc, bloc_state.BlocState>(
          builder: (context, state) {
            if (state is bloc_state.ErrorView ) {
              return Center(
                child: ErrorView(
                  errorMessage: state.error,
                  onRetry: () {
                    context.read<BlocBloc>().add(RetrySubmit());
                  },
                ),
              );
            }

            // Para otros estados (incluye FormInitial y FormSuccess)
            return Center(child: SimpleForm());
          },
        ),
      ),
    );
  }
}
