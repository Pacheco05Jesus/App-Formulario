import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../modelo/contacto.dart';
import '/bloc1/buscar_bloc.dart';
import '/bloc1/buscar_event.dart';
import '/bloc1/buscar_state.dart';

class Inicial extends StatefulWidget {
  @override
  _InicialState createState() => _InicialState();
}
class _InicialState extends State<Inicial> {
  List<Contacto> contacts = [];
  bool isLoading = true;
  late SearchBloc _searchBloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadContactsFromJson();
  }

  Future<void> loadContactsFromJson() async {
    final String jsonString = await rootBundle.loadString('assets/contacts.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);

    final loadedContacts = jsonList.map((json) => Contacto.fromJson(json)).toList();

    setState(() {
      contacts = loadedContacts;
      isLoading = false;
      _searchBloc = SearchBloc(contacts);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return BlocProvider(
      create: (_) => _searchBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
          backgroundColor: const Color.fromARGB(255, 207, 223, 231),
        ),
        backgroundColor: Colors.blueGrey[900],
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Buscar contactos...',
                        hintStyle: TextStyle(color: Colors.white54),
                        prefixIcon: Icon(Icons.search, color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                      ),
                     
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final query = _searchController.text.trim();
                      _searchBloc.add(SearchTextChanged(query));
                    },
                    child: Text('Buscar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return Center(
                      child: Text(
                        'Escribe y presiona "Buscar" para buscar contactos',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (state is SearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is SearchLoaded) {
                    return ListView.separated(
                      itemCount: state.results.length,
                      separatorBuilder: (_, __) => Divider(color: Colors.white24),
                      itemBuilder: (context, index) {
                        final contact = state.results[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(contact.avatarUrl),
                          ),
                          title: Text(
                            contact.nombre,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            contact.lastMessage,
                            style: TextStyle(color: Colors.white70),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            contact.lastMessageTime,
                            style: TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                          onTap: () {
                            
                          },
                        );
                      },
                    );
                  } else if (state is SearchEmpty) {
                    return Center(
                      child: Text(
                        'No se encontraron contactos',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    );
                  } else if (state is SearchError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
