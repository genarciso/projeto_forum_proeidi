import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_forum_proeidi/domain/duvida.model.dart';
import 'package:projeto_forum_proeidi/ui/resposta/resposta.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';

class RespostaFormPage extends StatelessWidget {
  final Duvida duvida;

  RespostaFormPage({Key key, @required this.duvida}) : super(key: key);

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
                  Row(children: [
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.lightBlue[50]),
                            margin: EdgeInsets.only(top: 30),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  duvida.titulo,
                                  style: TextStyle(fontSize: 36),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  duvida.texto,
                                  overflow: TextOverflow.clip,
                                  maxLines: 4,
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.justify,
                                )
                              ],
                            )))
                  ]),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: Text('Cadastrar resposta',
                        style: TextStyle(
                            fontSize: 30
                        )
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Resposta',
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
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RespostaPage(duvida: duvida)
                                  )
                              ),
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
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RespostaPage(duvida: duvida)
                                  )
                              ),
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
