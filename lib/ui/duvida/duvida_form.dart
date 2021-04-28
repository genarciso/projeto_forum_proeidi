import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_forum_proeidi/domain/topico_forum.model.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';
import 'package:projeto_forum_proeidi/domain/duvida.model.dart';
import 'package:projeto_forum_proeidi/repository/duvida.repository.dart';

class DuvidaFormPage extends StatelessWidget {
  DuvidaRepository _duvidaRepository;
  dynamic _usuarioSessao;
  GlobalKey<FormState> _form = new GlobalKey();
  bool _validacao = false;
  DuvidaModel _duvidaForm;

  DuvidaFormPage() {
    _carregarUsuarioSessao();
    _duvidaForm = DuvidaModel();
  }

  @override
  Widget build(BuildContext context) {
    TopicoForumModel topico = ModalRoute.of(context).settings.arguments;
    _duvidaRepository = DuvidaRepository();
    return Scaffold(
        appBar: MenuApp(),
        backgroundColor: Colors.cyan.shade100,
        body: SingleChildScrollView(
            child: Form(
                key: _form,
                autovalidateMode: _validacao
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text('Cadastrar dúvida',
                            style: TextStyle(fontSize: 30)),
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
                          initialValue: _duvidaForm.titulo,
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
                            _duvidaForm.titulo = text;
                          }),
                      SizedBox(height: 15),
                      Text(
                        'Descrição',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        initialValue: _duvidaForm.descricao,
                        validator: (value) {
                          if (value.length == 0) {
                            return "Campo Obrigatório";
                          } else {
                            return null;
                          }
                        },
                        maxLines: 10,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.lightBlue[50],
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.all(25)),
                        onSaved: (text) {
                          _duvidaForm.descricao = text;
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
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  padding: EdgeInsets.all(15),
                                  color: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacementNamed('/duvida',
                                          arguments: topico),
                                ),
                                SizedBox(width: 10),
                                MaterialButton(
                                  child: Text('Salvar',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                  padding: EdgeInsets.all(15),
                                  color: Colors.lightGreen,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  onPressed: () => _enviarForm(context, topico),
                                )
                              ]))
                    ],
                  ),
                ))) //
        );
  }

  void _carregarUsuarioSessao() async {
    _usuarioSessao = await FlutterSession().get("usuario");
  }

  void _enviarForm(context, topico) {
    if (_form.currentState.validate()) {
      _form.currentState.save();

      _duvidaForm.pessoaCadastro =
          TipoDTO(id: _usuarioSessao["id"], nome: _usuarioSessao["nome"]);
      _duvidaForm.tags = [];

      try {
        _duvidaRepository.salvar(_duvidaForm);
        Navigator.of(context)
            .pushReplacementNamed('/duvida', arguments: topico);
      } catch (err) {
        print("Deu ruim | $err");
      }
    }
  }
}
