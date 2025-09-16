import 'package:flutter_bloc/flutter_bloc.dart';
import '../modelo/contacto.dart';
import 'buscar_event.dart';
import 'buscar_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<Contacto> contacts;

  SearchBloc(this.contacts) : super(SearchInitial()) {
    on<SearchTextChanged>((event, emit) async {
      final query = event.query.trim();

      if (query.isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());

      await Future.delayed(const Duration(milliseconds: 500));

      final results = contacts.where((contact) {
        final name = contact.nombre.toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();

      if (results.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(results));
      }
    });
  }
}
