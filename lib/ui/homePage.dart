import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search;

  // String urlBestGiphys =     ;
  // String urlSearchGiphys =      ;

  Future<Map> _getGiphyAPI() async {
    http.Response response;

    if (search == null)
      response = await http.get(
          "https://api.giphy.com/v1/gifs/trending?api_key=jTk5wr1rWEaRpD52JmWYF7fbLeT43TkN&limit=20&rating=g");
    else
      response = await http.get(
          "https://api.giphy.com/v1/gifs/search?api_key=jTk5wr1rWEaRpD52JmWYF7fbLeT43TkN&q=dogs&limit=25&offset=0&rating=g&lang=pt");

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    // String appBarLogo = ;
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif",
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise aqui",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          //Expanded => Expecifica que o conteúdo vai pegar toda a largura da tela
          Expanded(
            //FutureBuilder => Quando temos um conteúdo que é carregado de forma assíncrona, temos que colocar este Widget
            child: FutureBuilder(
              future: _getGiphyAPI(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  // ignore: missing_return,
                  default:
                    if (snapshot.hasError)
                      return Container();
                    else _createGiphyGrid(context, snapshot);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _createGiphyGrid(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      child: Text("Fica para a próxima aula!"),
    );
  }
}
