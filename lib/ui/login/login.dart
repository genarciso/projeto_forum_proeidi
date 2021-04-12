import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _usuario;
  String _senha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade100,
      body: SingleChildScrollView(
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
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(fontSize: 25),
                        prefixIcon: Icon(
                          Icons.person_outline_outlined,
                          size: 25,
                        ),
                        labelText: 'Usuário',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (text) {
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
                  child: TextField(
                    obscureText: true,
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
                    // TODO: Verificação do login
                    if (_usuario == 'admin' && _senha == '123') {
                      Navigator.of(context).pushNamed('/duvida');
                    }
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
                  onPressed: () {},
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
    );
  }
}
