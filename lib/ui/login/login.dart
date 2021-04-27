import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:projeto_forum_proeidi/domain/usuario.model.dart';
import 'package:projeto_forum_proeidi/repository/login.repository.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _form  = new GlobalKey();
  LoginRepository _loginRepository;
  bool _validacao = false;
  String _usuario;
  String _senha;

  @override
  void initState() {
    _loginRepository = new LoginRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade100,
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          autovalidateMode: _validacao ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.cyan.shade50,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.length == 0) {
                          return "Campo Obrigatório";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 25),
                          prefixIcon: Icon(
                            Icons.person_outline_outlined,
                            size: 25,
                          ),
                          labelText: 'Usuário',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onSaved: (text) {
                        _usuario = text;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.cyan.shade50,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value.length == 0) {
                          return "Campo Obrigatório";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            size: 25,
                          ),
                          labelStyle: TextStyle(fontSize: 25),
                          labelText: 'Senha',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onChanged: (text) {
                        _senha = text;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _enviarForm();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.green.shade400;
                          return Colors.green.shade300;
                        },
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text('Entrar',
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                    ),
                  ),
                  Divider(color: Colors.black, height: 50),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.amber.shade700;
                          return Colors
                              .amber.shade600; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {Navigator.of(context).pushNamed("/perfil/form");},
                    child: Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text('Cadastrar-se',
                            style: TextStyle(fontSize: 25, color: Colors.white))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _enviarForm() async {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      try {
        var session = FlutterSession();
        var response = await _loginRepository.autenticar(_usuario, _senha);
        if (response.statusCode == 200) {
          await session.set("token", response.data["token"]);
          await session.set("papel", response.data["papel"]);
          await session.set("usuario", UsuarioModel.fromJson(response.data["usuario"]));
          await session.set("errorMessage", response.data["errorMessage"] != null ? response.data["errorMessage"] : "");
          await session.set("isOK", true);
          Navigator.of(context).pushReplacementNamed('/topico');

        } else if (response.statusCode == 401) {
          await session.set("isOK", false);
          showDialog(context: context,
            builder: (context){
              return AlertDialog(
                  title:Text("Erro"),
                  content: Text("Login e/ou Senha inválido(s)"),
                  actions : <Widget>[
                    TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
                        }
                    )
                  ]
              );
            },
          );
        } else {
          await session.set("isOK", false);
          showDialog(context: context,
            builder: (context){
              return AlertDialog(
                  title:Text("Erro"),
                  content: Text("Problema ao se conectar com o servidor. Tente novamente!"),
                  actions : <Widget>[
                    TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
                        }
                    )
                  ]
              );
            },
          );
        }
      } catch (err) {
        print("Deu ruim | $err");
      }
    } else {
      setState(() {
        _validacao = true;

      });

    }
  }
}
