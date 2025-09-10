import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(Initial()) {
    on<SubmitForm>((event, emit) async {
      emit(LoadingView());

      try {
        await Future.delayed(Duration(seconds: 2));
        emit(Success());
      } catch (e) {
        emit(ErrorView(e.toString()));
      }
    });

    on<RetrySubmit>((event, emit) {
      emit(Initial());
    });
  }
}
