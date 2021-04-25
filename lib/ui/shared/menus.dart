import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_session/flutter_session.dart';

class MenuApp extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
          height: 50,
          width: 100,
          child: Image.asset('assets/images/logo-sem-nome.png')
      ),
      centerTitle: true,
      actions: [
        SairMenu()
      ],
    );
  }

  @override
  Size get preferredSize => new AppBar().preferredSize;
}

class MenuLateral extends StatelessWidget {

  Future<dynamic> usuarioSessao =  FlutterSession().get("usuario");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: usuarioSessao,
      builder:(index, snapshot) {
        return Drawer(
          child: Material(
            color: Colors.cyan,
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                    currentAccountPicture: Icon(Icons.account_circle_outlined, size: 80, color: Colors.white),
                    accountName: Text(snapshot.data != null ? snapshot.data["nome"] : "",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        )
                    ),
                    accountEmail: Text(snapshot.data != null ? snapshot.data["email"] : "",
                        style: TextStyle(
                          color: Colors.white,
                        )
                    )
                ),
                Divider(height: 15, color: Colors.black,),
                ListTile(
                  leading: Icon(Icons.account_circle_outlined, size: 20, color: Colors.white),
                  title: Text('Meu perfil',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      )
                  ),
                  onTap: () {

                  },
                ),
                Divider(height: 15, color: Colors.black,),
                // ListTile(
                //   leading: Icon(Icons.insert_comment_outlined, size: 20, color: Colors.white),
                //   title: Text('Minhas dúvidas',
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 20
                //     ),
                //   ),
                //   onTap: () {
                //
                //   },
                // ),
                // Divider(height: 15, color: Colors.black,),
                // ListTile(
                //   leading: Icon(Icons.question_answer_outlined, size: 20, color: Colors.white),
                //   title: Text('Minhas respostas',
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 20
                //     ),
                //   ),
                //   onTap: () {
                //
                //   },
                // ),
                // Divider(height: 15, color: Colors.black,),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SairMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          // Limpar sessão
          FlutterSession().set("token", "");
          FlutterSession().set("papel", "");
          FlutterSession().set("usuario", "");
          FlutterSession().set("errorMessage", "");
          FlutterSession().set("isOK", false);
          Navigator.of(context).pushReplacementNamed('/');
        },
        child: Icon(
          Icons.power_settings_new_outlined,
          size: 25,
        )
    );
  }
}



