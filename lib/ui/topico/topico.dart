import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:projeto_forum_proeidi/domain/denuncia.model.dart';
import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';
import 'package:projeto_forum_proeidi/domain/topico_forum.model.dart';
import 'package:projeto_forum_proeidi/enum/TipoDenuncia.enum.dart';
import 'package:projeto_forum_proeidi/repository/denuncia.repository.dart';
import 'package:projeto_forum_proeidi/repository/topico.repository.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';

class TopicoPage extends StatefulWidget {
  @override
  _TopicoPageState createState() => _TopicoPageState();
}

class _TopicoPageState extends State<TopicoPage> {
  TopicoForumRepository _topicoForumRepository;
  DenunciaRepository _denunciaRepository;
  List<TopicoForumModel> listaTopicos;
  dynamic _usuarioSessao;
  GlobalKey<FormState> _formDenuncia = new GlobalKey();
  bool _validacaoFormDenuncia = false;
  String _descricaoDenuncia = "";

  static String _displayStringForOption(TopicoForumModel option) => option.nome;
  static List<TopicoForumModel> _userOptions;

  @override
  void initState() {
    _topicoForumRepository = TopicoForumRepository();
    _denunciaRepository = DenunciaRepository();
    _carregarUsuarioSessao();
    _carregarTopicos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _optionsBuilder = (TextEditingValue textEditingValue) {
      if (textEditingValue.text == '') {
        return const Iterable<TopicoForumModel>.empty();
      }
      return _userOptions.where((TopicoForumModel option) {
        return option.toString().contains(textEditingValue.text.toLowerCase());
      });
    };
    return Scaffold(
      drawer: MenuLateral(),
      appBar: MenuApp(),
      backgroundColor: Colors.cyan.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.orange.shade300,
                      child: Text(
                        'Tópico forum',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: MaterialButton(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.green,
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/topico/form')},
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                              size: 35,
                            ),
                            SizedBox(width: 5),
                            Text('Cadastrar Topico',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                )),
                          ],
                        ),
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
                                color: Colors.cyan.shade50,
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
                                    onSelected: (TopicoForumModel selection) {
                                      Navigator.of(context).pushNamed('/duvida',
                                          arguments: selection);
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
                    future: _carregarTopicos(),
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
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: _userOptions?.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return _itemLista(_userOptions[index]);
                                });
                      }
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget _itemLista(TopicoForumModel item) {
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
                item.nome,
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                item.descricao,
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
                          Navigator.of(context)
                              .pushNamed('/duvida', arguments: item)
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
              _botoesEditarRemover(item),
              Container(
                height: 25,
                width: 120,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: MaterialButton(
                    color: Colors.orange,
                    onPressed: () => {_denunciarTopico(context, item)},
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

  Widget _botoesEditarRemover(TopicoForumModel topico) {
    if (_usuarioSessao != null &&
        _usuarioSessao["id"] == topico.pessoaCadastro.id) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            height: 25,
            width: 120,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: MaterialButton(
                color: Colors.yellow,
                onPressed: () => Navigator.of(context)
                    .pushNamed("/topico/form", arguments: topico),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: MaterialButton(
                color: Colors.red,
                onPressed: () => {this._removerTopico(context, topico)},
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
          )
        ],
      );
    } else {
      return Container();
    }
  }

  void _removerTopico(context, TopicoForumModel topico) {
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
                        topico.nome +
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
                          onPressed: () => _removerItem(topico),
                        )
                      ]))
                ],
              )
            ],
          );
        });
  }

  void _removerItem(TopicoForumModel topicoForumModel) {
    try {
      _topicoForumRepository.deletar(topicoForumModel);
      setState(() {
        _carregarTopicos().then(
            (value) => Navigator.of(context).pushReplacementNamed("/topico"));
      });
    } catch (err) {
      print("Deu ruim | $err");
    }
  }

  void _denunciarTopico(context, TopicoForumModel topico) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            children: <Widget>[
              Form(
                key: _formDenuncia,
                autovalidateMode: _validacaoFormDenuncia
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    Icon(
                      Icons.report_problem_outlined,
                      color: Colors.red,
                      size: 100,
                    ),
                    Text(
                      'Denunciar tópico',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Você tem certeza que deseja denunciar esse tópico? Diga-nos o motivo da sua denúncia',
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
                    TextFormField(
                      maxLines: 10,
                      validator: (value) {
                        if (value.length == 0) {
                          return "Campo Obrigatório";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.lightBlue[50],
                          filled: true,
                          isDense: true,
                          contentPadding: EdgeInsets.all(25)),
                      onSaved: (text) {
                        _descricaoDenuncia = text;
                      },
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(children: [
                          MaterialButton(
                            child: Text(
                              'Cancelar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                                    color: Colors.white, fontSize: 18)),
                            padding: EdgeInsets.all(15),
                            color: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () => _enviarDenuncia(context, topico),
                          )
                        ]))
                  ],
                ),
              )
            ],
          );
        });
  }

  void _enviarDenuncia(context, TopicoForumModel topico) async {
    if (_formDenuncia.currentState.validate()) {
      _formDenuncia.currentState.save();

      DenunciaModel denuncia = DenunciaModel(
          descricao: _descricaoDenuncia,
          pessoaCadastro:
              TipoDTO(id: _usuarioSessao["id"], nome: _usuarioSessao["nome"]),
          idTipo: topico.id,
          tipoDenuncia: TipoDenuncia.TOPICO_FORUM);

      try {
        var response = await _denunciaRepository.denunciar(denuncia);
        if (response.statusCode == 200) {
          setState(() {
            _carregarTopicos()
                .then((value) =>
                    Navigator.of(context).pushReplacementNamed("/topico"))
                .onError((error, stackTrace) => print(error));
          });
        } else if (response.statusCode == 409) {
          Navigator.of(context).pushReplacementNamed("/topico");
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text("Erro"),
                  content: Text("Você ja realizou uma denuncia"),
                  actions: <Widget>[
                    TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ]);
            },
          );
        } else {
          Navigator.of(context).pushReplacementNamed("/topico");
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text("Erro"),
                  content: Text(
                      "Ocorreu algum problema com o servidor. Tente novamente!"),
                  actions: <Widget>[
                    TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ]);
            },
          );
        }
      } catch (err) {
        print("Deu ruim | $err");
      }
    }
  }

  void _carregarUsuarioSessao() async {
    _usuarioSessao = await FlutterSession().get("usuario");
  }

  Future<List<TopicoForumModel>> _carregarTopicos() async {
    listaTopicos = await _topicoForumRepository.buscarTodos();
    _userOptions = listaTopicos;
    return listaTopicos;
  }
}
