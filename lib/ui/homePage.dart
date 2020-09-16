import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:giphy/main.dart';
import 'package:flutter/src/semantics/semantics.dart';
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
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=jTk5wr1rWEaRpD52JmWYF7fbLeT43TkN&limit=20&rating=g");
    else
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=jTk5wr1rWEaRpD52JmWYF7fbLeT43TkN&q=dogs&limit=25&offset=0&rating=g&lang=pt");

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
   // String appBarLogo = ;
    return Scaffold(
      appBar: AppBar(
        title: Image.network("https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
      ),
    );
  }
}
