import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';
import 'package:projeto_forum_proeidi/domain/topico_forum.model.dart';
import 'package:projeto_forum_proeidi/repository/topico.repository.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';

class TopicoFormPage extends StatelessWidget {
  TopicoForumRepository _topicoForumRepository;
  dynamic _usuarioSessao;
  GlobalKey<FormState> _form  = new GlobalKey();
  bool _validacao = false;
  TopicoForumModel _topicoForumForm;


  TopicoFormPage([TopicoForumModel topicoForumModel]) {
    _carregarUsuarioSessao();
    _topicoForumForm = TopicoForumModel();

  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments !=  null) {
      _topicoForumForm = ModalRoute.of(context).settings.arguments;
    }
    _topicoForumRepository = TopicoForumRepository();
    return Scaffold(
        appBar: MenuApp(),
        backgroundColor: Colors.cyan.shade100,
        body: SingleChildScrollView(
          child: Form(
            key: _form,
            autovalidateMode: _validacao ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text('Cadastrar tópico',
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
                      TextFormField(
                        initialValue: _topicoForumForm.nome,
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
                          _topicoForumForm.nome = text;
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Descrição',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        maxLines: 10,
                        initialValue: _topicoForumForm.descricao,
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
                          _topicoForumForm.descricao = text;
                        },
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
                                  onPressed: () => Navigator.of(context).pushReplacementNamed('/topico'),
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
                                  onPressed: () => _enviarForm(context),
                                )
                              ])
                      )
                    ],
                  ),
                )
            ),
          ),
        )
    );
  }

  void _carregarUsuarioSessao () async {
    _usuarioSessao = await FlutterSession().get("usuario");
  }

  void _enviarForm(context) {
    if (_form.currentState.validate()) {
      _form.currentState.save();

      _topicoForumForm.pessoaCadastro = TipoDTO(id: _usuarioSessao["id"], nome: _usuarioSessao["nome"]);
      _topicoForumForm.tags = [];

      try {
        _topicoForumRepository.salvar(_topicoForumForm);
        Navigator.of(context).pushReplacementNamed('/topico');
      } catch (err) {
        print("Deu ruim | $err");
      }
    }
  }
}
