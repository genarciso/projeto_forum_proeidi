import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';
import 'package:projeto_forum_proeidi/domain/duvida.dart';

class DuvidaPage extends StatefulWidget {
  @override
  _DuvidaPageState createState() => _DuvidaPageState();
}

removerDuvida(context, duvida) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          children: <Widget>[
            Column(
              children: [
                Icon(
                  Icons.report_gmailerrorred_outlined,
                  color: Colors.red,
                  size: 200,
                ),
                Text(
                  'Você tem certeza que deseja remover o tópico ' +
                      duvida.titulo +
                      '?',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(children: [
                      MaterialButton(
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.all(25),
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 10),
                      MaterialButton(
                        child: Text('Confirmar',
                            style: TextStyle(color: Colors.white)),
                        padding: EdgeInsets.all(25),
                        color: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () => Navigator.pop(context),
                      )
                    ]))
              ],
            )
          ],
        );
      });
}

class _DuvidaPageState extends State<DuvidaPage> {
  static String _displayStringForOption(Duvida option) => option.titulo;
  static List<Duvida> duvidas = <Duvida>[
    Duvida(0, 'Whatsapp',
        'whatsApp é um aplicativo multiplataforma de mensagens instantâneas e chamadas de voz para smartphones.'),
    Duvida(1, 'Youtube',
        'youTube é uma plataforma de compartilhamento de vídeos com sede em San Bruno, Califórnia.'),
    Duvida(2, 'Gmail',
        'O gmail (também Google Mail) é um serviço gratuito de webmail criado pela Google em 2004.'),
  ];
  static List<Duvida> _userOptions = duvidas;

  var _optionsBuilder = (TextEditingValue textEditingValue) {
    if (textEditingValue.text == '') {
      return const Iterable<Duvida>.empty();
    }
    return _userOptions.where((Duvida option) {
      return option.toString().contains(textEditingValue.text.toLowerCase());
    });
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuLateral(),
        appBar: MenuApp(),
        backgroundColor: Colors.cyan.shade100,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  MaterialButton(
                    onPressed: () { Navigator.of(context).pushReplacementNamed('/topico'); },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.orange.shade300,
                    child: Text('Tópico forum', style: TextStyle(
                        color: Colors.white
                    ),),
                  ),
                  Text(
                    ' > ',
                    style: TextStyle(fontSize: 16),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.orange.shade300,
                    child: Text('Dúvida', style: TextStyle(
                        color: Colors.white
                    ),),
                  ),
                ],
              ),
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
                              'Titulo Tópico',
                              style: TextStyle(fontSize: 36),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                              overflow: TextOverflow.clip,
                              maxLines: 4,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            )
                          ],
                        )))
              ]),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.green,
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(width: 5),
                          Text('Cadastrar Dúvida',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              )),
                        ],
                      ),
                      onPressed: () => Navigator.of(context).pushNamed('/duvida/form'),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.lightBlue[50],
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Container(
                                height: 50,
                                child: Autocomplete(
                                  displayStringForOption:
                                      _displayStringForOption,
                                  optionsBuilder: _optionsBuilder,
                                  onSelected: (Duvida selection) {
                                    print(
                                        'You just selected ${_displayStringForOption(selection)}');
                                  },
                                ),
                              ))
                            ],
                          )))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: duvidas.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.lightBlue[50]),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  '${duvidas[index].titulo}',
                                  style: TextStyle(fontSize: 22),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '${duvidas[index].texto}',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.clip,
                                  maxLines: 4,
                                )
                              ],
                            )),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  height: 25,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: MaterialButton(
                                      color: Colors.blue,
                                      onPressed: () => {
                                        Navigator.of(context).pushReplacementNamed('/resposta')
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.remove_red_eye),
                                          Text(
                                            'Visualizar',
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  height: 25,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: MaterialButton(
                                      color: Colors.yellow,
                                      onPressed: () => {},
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit),
                                          Text(
                                            'Editar',
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  height: 25,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: MaterialButton(
                                      color: Colors.red,
                                      onPressed: () => removerDuvida(
                                          context, duvidas[index]),
                                      child: Row(
                                        children: [
                                          Icon(Icons.remove_circle),
                                          Text(
                                            'Remover',
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      )),
                                ),
                                Container(
                                  height: 25,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: MaterialButton(
                                      color: Colors.orange,
                                      onPressed: () => {},
                                      child: Row(
                                        children: [
                                          Icon(Icons.report),
                                          Text(
                                            'Denunciar',
                                            style: TextStyle(fontSize: 14),
                                          )
                                        ],
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
