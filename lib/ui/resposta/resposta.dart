import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:projeto_forum_proeidi/domain/duvida.model.dart';
import 'package:projeto_forum_proeidi/domain/resposta.model.dart';
import 'package:projeto_forum_proeidi/domain/topico_forum.model.dart';
import 'package:projeto_forum_proeidi/repository/resposta.repository.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';

class RespostaPage extends StatefulWidget {
  @override
  _RespostaPageState createState() => _RespostaPageState();
}

class _RespostaPageState extends State<RespostaPage> {
  RespostaRepository _respostaRepository;
  dynamic _usuarioSessao;
  List<RespostaModel> listaResposta;
  GlobalKey<FormState> _formDenuncia = new GlobalKey();
  bool _validacaoFormDenuncia = false;
  String _descricaoDenuncia = "";

  static List<RespostaModel> _userOptions;

  @override
  void initState() {
    _respostaRepository = RespostaRepository();
    _carregarUsuarioSessao();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List itens = ModalRoute.of(context).settings.arguments;
    DuvidaModel duvida = itens[0];
    TopicoForumModel topico = itens[1];

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
                  onPressed: () { Navigator.of(context).pushReplacementNamed('/duvida',
                      arguments: topico );},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.orange.shade300,
                  child: Text('Dúvida', style: TextStyle(
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
                  child: Text('Respostas',
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
                            duvida.titulo,
                            style: TextStyle(fontSize: 36),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 10),
                          Text(
                            duvida.descricao,
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
                        Text('Cadastrar Resposta',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            )),
                      ],
                    ),
                    onPressed: () => Navigator.of(context).pushReplacementNamed (
                        "/resposta/form",
                        arguments: [duvida, topico]
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: FutureBuilder(
                  future: _respostaRepository.buscarTodos(duvida.id),
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
                              itemCount: _userOptions?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _itemLista(_userOptions[index], _userOptions[index].duvida);
                              });
                    }
                  },
                ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemLista(RespostaModel resposta, DuvidaModel duvidaModel) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _color(resposta, duvidaModel)) ,
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleMelhorResposta(resposta, duvidaModel),
                  SizedBox(height: 4,),
                  Text(
                    '${resposta.resposta}',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.clip,
                    maxLines: 4,
                  )
                ],
              )),
          SizedBox(width: 10,),
          Column(
            children: [
              Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            height: 25,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            child: MaterialButton(
                                color: Colors.green,
                                onPressed: () => {},
                                child: Row(
                                  children: [
                                    Icon(Icons.thumb_up_alt_outlined),
                                    SizedBox(width: 5,),
                                    Text(
                                      '${resposta.likes}',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            height: 25,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            child: MaterialButton(
                                color: Colors.red,
                                onPressed: () => {},
                                child: Row(
                                  children: [
                                    Icon(Icons.thumb_down_alt_outlined ),
                                    SizedBox(width: 5,),
                                    Text(
                                      '${resposta.dislikes}',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                )),
                          )
                        ],
                      )
                    ],
                  )
              ),
              _buttonMelhorResposta(resposta, duvidaModel),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                height: 25,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25)),
                child: MaterialButton(
                    color: Colors.yellow,
                    onPressed: () => Navigator.of(context)
                        .pushNamed("/resposta/form", arguments: resposta),
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 2,),
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
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25)),
                child: MaterialButton(
                    color: Colors.red,
                    onPressed: () => { this._removerResposta(context, resposta)},

                    child: Row(
                      children: [
                        Icon(Icons.delete_outline),
                        SizedBox(width: 2,),
                        Text(
                          'Remover',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    )),
              ),
              Container(
                height: 25,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25)),
                child: MaterialButton(
                    color: Colors.orange,
                    onPressed: () => {_denunciarResposta(context, resposta)},
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

  Color _color(RespostaModel resposta, DuvidaModel duvida) {
    if(duvida.respostaCorreta != null && resposta.id == duvida.respostaCorreta.id) {
      return Colors.green.shade200;
    }

    return Colors.cyan.shade50;
  }

  Widget _titleMelhorResposta(RespostaModel resposta, DuvidaModel duvida) {
    if(duvida.respostaCorreta != null && resposta.id == duvida.respostaCorreta.id) {
      return Text('Melhor resposta',style: TextStyle(fontSize: 22),);
    }
    return SizedBox(height: 1,);
  }

  Widget _buttonMelhorResposta(RespostaModel resposta, DuvidaModel duvida) {
    if(duvida.respostaCorreta == null || !(resposta.id == duvida.respostaCorreta.id)) {
      return Container(
        margin: EdgeInsets.only(bottom: 5),
        height: 25,
        width: 140,
        child: MaterialButton(
            color: Colors.green,
            onPressed: () => {},
            child: Row(
              children: [
                Icon(Icons.check_circle_outline),
                SizedBox(width: 2,),
                Text(
                  'Melhor',
                  style: TextStyle(fontSize: 14),
                )
              ],
            )),
      );
    }
    return SizedBox(height: 1,);
  }

  void _removerResposta(context, RespostaModel resposta) {
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
                    'Você tem certeza que deseja remover a resposta?',
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
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                            ),
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              )
                          ),
                          padding: EdgeInsets.all(15),
                          color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () => _removerItem(resposta),
                        )
                      ])
                  )
                ],
              )
            ],
          );
        }
    );
  }

  void _removerItem(RespostaModel respostaModel) {
    try {
      _respostaRepository.deletar(respostaModel);
      setState(() {
        _carregarRespostas().then(
                (value) => Navigator.of(context).pushReplacementNamed("/resposta"));
      });
    } catch (err) {
      print("Deu ruim | $err");
    }
  }

  void _denunciarResposta(context, resposta) {
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
                    'Denunciar resposta',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Você tem certeza que deseja denunciar essa resposta? Diga-nos o motivo da sua denúncia',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Motivo:',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      )
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
                                fontSize: 18
                            ),
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                              )
                          ),
                          padding: EdgeInsets.all(15),
                          color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () => Navigator.pop(context),
                        )
                      ])
                  )
                ],
              )
            ],
          );
        }
    );
  }

  void _carregarUsuarioSessao () async {
    _usuarioSessao = await FlutterSession().get("usuario");
  }

  Future<List<RespostaModel>> _carregarRespostas() async {
    listaResposta = await _respostaRepository.buscarTodos();
    _userOptions = listaResposta;
    return listaResposta;
  }
}