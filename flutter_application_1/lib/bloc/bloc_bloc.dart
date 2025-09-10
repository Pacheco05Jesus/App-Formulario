import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormInitial()) {
    on<SubmitForm>((event, emit) async {
      emit(FormSubmitting());

      await Future.delayed(Duration(seconds: 2));

      if (event.email.contains("@")) {
        emit(FormSuccess());
      } else {
        emit(FormFailure("El correo es inválido"));
      }
    });
  }
}
