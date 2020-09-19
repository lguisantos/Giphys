import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import './giphyDetail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;
  int _offset = 0;

  Future<Map> _getGiphyAPI() async {
    http.Response response;
    String urlBestGiphys =
        "https://api.giphy.com/v1/gifs/trending?api_key=jTk5wr1rWEaRpD52JmWYF7fbLeT43TkN&limit=20 0&rating=g";
    String urlSearchGiphys =
        "https://api.giphy.com/v1/gifs/search?api_key=jTk5wr1rWEaRpD52JmWYF7fbLeT43TkN&q=$_search&limit=25&offset=$_offset&rating=g&lang=pt";

    if (_search == null)
      response = await http.get(urlBestGiphys);
    else
      response = await http.get(urlSearchGiphys);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    String appBarLogo =
        "https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Image.network(appBarLogo), backgroundColor: Colors.black),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _offset = 0;
                });
              },
              decoration: InputDecoration(
                labelText: "Pesquise aqui",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          //Expanded => Expecifica que o conteúdo vai pegar toda a largura da tela
          Expanded(
            //FutureBuilder => Quando temos um conteúdo que é carregado de forma assíncrona, temos que colocar este Widget
            child: FutureBuilder(
              future: _getGiphyAPI(),
              //O que será renderizado após o termino da chamada da função future
              builder: (context, snapshot) {
                //Controlando os estados do app
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      //Criando uma animação de carregamento
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      // renderiza uma tela de erro
                      return Container();
                    else
                      return _createGiphyGrid(context, snapshot);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  int _getCount(List data) {
    if (_search == null)
      return data.length;
    else
      return data.length + 1;
  }

  Widget _createGiphyGrid(BuildContext context, AsyncSnapshot snapshot) {
    // renderiza a nossa tabela na tela
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      //Controlando o formato da tabela
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      //Controlando a quantidade de item que serão exibidos
      itemCount: _getCount(snapshot.data["data"]),
      //Controlando o que será exibido
      itemBuilder: (context, index) {
        if (_search == null || index < snapshot.data["data"].length)
          //Widget para entender ações do usuário na tela
          return GestureDetector(
              child: Image.network(
                snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                height: 300.0,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GiphyDetail(snapshot.data["data"][index]),
                  ),
                );
              },
          onLongPress: (){
                Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
          },);
        else
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 70.0),
                  Text(
                    "Carregar Mais...",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  _offset += 19;
                });
              },
            ),
          );
      },
    );
  }
}
