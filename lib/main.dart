import 'package:flutter/material.dart';
import 'package:projeto_forum_proeidi/ui/login/login.dart';
import 'package:projeto_forum_proeidi/ui/topico/topico.dart';
import 'package:projeto_forum_proeidi/ui/duvida/duvida.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum ProEIDI',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/topico': (context) => TopicoPage(),
        '/duvida': (context) => DuvidaPage(),
      },
    );
  }
}
