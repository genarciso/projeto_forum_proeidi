import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';

class DuvidaPage extends StatefulWidget {
  @override
  _DuvidaPageState createState() => _DuvidaPageState();
}

class _DuvidaPageState extends State<DuvidaPage> {
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
