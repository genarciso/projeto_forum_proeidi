import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';

class TopicoPage extends StatefulWidget {
  @override
  _TopicoPageState createState() => _TopicoPageState();
}

class _TopicoPageState extends State<TopicoPage> {
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
