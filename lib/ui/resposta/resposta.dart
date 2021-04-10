import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';

class RespostaPage extends StatefulWidget {
  @override
  _RespostaPageState createState() => _RespostaPageState();
}

class _RespostaPageState extends State<RespostaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: MenuApp(),
      backgroundColor: Colors.cyan.shade100,
      body: Column(),
    );
  }
}
