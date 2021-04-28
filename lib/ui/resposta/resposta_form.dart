import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:projeto_forum_proeidi/domain/duvida.model.dart';
import 'package:projeto_forum_proeidi/domain/resposta.model.dart';
import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';
import 'package:projeto_forum_proeidi/domain/topico_forum.model.dart';
import 'package:projeto_forum_proeidi/repository/resposta.repository.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';


class RespostaFormPage extends StatelessWidget {
  RespostaRepository _respostaRepository;
  dynamic _usuarioSessao;
  GlobalKey<FormState> _formResposta = new GlobalKey();
  bool _validacao = false;
  RespostaModel _respostaForm;

  TopicoFormPage() {
    _carregarUsuarioSessao();
    _respostaForm = RespostaModel();
  }

  DuvidaModel duvida;
  TopicoForumModel topico;

  @override
  Widget build(BuildContext context) {
    final List itens = ModalRoute.of(context).settings.arguments;
    duvida = itens[0];
    topico = itens[1];
    return Scaffold(
        appBar: MenuApp(),
        backgroundColor: Colors.cyan.shade100,
        body: SingleChildScrollView(
            child: Form(
              key: _formResposta,
              autovalidateMode: _validacao
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
                child: Container(
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
                                          duvida.descricao,
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
                          TextFormField(
                            initialValue: _respostaForm.resposta,
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
                              _respostaForm.resposta = text;
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
                                      onPressed: () => Navigator.pushReplacementNamed(
                                          context,
                                          "/resposta",
                                          arguments: [duvida, topico]
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
                                      onPressed: () => _enviarForm(context),
                                    )
                                  ])
                          )
                        ],
                      ),
                    )
                )
            )
        )
    );
  }

  void _carregarUsuarioSessao() async {
    _usuarioSessao = await FlutterSession().get("usuario");
  }

  void _enviarForm(context) {
    if (_formResposta.currentState.validate()) {
      _formResposta.currentState.save();

      _respostaForm.pessoaCadastro =
          TipoDTO(id: _usuarioSessao["id"], nome: _usuarioSessao["nome"]);

      try {
        _respostaRepository.salvar(_respostaForm);
        Navigator.pushReplacementNamed(
            context,
            "/resposta",
            arguments: [duvida, topico]
        );
      } catch (err) {
        print("Deu ruim | $err");
      }
    }
  }
}
