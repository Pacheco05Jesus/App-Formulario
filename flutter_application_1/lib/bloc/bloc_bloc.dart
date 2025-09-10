import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_event.dart';
import 'bloc_state.dart' as bloc_state;

class BlocBloc extends Bloc<BlocEvent, bloc_state.BlocState> {
  BlocBloc() : super(bloc_state.Initial()) {
    on<SubmitForm>((event, emit) async {
      emit(bloc_state.LoadingView());

      try {

        await Future.delayed(Duration(seconds: 2));

        emit(bloc_state.Success());
      } catch (e) {
        emit(bloc_state.ErrorView(e.toString()));
      }
    });

    on<RetrySubmit>((event, emit) {
      emit(bloc_state.Initial());
    });
  }
}
