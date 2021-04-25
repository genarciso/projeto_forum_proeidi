import 'package:flutter/material.dart';
import 'package:projeto_forum_proeidi/ui/duvida/duvida.dart';
import 'package:projeto_forum_proeidi/ui/duvida/duvida_form.dart';
import 'package:projeto_forum_proeidi/ui/login/login.dart';
import 'package:projeto_forum_proeidi/ui/resposta/resposta.dart';
import 'package:projeto_forum_proeidi/ui/resposta/resposta_form.dart';
import 'package:projeto_forum_proeidi/ui/topico/topico.dart';
import 'package:projeto_forum_proeidi/ui/topico/topico_form.dart';

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
        '/topico/form': (context) => TopicoFormPage(),
        '/duvida': (context) => DuvidaPage(),
        '/duvida/form': (context) => DuvidaFormPage(),
        '/resposta': (context) => RespostaPage(),
        '/resposta/form': (context) => RespostaFormPage()
      },
    );
  }
}
