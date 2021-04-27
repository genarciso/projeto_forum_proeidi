import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:projeto_forum_proeidi/domain/pessoa.model.dart';
import 'package:projeto_forum_proeidi/repository/pessoa.repository.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';

class PerfilFormPage extends StatelessWidget {
  PessoaRepository _pessoaRepository;
  GlobalKey<FormState> _form  = new GlobalKey();
  bool _validacao = false;
  PessoaModel _pessoaForum;

  PerfilFormPage() {
    _pessoaForum = PessoaModel();
    _pessoaRepository = PessoaRepository();
  }
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context).settings.arguments !=  null) {
      _pessoaForum = ModalRoute.of(context).settings.arguments;
    }
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
                        child: Text(_pessoaForum.id == null ? 'Cadastrar usuário' : 'Editar usuário',
                            style: TextStyle(
                                fontSize: 30
                            )
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nome',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        initialValue: _pessoaForum.nome,
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
                          _pessoaForum.nome = text;
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        initialValue: _pessoaForum.email,
                        keyboardType: TextInputType.emailAddress,
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
                          _pessoaForum.email = text;
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Data de nascimento',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      MaterialButton(
                        color: Colors.lightBlue[50],
                        minWidth: MediaQuery.of(context).size.width,
                        child: Text(
                          'Selecione...',
                          style: TextStyle(
                            fontSize: 20
                          ),
                          textAlign: TextAlign.left,
                        ),
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            locale: LocaleType.pt,
                            currentTime: _pessoaForum.dataNascimento != null ? _pessoaForum.dataNascimento : DateTime.now(),
                            minTime: DateTime(1920),
                            maxTime: DateTime(2022),
                            theme: DatePickerTheme(
                              headerColor: Colors.cyan[100],
                              backgroundColor: Colors.cyan[50],
                              containerHeight: 300,
                              itemStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25),
                              doneStyle: TextStyle(color: Colors.lightGreen, fontSize: 20),
                              cancelStyle: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            onConfirm: (data) {
                              _pessoaForum.dataNascimento = data;
                            }
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Usuário',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        initialValue: _pessoaForum.usuario,
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
                          _pessoaForum.usuario = text;
                        },
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Senha',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        obscureText: true,
                        initialValue: _pessoaForum.senha,
                        validator: (value) {
                          if (_pessoaForum.id == null) {
                            if (value.length == 0) {
                              return "Campo Obrigatório";
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.lightBlue[50],
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.all(25)),
                        onSaved: (text) {
                          if (text != "") {
                            _pessoaForum.senha = text;
                          }
                        },
                      ),
                      SizedBox(height: 15),
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
                                  onPressed: () => {
                                    if (_pessoaForum.id == null) {
                                      Navigator.of(context).pushReplacementNamed('/')
                                    } else {
                                      Navigator.of(context).pushReplacementNamed('/topico')
                                    }
                                  },
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

  void _enviarForm(context) {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      try {
        _pessoaRepository.salvar(_pessoaForum);
        if (_pessoaForum.id == null) {
          Navigator.of(context).pushReplacementNamed('/');
        } else {
          FlutterSession().set("usuario", _pessoaForum);
          Navigator.of(context).pushReplacementNamed('/topico');
        }

      } catch (err) {
        print("Deu ruim | $err");
      }
    }
  }
}
