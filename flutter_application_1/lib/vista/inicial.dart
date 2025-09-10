import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../modelo/contacto.dart';
import 'package:flutter_application_1/bloc1/buscar_bloc.dart';
import '/bloc1/buscar_event.dart';
import '/bloc1/buscar_state.dart';

class Inicial extends StatefulWidget {
  @override
  _InicialState createState() => _InicialState();
}

class _InicialState extends State<Inicial> {
  List<Contact> contacts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadContactsFromJson();
  }

  Future<void> loadContactsFromJson() async {
    final String jsonString = await rootBundle.loadString('assets/contacts.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);

    final loadedContacts = jsonList.map((json) => Contact.fromJson(json)).toList();

    setState(() {
      contacts = loadedContacts;
      isLoading = false;
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
      create: (_) => SearchBloc(contacts),
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
              child: TextField(
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
                onChanged: (query) {
                  context.read<SearchBloc>().add(SearchTextChanged(query));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return Center(
                      child: Text(
                        'Escribe para buscar contactos',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
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
                            contact.name,
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
                            // Navegar al chat si quieres
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
                  }
                  return SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
