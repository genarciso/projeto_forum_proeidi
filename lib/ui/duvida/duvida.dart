import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:projeto_forum_proeidi/domain/duvida.model.dart';
import 'package:projeto_forum_proeidi/domain/topico_forum.model.dart';
import 'package:projeto_forum_proeidi/repository/duvida.repository.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';

class DuvidaPage extends StatefulWidget {
  @override
  _DuvidaPageState createState() => _DuvidaPageState();
}

class _DuvidaPageState extends State<DuvidaPage> {
  DuvidaRepository _duvidaRepository;
  dynamic _usuarioSessao;

  static String _displayStringForOption(DuvidaModel option) => option.titulo;
  static List<DuvidaModel> duvidas = <DuvidaModel>[];
  static List<DuvidaModel> _userOptions = duvidas;

  @override
  void initState() {
    _duvidaRepository = DuvidaRepository();
    _carregarUsuarioSessao();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _optionsBuilder = (TextEditingValue textEditingValue) {
      if (textEditingValue.text == '') {
        return const Iterable<DuvidaModel>.empty();
      }
      return _userOptions.where((DuvidaModel option) {
        return option.toString().contains(new RegExp(
            textEditingValue.text.toLowerCase(),
            caseSensitive: false));
      });
    };
    TopicoForumModel topico = ModalRoute.of(context).settings.arguments;
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
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/topico');
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.orange.shade300,
                    child: Text(
                      'Tópico forum',
                      style: TextStyle(color: Colors.white),
                    ),
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
                    child: Text(
                      'Dúvida',
                      style: TextStyle(color: Colors.white),
                    ),
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
                              topico.nome,
                              style: TextStyle(fontSize: 36),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 10),
                            Text(
                              topico.descricao,
                              overflow: TextOverflow.clip,
                              maxLines: 4,
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            )
                          ],
                        )))
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                      onPressed: () => Navigator.of(context)
                          .pushNamed('/duvida/form', arguments: topico),
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
                                  onSelected: (DuvidaModel selection) {
                                    Navigator.of(context).pushReplacementNamed(
                                        '/resposta',
                                        arguments: [selection, topico]);
                                  },
                                ),
                              ))
                            ],
                          )))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: FutureBuilder(
                  future: _duvidaRepository.buscarTodos(topico.id),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if (snapshot.hasError)
                          return Container();
                        else
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _itemLista(snapshot.data[index], topico);
                              });
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget _itemLista(DuvidaModel duvida, TopicoForumModel topicoForumModel) {
    duvidas.add(duvida);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      height: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.cyan.shade50),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${duvida.titulo}',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${duvida.descricao}',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
                overflow: TextOverflow.clip,
                maxLines: 4,
              )
            ],
          )),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                height: 25,
                width: 120,
                child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () => {
                          Navigator.of(context).pushReplacementNamed(
                              '/resposta',
                              arguments: [duvida, topicoForumModel]),
                        },
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye),
                        SizedBox(
                          width: 2,
                        ),
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
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: MaterialButton(
                    color: Colors.yellow,
                    onPressed: () => {},
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(
                          width: 2,
                        ),
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
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: MaterialButton(
                    color: Colors.red,
                    onPressed: () => {this._removerDuvida(context, duvida)},
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline),
                        SizedBox(
                          width: 2,
                        ),
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
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: MaterialButton(
                    color: Colors.orange,
                    onPressed: () => {_denunciarDuvida(context, duvida)},
                    child: Row(
                      children: [
                        Icon(Icons.report_gmailerrorred_outlined),
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
  }

  void _removerDuvida(context, duvida) {
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
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(children: [
                        MaterialButton(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          padding: EdgeInsets.all(15),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(width: 10),
                        MaterialButton(
                          child: Text('Confirmar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          padding: EdgeInsets.all(15),
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

  void _denunciarDuvida(context, duvida) {
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
                    Icons.report_problem_outlined,
                    color: Colors.red,
                    size: 100,
                  ),
                  Text(
                    'Denunciar dúvida',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Você tem certeza que deseja denunciar essa dúvida? Diga-nos o motivo da sua denúncia',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Motivo:',
                        style: TextStyle(fontSize: 20),
                      )),
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
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          padding: EdgeInsets.all(15),
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(width: 10),
                        MaterialButton(
                          child: Text('Confirmar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                          padding: EdgeInsets.all(15),
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

  void _carregarUsuarioSessao() async {
    _usuarioSessao = await FlutterSession().get("usuario");
  }
}
