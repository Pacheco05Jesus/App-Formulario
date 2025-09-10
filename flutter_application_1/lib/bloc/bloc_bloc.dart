import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(Initial()) {
    on<SubmitForm>(_onSubmitForm);
    on<RetrySubmit>(_onRetrySubmit);
  }

  Future<void> _onSubmitForm(SubmitForm event, Emitter<BlocState> emit) async {
    emit(LoadingView());

    await Future.delayed(Duration(seconds: 2));

    final isValid = event.name.isNotEmpty && event.email.isNotEmpty;

    if (isValid) {
      emit(Success());
    } else {
      emit(ErrorView("Campos incompletos o inválidos"));
    }
  }

  void _onRetrySubmit(RetrySubmit event, Emitter<BlocState> emit) {
    emit(Initial());
  }
}
