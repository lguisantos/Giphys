import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GiphyDetail extends StatelessWidget {
  final Map _giphyData;

  GiphyDetail(this._giphyData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
              onPressed: (){
              //Este plugin deve ser instalado no pubspec.yaml
              Share.share(_giphyData["images"]["fixed_height"]["url"]);
              },
          )
        ],
        title: Text(_giphyData["title"]),
      ),
      body: Center(
        child: Image.network(
          _giphyData["images"]["fixed_height"]["url"],
        ),
      ),
    );
  }
}
