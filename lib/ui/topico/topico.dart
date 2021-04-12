import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_forum_proeidi/ui/shared/menus.dart';

class TopicoPage extends StatefulWidget {
  @override
  _TopicoPageState createState() => _TopicoPageState();
}

class _TopicoPageState extends State<TopicoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(),
      appBar: MenuApp(),
      backgroundColor: Colors.cyan.shade100,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MaterialButton(
                        onPressed: () {

                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.orange.shade300,
                        child: Text('Tópico', style: TextStyle(
                            color: Colors.white
                        ),),
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
                          onPressed: () => {},
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
                                  )
                              ),
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
                                        // height: 50,
                                        // child: Autocomplete(
                                        //   displayStringForOption: _displayStringForOption,
                                        //   optionsBuilder: _optionsBuilder,
                                        //   onSelected: (Duvida selection) {
                                        //     print(
                                        //         'You just selected ${_displayStringForOption(selection)}');
                                        //   },
                                        // ),
                                      )
                                  )
                                ],
                              )
                          )
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return itemLista();
                        }),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }

  Widget itemLista() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      height: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.cyan.shade50),
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Text',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    'Tasdasdasd ad a adsadas dasdaav vsdv fsdfasd fdsfsafas da dad ada dadada fsdfdsfsd sdfsdfsdf sdf s',
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
                margin: EdgeInsets.only(bottom: 5),
                height: 25,
                width: 120,
                child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () => {},
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye),
                        SizedBox(width: 2,),
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
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25)),
                child: MaterialButton(
                    color: Colors.yellow,
                    onPressed: () => {},
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
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25)),
                child: MaterialButton(
                    color: Colors.red,
                    onPressed: () => {},
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
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25)),
                child: MaterialButton(
                    color: Colors.orange,
                    onPressed: () => {},
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

}
