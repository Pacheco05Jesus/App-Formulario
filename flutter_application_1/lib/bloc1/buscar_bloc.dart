import 'package:flutter_bloc/flutter_bloc.dart';
import 'buscar_event.dart';
import 'buscar_state.dart';
import '../modelo/contacto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchTextChanged>((event, emit) async {
      final query = event.query.trim();

      if (query.isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());

      try {
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);

          final results = data.where((user) {
            final name = user['name']?.toString().toLowerCase() ?? '';
            return name.contains(query.toLowerCase());
          }).map((json) => Contact.fromJson(json)).toList();

          if (results.isEmpty) {
            emit(SearchEmpty());
          } else {
            emit(SearchLoaded(results));
          }
        } else {
          emit(SearchError('Error al cargar datos'));
        }
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }
}
