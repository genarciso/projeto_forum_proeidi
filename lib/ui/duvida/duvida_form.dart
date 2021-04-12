import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';

class DuvidaFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MenuApp(),
        backgroundColor: Colors.cyan.shade100,
        body: Container(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text('Cadastrar dúvida',
                        style: TextStyle(
                            fontSize: 30
                        )
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Título',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.lightBlue[50],
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.all(25)),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Descrição',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  TextField(
                    maxLines: 10,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.lightBlue[50],
                        filled: true,
                        isDense: true,
                        contentPadding: EdgeInsets.all(25)),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(children: [
                        MaterialButton(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                            ),
                          ),
                          padding: EdgeInsets.all(15),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () => Navigator.of(context).pushReplacementNamed('/duvida'),
                        ),
                        SizedBox(width: 10),
                        MaterialButton(
                          child: Text('Salvar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20
                              )
                          ),
                          padding: EdgeInsets.all(15),
                          color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () => Navigator.of(context).pushReplacementNamed('/duvida'),
                        )
                      ])
                  )
                ],
              ),
            )
        )
    );
  }
}
